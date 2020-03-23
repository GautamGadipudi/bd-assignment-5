CREATE OR REPLACE VIEW all_movie AS
(
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
);

CREATE OR REPLACE VIEW all_actor AS
(
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
);

CREATE OR REPLACE VIEW all_movie_actor AS
(
    SELECT * FROM acted_in
);