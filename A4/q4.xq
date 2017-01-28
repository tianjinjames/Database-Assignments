for $teams in doc("matches.xml")//teams
let $team := $teams/team
for $teamA in $team, $teamB in ($team[./score < $teamA/score])
for $pid in doc("teams.xml")//team[./@tid = $teamB/@tid]/player/@pid
for $player in doc("players.xml")//player[./@pid = $pid]
where $player/salary > 100000
return <result>{$player/@pid}</result>
