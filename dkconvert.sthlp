{smcl}
{* *! version 1.0.0  10jun2020}{...}
{title:dkconvert}

{phang}
{bf:dkconvert} {hline 2} Convert Danish municipalities to regions/counties or from old to new municipalities


{title:Syntax}

{p 8 17 2}
{cmdab:dkconvert}
{varname}
{cmd:,} {it:assert}

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt f:rom}}converted from (oldkom|newkom) {p_end}
{synopt:{opt t:o}}converted to (newkom|county|region) {p_end}
{synopt:*{opth gen:erate(newvar)}}creates  {it:newvar} containing the to() values and value labels {p_end}
{synopt:*{opt replace}}replace {it:varname} with the to() values and value labels {p_end}
{synoptline}
{syntab:Optional}
{synopt:{opt assert}}require all values in varname to match a valid code and terminates program if not {p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* Either {cmd:replace} or {cmd:generate}() must be specified.{p_end}


{title:Description}

{pstd}
{cmd:dkconvert} converts c_kom to c_amt or c_region or convert from old c_kom(pre-2007) to new c_kom. The program automatically labels resulting values.


{title:Remarks}

{pstd}
For more details, see readme at https://github.com/andreasebbehoj/dkconvert


{marker examples}{...}
{title:Examples}

{phang}{cmd:. whatever mpg weight}{p_end}

{phang}{cmd:. whatever mpg weight, meanonly}{p_end}
