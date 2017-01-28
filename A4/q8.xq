for $matches in doc("matches.xml")//match
let $team := $matches//team
for $teamA in $team, $teamB in ($team[./score < $teamA/score])
let $budgetA := number(doc("teams.xml")//team[./@tid = $teamA/@tid]/budget)
let $budgetB := number(doc("teams.xml")//team[./@tid = $teamB/@tid]/budget)
where ($budgetB > $budgetA)
return <result>{$matches//@mid}</result>
