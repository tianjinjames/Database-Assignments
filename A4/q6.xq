for $coach in doc("teams.xml")//team

for $team in doc("teams.xml")//team[./player/@pid = $coach/coach/@cid]


for $player in doc("players.xml")//player[./@pid = $team/coach/@cid]


where ($team/@tid = $coach/@tid)

return <result> {$player/@fname}{$player/@lname}{$player/salary}{$team//name} </result> 
