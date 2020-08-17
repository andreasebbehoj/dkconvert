{smcl}
{* *! version 1.1.0  17aug2020}{...}
{title:dkconvert}

{phang}
{bf:dkconvert} {hline 2} Convert old Danish municipality codes (c_kom) from before the Structural Reform (Kommunalreformen) in 2007 to county (c_amt), region (c_reg) or new municipality codes, and add value labels.


{title:Syntax}

Convertold/new municipality in {it:varname} to new municipality, county, or region
{p 8 17 2}
{cmdab:dkconvert}
{varname}
{cmd:,}
{cmdab:f:rom}(oldkom|newkom)
{cmdab:t:o}(newkom|county|region)
[{cmd:replace}|{cmdab:gen:erate}(newvar)]
[{it:other options}]

Only add value label to {it:varname} for municipality, county, or region code.
{p 8 17 2}
{cmdab:dkconvert}
{varname}
{cmd:,}
{cmdab:f:rom}(oldkom|newkom|county|region)
{cmdab:l:abelonly}
[{it:other options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Options for convert to()}
{synopt:{opt f:rom}()}type of varname to be converted from ({it:oldkom}|{it:newkom}) {p_end}
{synopt:{opt t:o}()}convert to ({it:newkom}|{it:region}). {it:oldkom} can also be converted to {it:county} {p_end}
{p2coldent:* {opth gen:erate(newvar)}}creates  {it:newvar} containing the to() values and value labels {p_end}
{p2coldent:* {opt replace}}replace {it:varname} with the to() values and value labels {p_end}

{syntab:Options for labelonly}
{synopt:{opt f:rom}()}type of varname to add value label to ({it:oldkom}|{it:newkom}|{it:region}|{it:county}) {p_end}

{syntab:Other options}
{synopt:{opt assert}}require all values in varname to match a valid code and terminates program if it does not {p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* Only specify either {cmd:replace} or {cmd:generate}(). Do not work with the {cmd:labelonly} option.{p_end}


{title:Description}

{pstd}
{cmd:dkconvert} was made to make it easier to handle Danish municipality codes, region codes etc in epidemiological research using Danish registries, and especially for converting old municipalities from before the Structural Reform ("Kommunalreformen") in 2007 to newer municipality codes or regions.

{pstd}
{cmd:dkconvert} can:

{pstd}
1) convert old municipality codes to new municipality codes (or to the previous county codes),

{pstd}
2) convert old or new municipality codes to region codes, or

{pstd}
3) simply add value labels to  municipalities (both new and old), county codes and region codes.


{title:Examples}
Download example poppulation data from Statistics Denmark from a couple of municipalities in 1977:

. copy "https://api.statbank.dk/v1/data/bef1/CSV?valuePresentation=Code&OMR%C3%85DE=101%2C605%2C807%2C843&Tid=1979" "dkconvert_test.csv", replace

. import delimited "dkconvert_test.csv", clear encoding(UTF-8)

. rename område c_kom

Convert old municipality codes and generate a variable with the new municipality codes:

. dkconvert c_kom, from(oldkom) to(newkom) gen(newcodes) assert


Replace municipality codes with corresponding regions:

. dkconvert c_kom, from(newkom) to(region) replace assert


{title:Remarks}

{pstd}
For details on how to update or uninstall, see {browse "https://github.com/andreasebbehoj/dkconvert": the readme.md at GitHub}


{title:Author}

{pstd}
Andreas Ebbehoj, MD & PhD student, Aarhus University, Denmark
