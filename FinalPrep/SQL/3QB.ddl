SELECT firstname, lastname
FROM staff AS staff1
WHERE salary > (SELECT staff2.salary FROM staff AS staff2 WHERE staff1.managerid = staff2.employeeid)




