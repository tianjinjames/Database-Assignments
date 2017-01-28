(: <!ELEMENT Stats (Bar*)>
<!ELEMENT Bar EMPTY>
<!ATTLIST Bar teamname CDATA #REQUIRED>
<!ATTLIST Bar count CDATA #REQUIRED>


Example

<Stats>
	<Bar teamid = "" count = "">
	</Bar>
	<Bar teamid = "" count = "">
	</Bar>
	<Bar teamid = "" count = "">
	</Bar>
	<Bar teamid = "" count = "">
	</Bar>
	...
</Stats>

1. loop through all the teams
2. find how many number of matches each team played
3. print the lines :)

<Stats>
{

let $match := doc("matches.xml")//match[.//@year = '2014']
for $team in doc("teams.xml")//team
let $count := count($match[.//@tid = $team//@tid ] ) 

return <Bar teamname = "{$team//name}" count = "{$count}" ></Bar>
}
</Stats>


