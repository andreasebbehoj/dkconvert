*! version 1.1.0 17aug2020
program define dkconvert
version 13
syntax varlist(max=1), From(namelist) ///
	[To(namelist) Labelonly ] ///
	[replace GENerate(namelist) assert] 

*** Check dependent ado's are installed
capture which labmask
if _rc==111 {
    di as error "dkconvert requires labmask to run. Install by typing:" _n "ssc install labutil"
	exit
}

*** Check syntax input
* only one variable
confirm int variable `varlist'

* generate / replace
if !mi("`generate'") {
	confirm new var `generate'
}
if !mi("`replace'") & !mi("`generate'") {
    di as error "replace and generate() cannot be specified at the same time."
	exit
}
if mi("`replace'") & mi("`generate'") & mi("`labelonly'") { 
    di as error "Either replace or generate() must be specified when converting from(`from') to(`to')."
	exit
}

* Confirm valid to/from options
if inlist("`from'", "oldkom", "newkom")==0 {
	di as error "Invalid from() option. Must be oldkom or newkom."
	exit
}
if inlist("`to'", "newkom", "county", "region", "")==0 {
		di as error "Invalid to() option. Must be newkom, county, region, or blank."
		exit
	}

* Confirm only label() OR to() have been specified
if !mi("`labelonly'") & !mi("`to'") { 
	di as error "labelonly and to() cannot be specified at the same time." //
	exit
	}
if mi("`labelonly'") & mi("`to'") { 
	di as error "Either labelonly or to() must be specified." //
	exit
	}
* Rules for to/from conversion
if "`to'"!="" {
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
	if "`from'"=="`to'" {
		di as error "Specified conversion from(`from') and to(`to'), i.e. same variable."
		exit
	}
}


*** Load convert table as frame
preserve
tempfile converttable
qui: sysuse dkconvert_table.dta, clear

* Converting from/to
if !mi("`to'") {
	keep `from' `to' `to'_name
	order `from' `to' `to'_name
}

* Adding value label only
if !mi("`labelonly'") {
	keep `from' `from'_name
	order `from' `from'_name
}

qui: duplicates drop
rename `from' `varlist'
qui: save `converttable', replace


*** Merge with data
restore
qui: merge m:1 `varlist' using `converttable', keep(match master) generate(convertmatch)

qui: levelsof convertmatch if convertmatch==1
if !mi("`r(levels)'") {
	di as error "The following values of `varlist' do not match a known `from' value:" ///
		_n "`r(levels)'"
	if !mi("`assert'") {
		di "Assert failed, program terminated"
		exit
	}
}
drop convertmatch

*** Replace, generate, or add label
if !mi("`labelonly'") {
    labmask `varlist', values(`from'_name) lblname(_`varlist')
	drop `from'_name
	exit
}
if !mi("`replace'") {
    drop `varlist'
	rename `to' `varlist'
	labmask `varlist', values(`to'_name) lblname(_`varlist')
	drop `to'_name
	exit
}
else {
    rename `to' `generate'
	labmask `generate', values(`to'_name) lblname(_`generate')
	drop `to'_name
	exit
}

end
