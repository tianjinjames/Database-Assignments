-- Query1
CREATE VIEW worstRatioPlayer AS 
	SELECT p1.pid AS pid, p1.fname AS fname, p1.lname AS lname, p1.cid AS cid
	FROM player p1, player p2
	WHERE (p1.value/p1.goals) > (p2.value/p2.goals);
			
CREATE VIEW bestRatioPlayer AS
	SELECT pid, fname, lname, cid FROM player
	EXCEPT
	SELECT pid, fname, lname, cid FROM worstRatioPlayer;

CREATE VIEW bestRatioPlayerTeam AS
	SELECT fname, lname, name AS country
	FROM bestRatioPlayer JOIN country ON bestRatioPlayer.cid = country.cid;

CREATE TABLE Query1(
	fname	VARCHAR(20),
	lname	VARCHAR(20),
	country	VARCHAR(20)
);

-- Query2
CREATE TABLE Query2(
	name	VARCHAR(20),
	num	INTEGER
);

-- Query3
CREATE VIEW earliestMatch AS
	SELECT country1, country2
	FROM match JOIN competes ON (match.mid = competes.mid)
	ORDER BY date ASC, time ASC
 	LIMIT 1;

CREATE VIEW earliestMatchList AS
	SELECT country1 AS cid FROM earliestMatch
	UNION
	SELECT country2 AS cid FROM earliestMatch;

CREATE VIEW brazil AS
	SELECT cid FROM country WHERE name = 'Brazil';
	
CREATE TABLE Query3(
	isOpeningGame	BOOLEAN
);

-- Query4
CREATE VIEW matchTicket1 AS
	SELECT ticket.tid AS tid1, match.mid AS mid1
	FROM match JOIN ticket ON match.mid = ticket.mid AND match.date = ticket.dateIssued;

CREATE VIEW matchTicket2 AS
	SELECT ticket.tid AS tid2, match.mid AS mid2
	FROM match JOIN ticket ON match.mid = ticket.mid AND match.date = ticket.dateIssued;

CREATE TABLE Query4(
	mid	INTEGER
);

-- Query5
CREATE VIEW countryCompetes AS
	SELECT mid, country1 AS cid FROM competes
	UNION
	SELECT mid, country2 AS cid FROM competes;

CREATE VIEW countryCompetesName AS
	SELECT mid, name
	FROM countryCompetes JOIN country ON countryCompetes.cid = country.cid;

CREATE TABLE Query5(
	name VARCHAR(20)
);

-- Query6
CREATE VIEW countryMatchCount AS
	SELECT cid, COUNT(mid) AS count
	FROM countryCompetes
	GROUP BY cid;
	
CREATE VIEW playerAppearance AS
	SELECT player.pid AS pid, fname, lname, COUNT(mid) AS count, AVG(minutes) AS avgMinute, cid
	FROM player JOIN appearance ON player.pid = appearance.pid
	GROUP BY player.pid;

CREATE TABLE Query6(
	pid 	INTEGER,
	fname	VARCHAR(20),
	lname	VARCHAR(20),
	minutes	NUMERIC
);

-- Query7
CREATE VIEW topScorer AS
	SELECT cid, MAX(goals) AS scores
	FROM player
	GROUP BY cid;

CREATE VIEW maxScore AS
	SELECT MAX(scores) AS maxscore
	FROM topScorer;

CREATE VIEW topScorerTeam AS
	SELECT cid
	FROM topScorer JOIN maxScore ON (topScorer.scores = maxScore.maxscore);

CREATE VIEW budgetTeam AS
	SELECT cid, SUM(value) AS budget
	FROM player
	GROUP BY cid;

CREATE VIEW lowestBudget AS
	SELECT MIN(budget) AS minbudget
	FROM budgetTeam;

CREATE VIEW lowestBudgetTeam AS
	SELECT cid, minbudget AS budget
	FROM lowestBudget JOIN budgetTeam ON (lowestBudget.minbudget = budgetTeam.budget);

CREATE VIEW countryLowestBudgetTopScorer AS	
	SELECT topScorerTeam.cid AS cid, budget
	FROM topScorerTeam JOIN lowestBudgetTeam ON topScorerTeam.cid = lowestBudgetTeam.cid;

CREATE TABLE Query7(
	name 	VARCHAR(20),
	coach	VARCHAR(20),
	budget	INTEGER
);
