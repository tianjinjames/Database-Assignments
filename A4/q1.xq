for $a in (doc("players.xml")//player)
	where $a/nationality[count(country) > 1]

return
        <result>
            {$a/@fname, $a/@lname}
        </result>



