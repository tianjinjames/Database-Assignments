for $team in doc("teams.xml")//team
let $budget := $team/budget
let $pids := $team/player/@pid
let $cost := sum(doc("players.xml")//player[./@pid = $pids]/salary)
where $cost > $budget
return $team/name
