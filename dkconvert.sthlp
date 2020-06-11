{smcl}
{* *! version 1.0.0  10jun2020}{...}
{title:dkconvert}

{phang}
{bf:dkconvert} {hline 2} Convert Danish municipalities to regions/counties or from old to new municipalities


{title:Syntax}

{p 8 17 2}
{cmdab:dkconvert}
{varname}
{cmd:,}
{cmdab:f:rom}(oldkom|newkom)
{cmdab:t:o}(newkom|county|region)
({cmd:replace}|{cmdab:gen:erate}(newvar)
[{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt f:rom}}converted from (oldkom|newkom) {p_end}
{synopt:{opt t:o}}converted to (newkom|county|region) {p_end}
{p2coldent:* {opth gen:erate(newvar)}}creates  {it:newvar} containing the to() values and value labels {p_end}
{p2coldent:* {opt replace}}replace {it:varname} with the to() values and value labels {p_end}
{syntab:Optional}
{synopt:{opt assert}}require all values in varname to match a valid code and terminates program if not {p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* Only specify either {cmd:replace} or {cmd:generate}().{p_end}


{title:Description}

{pstd}
{cmd:dkconvert} can either converts c_kom to c_amt/c_region or convert old c_kom values (pre-2007) to new ones (after structural reform 2007). Results are automatically labeled.

{title:Remarks}

{pstd}
For more details, including how to update, see {browse "https://github.com/andreasebbehoj/dkconvert": the readme.md at GitHub}


{title:Examples}
Download example data from Statistics Denmark API - Danish population from 1990 to 1995 by municipality:

. copy "https://api.statbank.dk/v1/data/BEF1/CSV?lang=en&valuePresentation=Code&Tid=%3E%3D1990%3C%3D1995&Omr%C3%A5de=101%2C147%2C165%2C151%2C153%2C155%2C157%2C159%2C161%2C163%2C167%2C169%2C183%2C171%2C173%2C175%2C181%2C185%2C187%2C189%2C201%2C205%2C207%2C208%2C209%2C211%2C213%2C215%2C217%2C219%2C221%2C223%2C225%2C227%2C229%2C231%2C233%2C235%2C237%2C251%2C253%2C255%2C257%2C259%2C261%2C263%2C265%2C267%2C269%2C271%2C301%2C303%2C305%2C307%2C309%2C311%2C313%2C315%2C317%2C319%2C321%2C323%2C325%2C327%2C329%2C331%2C333%2C335%2C337%2C339%2C341%2C343%2C345%2C351%2C353%2C355%2C357%2C359%2C361%2C363%2C365%2C367%2C369%2C371%2C373%2C375%2C377%2C379%2C381%2C383%2C385%2C387%2C389%2C391%2C393%2C395%2C397%2C401%2C403%2C405%2C407%2C409%2C411%2C421%2C423%2C425%2C427%2C429%2C431%2C433%2C435%2C437%2C439%2C441%2C443%2C445%2C447%2C449%2C451%2C461%2C471%2C473%2C475%2C477%2C479%2C481%2C483%2C485%2C487%2C489%2C491%2C492%2C493%2C495%2C497%2C499%2C501%2C503%2C505%2C507%2C509%2C511%2C513%2C515%2C517%2C519%2C521%2C523%2C525%2C527%2C529%2C531%2C533%2C535%2C537%2C539%2C541%2C543%2C545%2C551%2C553%2C555%2C557%2C559%2C561%2C563%2C565%2C567%2C569%2C571%2C573%2C575%2C577%2C601%2C603%2C605%2C607%2C609%2C611%2C613%2C615%2C617%2C619%2C621%2C623%2C625%2C627%2C629%2C631%2C651%2C653%2C655%2C657%2C659%2C661%2C663%2C665%2C667%2C669%2C671%2C673%2C675%2C677%2C679%2C681%2C683%2C685%2C701%2C703%2C705%2C707%2C709%2C711%2C713%2C715%2C717%2C719%2C721%2C723%2C725%2C727%2C729%2C731%2C733%2C735%2C737%2C739%2C741%2C743%2C745%2C747%2C749%2C751%2C761%2C763%2C765%2C767%2C769%2C771%2C773%2C775%2C777%2C779%2C781%2C783%2C785%2C787%2C789%2C791%2C793%2C801%2C803%2C805%2C807%2C809%2C811%2C813%2C815%2C817%2C819%2C821%2C823%2C825%2C827%2C829%2C831%2C833%2C835%2C837%2C839%2C841%2C843%2C845%2C847%2C849%2C851%2C861" "test.csv", replace

. import delimited "test.csv", clear encoding(UTF-8)

. rename område c_kom


Convert and replace old municipality codes with new codes:

. dkconvert c_kom, from(oldkom) to(newkom) replace assert


Generate new variable with corresponding regions:

. dkconvert c_kom, from(newkom) to(region) gen(c_reg) assert


{title:Author}

{pstd}
Andreas Ebbehoj, MD & PhD student, Aarhus University, Denmark
