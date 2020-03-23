--ComedyMovie non-materialized
CREATE OR REPLACE VIEW comedy_movie AS
(SELECT 
	m.id,
	m.title,
	m.startYear AS year
FROM movie m
LEFT JOIN movie_genre mg
	ON mg.movie = m.id
LEFT JOIN genre g
	ON g.id = mg.genre
WHERE m.runtime >= 75
	AND g.name = 'Comedy');
	
--NonComedyMovie non-materialized
CREATE OR REPLACE VIEW non_comedy_movie AS
(SELECT 
	m.id,
	m.title,
	m.startYear AS year
FROM movie m
WHERE m.runtime >= 75
	AND m.id NOT IN (SELECT id FROM comedy_movie));

--ComedyActor non-materialized
CREATE OR REPLACE VIEW comedy_actor AS
(SELECT m.*
FROM (SELECT 
		m.id
	FROM movie m
	LEFT JOIN movie_genre mg
		ON mg.movie = m.id
	LEFT JOIN genre g
		ON g.id = mg.genre
	WHERE g.name = 'Comedy') cm
INNER JOIN movie_actor ma
	ON cm.id = ma.movie
INNER JOIN member m
	ON m.id = ma.actor);
	
--NonComedyActors non-materialized
CREATE OR REPLACE VIEW non_comedy_actor AS
(SELECT * FROM 
member
WHERE id NOT IN (SELECT id FROM comedy_actor));

--ActedIn non-materialized
CREATE OR REPLACE VIEW acted_in AS
(SELECT actor, movie
FROM movie_actor);

--ComedyMovie materialized
CREATE MATERIALIZED VIEW comedy_movie_mat AS
(SELECT 
	m.id,
	m.title,
	m.startYear AS year
FROM movie m
LEFT JOIN movie_genre mg
	ON mg.movie = m.id
LEFT JOIN genre g
	ON g.id = mg.genre
WHERE m.runtime >= 75
	AND g.name = 'Comedy');
	
--NonComedyMovie materialized
CREATE MATERIALIZED VIEW non_comedy_movie_mat AS
(SELECT 
	m.id,
	m.title,
	m.startYear AS year
FROM movie m
WHERE m.runtime >= 75
	AND m.id NOT IN (SELECT id FROM comedy_movie_mat));

--ComedyActor materialized
CREATE MATERIALIZED VIEW comedy_actor_mat AS
(SELECT m.*
FROM (SELECT 
		m.id
	FROM movie m
	LEFT JOIN movie_genre mg
		ON mg.movie = m.id
	LEFT JOIN genre g
		ON g.id = mg.genre
	WHERE g.name = 'Comedy') cm
INNER JOIN movie_actor ma
	ON cm.id = ma.movie
INNER JOIN member m
	ON m.id = ma.actor);
	

--NonComedyActors materialized
CREATE MATERIALIZED VIEW non_comedy_actor_mat AS
(SELECT * FROM 
member
WHERE id NOT IN (SELECT id FROM comedy_actor_mat));

--ActedIn materialized
CREATE MATERIALIZED VIEW acted_in_mat AS
(SELECT actor, movie
FROM movie_actor);