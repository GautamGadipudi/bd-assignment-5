SELECT
a.id,
a.name
FROM all_actor a
INNER JOIN all_movie_actor ma
	ON a.id = ma.actor
INNER JOIN all_movie m
	ON m.id = ma.movie
WHERE COALESCE(a.deathyear, 0) = 0
	AND m.year >= 2000
	AND m.year <= 2005
GROUP BY ma.actor, a.id, a.name
HAVING COUNT(ma.movie) > 10