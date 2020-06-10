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
{synopt:{opt f:ormat}}use variable's display format{p_end}
{synopt:{opt sep:arator(#)}}draw separator line after every {it:#} variables;
        default is {cmd:separator(5)}{p_end}
{syntab:Optional}
{synopt:{opth gen:erate(newvar)}}create new variable with to()  {it:newvar}{p_end}
{synoptline}
{p2colreset}{...}

{title:Description}

{pstd}
{cmd:dkconvert} converts c_kom to c_amt or c_region or from old (pre-2007) c_kom to new c_kom.


{title:Options}

{dlgtab:Main}

{phang}
{opt detail} displays detailed output of the calculation.

{phang}
{opt meanonly} restricts the calculation to be based on only the means.  The
default is to use a trimmed mean.

{phang}
{opt format} requests that the summary statistics be displayed using
the display formats associated with the variables, rather than the default
{cmd:g} display format; see
{findalias frformats}.

{phang}
{opt separator(#)} specifies how often to insert separation lines
into the output.  The default is {cmd:separator(5)}, meaning that a
line is drawn after every 5 variables.  {cmd:separator(10)} would draw a line
after every 10 variables.  {cmd:separator(0)} suppresses the separation line.

{phang}
{opth generate(newvar)} creates {it:newvar} containing the whatever
values.

{title:Remarks}
For more details, see readme at https://github.com/andreasebbehoj/dkconvert

{pstd}
For detailed information on the whatever statistic, see
{manlink R Intro}.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. whatever mpg weight}{p_end}

{phang}{cmd:. whatever mpg weight, meanonly}{p_end}
