-- Query1
INSERT INTO Query1 (SELECT * FROM bestRatioPlayerTeam); 

-- Query2
INSERT INTO Query2
SELECT name, COUNT(pid) AS num
FROM player JOIN club ON (player.fcid = club.fcid)
GROUP BY name
ORDER BY COUNT(pid) DESC
LIMIT 3;

-- Query3
INSERT INTO Query3
	Values(EXISTS(SELECT * FROM earliestMatchList INTERSECT SELECT * FROM brazil));

-- Query4
INSERT INTO Query4(
	SELECT DISTINCT mid1
	FROM matchTicket1 JOIN matchTicket2 ON (tid1 <> tid2) AND (mid1 = mid2)
	ORDER BY mid1 DESC);

-- Query5
INSERT INTO Query5(
	SELECT name
	FROM countryCompetesName JOIN match ON countryCompetesName.mid = match.mid
	GROUP BY name
	HAVING count(DISTINCT sid) = (SELECT count(sid) FROM stadium));

-- Query6
INSERT INTO Query6(
	SELECT pid, fname, lname, avgMinute AS minutes
	FROM playerAppearance JOIN countryMatchCount ON playerAppearance.cid = countryMatchCount.cid
	WHERE avgMinute > 75
	GROUP BY pid, playerAppearance.fname, playerAppearance.lname, playerAppearance.avgMinute, playerAppearance.count, countryMatchCount.count
	HAVING playerAppearance.count = countryMatchCount.count
	ORDER BY minutes DESC);

-- Query7
INSERT INTO Query7(
	SELECT name, coach, budget
	FROM countryLowestBudgetTopScorer JOIN country ON (countryLowestBudgetTopScorer.cid = country.cid));
