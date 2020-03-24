SELECT 
a.id, a.name
FROM all_actor a
INNER JOIN all_movie_actor ma
	ON a.id = ma.actor
INNER JOIN all_movie m
	ON m.id = ma.movie
WHERE a.name LIKE 'Ja%'
	AND m.genre = 'Non-Comedy'
GROUP BY a.id, a.name