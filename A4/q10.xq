(:<!ELEMENT Stats (Bar*)>
<!ELEMENT Bar EMPTY>
<!ATTLIST Bar teamname CDATA #REQUIRED>
<!ATTLIST Bar count CDATA #REQUIRED>


Example

<Stats>
	<Bar country = "" count = "">
	</Bar>
	<Bar country = "" count = "">
	</Bar>
	<Bar country = "" count = "">
	</Bar>
	<Bar country = "" count = "">
	</Bar>
	...
</Stats>

1. loop through all the country
2. find how many number of team played for each country
3. print the lines:)

<Stats>
{
for $country in distinct-values(doc("teams.xml")//@country)
let $count := count(doc("teams.xml")//team[./@country = $country])
return <Bar country = "{$country}" count="{$count}"></Bar>
}
</Stats>
