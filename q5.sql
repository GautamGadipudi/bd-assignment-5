-- Optimizing and expanding Q3.1 non-materialized
-- Time to query: ~10min
SELECT
a.id,
a.name
FROM (SELECT 
        id, 
        name 
    FROM (
    (
        SELECT 
            id,
            name,
            birthyear,
            deathyear
        FROM 
        comedy_actor
        WHERE COALESCE(deathyear, 0) = 0
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
        WHERE COALESCE(deathyear, 0) = 0
    )
)b) a
INNER JOIN (
    SELECT * FROM acted_in
) ma
	ON a.id = ma.actor
INNER JOIN (SELECT 
            id 
            FROM (
                (
                    SELECT 
                        id, 
                        title, 
                        year, 
                        'Comedy' AS genre 
                    FROM 
                    comedy_movie
                    WHERE year BETWEEN 2000 AND 2005
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
                    WHERE year BETWEEN 2000 AND 2005
                )
            )c) m
	ON m.id = ma.movie
GROUP BY ma.actor, a.id, a.name
HAVING COUNT(ma.movie) > 10

-- Optimizing and expanding Q3.1 materialized
-- Time to query: 50sec
SELECT
a.id,
a.name
FROM (SELECT 
        id, 
        name 
    FROM (
    (
        SELECT 
            id,
            name,
            birthyear,
            deathyear
        FROM 
        comedy_actor_mat
        WHERE COALESCE(deathyear, 0) = 0
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
        WHERE COALESCE(deathyear, 0) = 0
    )
)b) a
INNER JOIN (
    SELECT * FROM acted_in_mat
) ma
	ON a.id = ma.actor
INNER JOIN (SELECT 
            id 
            FROM (
                (
                    SELECT 
                        id, 
                        title, 
                        year, 
                        'Comedy' AS genre 
                    FROM 
                    comedy_movie_mat
                    WHERE year BETWEEN 2000 AND 2005
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
                    WHERE year BETWEEN 2000 AND 2005
                )
            )c) m
	ON m.id = ma.movie
GROUP BY ma.actor, a.id, a.name
HAVING COUNT(ma.movie) > 10

-- Optimizing Q3.2 non-materialized
-- Time to query: 42sec
SELECT 
*
FROM non_comedy_actor
WHERE name LIKE 'Ja%'

-- Optimizing Q3.2 materialized
-- Time to query: 1sec
SELECT 
*
FROM non_comedy_actor_mat
WHERE name LIKE 'Ja%'