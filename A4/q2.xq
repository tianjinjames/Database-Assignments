let $players := doc("players.xml")//player

(:loop player based on first names:)
for $fname in distinct-values($players//@fname)

(:find a list of player with the same first names:)
let $playerfnames := $players[.//@fname = $fname]

(:find a list of last names of players with the same first names:)
let $lnames := $players[.//@fname = $fname]//@lname

(:find last names that show up more than once:)
for $lname in distinct-values($lnames)
where count($playerfnames[.//@lname = $lname]) > 1

(:return the combination of first name and last name:)
return <result>{concat($fname," ",$lname)}</result>
