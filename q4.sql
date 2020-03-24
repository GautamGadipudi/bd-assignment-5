-- Expandng Q3.1 non-materialized views of source
-- Time to query: ~15min
SELECT
a.id,
a.name
FROM (
    (
        SELECT 
            id,
            name,
            birthyear,
            deathyear
        FROM 
        comedy_actor
    )
    UNION ALL
    (
        SELECT 
            id,
            name,
            birthyear,
            deathyear
        FROM 
        non_comedy_actor
    )
) a
INNER JOIN (
    SELECT * FROM acted_in
) ma
	ON a.id = ma.actor
INNER JOIN (
    (
        SELECT 
            id, 
            title, 
            year, 
            'Comedy' AS genre 
        FROM 
        comedy_movie
    )
    UNION ALL
    (
        SELECT 
            id, 
            title, 
            year, 
            'Non-Comedy' AS genre
        FROM 
        non_comedy_movie
    )
) m
	ON m.id = ma.movie
WHERE COALESCE(a.deathyear, 0) = 0
	AND m.year >= 2000
	AND m.year <= 2005
GROUP BY ma.actor, a.id, a.name
HAVING COUNT(ma.movie) > 10

-- Expandng Q3.1 materialized views of source
-- Time to query: 53sec
SELECT
a.id,
a.name
FROM (
    (
        SELECT 
            id,
            name,
            birthyear,
            deathyear
        FROM 
        comedy_actor_mat
    )
    UNION ALL
    (
        SELECT 
            id,
            name,
            birthyear,
            deathyear
        FROM 
        non_comedy_actor_mat
    )
) a
INNER JOIN (
    SELECT * FROM acted_in_mat
) ma
	ON a.id = ma.actor
INNER JOIN (
    (
        SELECT 
            id, 
            title, 
            year, 
            'Comedy' AS genre 
        FROM 
        comedy_movie_mat
    )
    UNION ALL
    (
        SELECT 
            id, 
            title, 
            year, 
            'Non-Comedy' AS genre
        FROM 
        non_comedy_movie_mat
    )
) m
	ON m.id = ma.movie
WHERE COALESCE(a.deathyear, 0) = 0
	AND m.year >= 2000
	AND m.year <= 2005
GROUP BY ma.actor, a.id, a.name
HAVING COUNT(ma.movie) > 10

-- Expanding Q3.2 non-materialized views of source
-- Time to query: 1min 2sec
SELECT 
a.id, a.name
FROM (
    (
        SELECT 
            id,
            name,
            birthyear,
            deathyear
        FROM 
        comedy_actor
    )
    UNION ALL
    (
        SELECT 
            id,
            name,
            birthyear,
            deathyear
        FROM 
        non_comedy_actor
    )
) a
INNER JOIN (
    SELECT * FROM acted_in
) ma
	ON a.id = ma.actor
INNER JOIN (
    (
        SELECT 
            id, 
            title, 
            year, 
            'Comedy' AS genre 
        FROM 
        comedy_movie
    )
    UNION ALL
    (
        SELECT 
            id, 
            title, 
            year, 
            'Non-Comedy' AS genre
        FROM 
        non_comedy_movie
    )
) m
	ON m.id = ma.movie
WHERE a.name LIKE 'Ja%'
	AND m.genre = 'Non-Comedy'
GROUP BY a.id, a.name

-- Expanding Q3.2 materialized views of source
-- Time to query: 1min
SELECT 
a.id, a.name
FROM (
    (
        SELECT 
            id,
            name,
            birthyear,
            deathyear
        FROM 
        comedy_actor_mat
    )
    UNION ALL
    (
        SELECT 
            id,
            name,
            birthyear,
            deathyear
        FROM 
        non_comedy_actor_mat
    )
) a
INNER JOIN (
    SELECT * FROM acted_in_mat
) ma
	ON a.id = ma.actor
INNER JOIN (
    (
        SELECT 
            id, 
            title, 
            year, 
            'Comedy' AS genre 
        FROM 
        comedy_movie_mat
    )
    UNION ALL
    (
        SELECT 
            id, 
            title, 
            year, 
            'Non-Comedy' AS genre
        FROM 
        non_comedy_movie_mat
    )
) m
	ON m.id = ma.movie
WHERE a.name LIKE 'Ja%'
	AND m.genre = 'Non-Comedy'
GROUP BY a.id, a.name