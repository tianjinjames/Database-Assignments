for $a in doc("matches.xml")//location
where contains($a/city,$a/country)
return <result>{$a/city}{$a/country}</result>

