*! version 1.0.0 10jun2020
capture: program drop dkconvert
program define dkconvert
version 16.1
syntax varlist, [replace GENerate(namelist)] From(namelist) To(namelist) [assert]

*** Check syntax input
* varlist
confirm int variable `varlist'
local varno = wordcount("`varlist'")
if `varno'>1 {
    error 103
}

* generate / replace
if !mi("`generate'") {
	confirm new var `generate'
}
if !mi("`replace'") & !mi("`generate'") {
    di as error "Both replace and generate() specified"
	exit
}
if mi("`replace'") & mi("`generate'") {
    di as error "Either replace or generate() must be specified"
	exit
}

* from / to
confirm new var `from'
confirm new var `to'

if inlist("`from'", "region") {
    di as error "It is not possible to convert regions to municipalities or counties."
	exit
}
if inlist("`from'", "county") {
    di as error "It is not possible to convert counties to municipalities or regions."
	exit
}
if "`from'"=="newkom" & inlist("`to'", "oldkom", "county") {
    di as error "It is not possible to convert new municipalities back to the old municipalities or counties."
	exit
}
if inlist("`from'", "oldkom", "newkom")==0 {
    di as error "Invalid from() option. Must be oldkom or newkom"
	exit
}
if inlist("`to'", "newkom", "county", "region")==0 {
    di as error "Invalid to() option. Must be newkom, county, or region"
	exit
}
if "`from'"=="`to'" {
    di as error "Specified both from() and to() as `from'"
	exit
}

*** Check dependent ado's are installed
capture which labmask
if _rc==111 {
    di as error "This program requires labmask to run. Install by typing:" _n "ssc install labutil"
	exit
}

*** Load convert table as frame
preserve
tempfile converttable
qui: sysuse dkconvert_table.dta, clear
keep `from' `to' `to'_name
order `from' `to' `to'_name
qui: duplicates drop
rename `from' `varlist'
qui: save `converttable', replace

*** Add values
restore
tempvar convertmatch
qui: merge m:1 `varlist' using `converttable', keep(match master) generate(`convertmatch')
qui: levelsof `varlist' if `convertmatch'==1
if !mi("`r(levels)'") {
	di as error "The following values of `varlist' do not match a known `from' value"
	if !mi("`assert'") {
		di "Assert failed, program terminated"
		gen _merge_convert = `convertmatch'
		label value _merge_convert _merge
		tab _merge_convert
		exit
	}
}

*** Replace or generate
if !mi("`replace'") {
    drop `varlist'
	rename `to' `varlist'
	labmask `varlist', values(`to'_name) lblname(_`varlist')
	drop `to'_name
}
else {
    rename `to' `generate'
	labmask `generate', values(`to'_name) lblname(_`generate')
	drop `to'_name
}

di "complete"
end
