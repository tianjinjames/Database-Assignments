for $matches in doc("matches.xml")//match

let $teams := doc("teams.xml")//team[./@tid = $matches//team/@tid]

let $players := doc("players.xml")//player[./@pid = $teams//player/@pid]


return 
	<result>
		{$matches/@mid}married players: {count($players[.//@married = 'yes'])}
	</result>
