WITH shots AS (
    SELECT *
    FROM {{ ref('facts_shots') }}

),

matches AS (
    SELECT
        match_id,
        competition_id,
        season_id,
        home_team_id
    FROM {{ ref('stg_matches') }}
)
SELECT

    -------------------------------------------------------------------------
    -- Identifiants techniques
    -- A exclure du modèle ML
    -------------------------------------------------------------------------

    s.shot_id,
    s.match_id,
    s.event_id,

    -------------------------------------------------------------------------
    -- Variables spatiales
    -------------------------------------------------------------------------
    s.x,
    s.y,

    -- Distance entre le ballon et le centre du but
    SQRT(
        POW(120 - s.x, 2)
        +
        POW(40 - s.y, 2)
    ) AS distance_to_goal,

    -- Angle de tir
    -- Plus l'angle est grand, plus la fenêtre de tir est ouverte
    ATAN(
        7.32 * (120 - s.x)
        /
        (
         POW(120 - s.x, 2)
         +
         POW(40 - s.y, 2)
            -
         POW(7.32 / 2, 2)
        )
    ) AS shooting_angle,

    -------------------------------------------------------------------------
    -- Variables temporelles
    -------------------------------------------------------------------------
    s.minute,
    s.period,

    -------------------------------------------------------------------------
    -- Variables joueur
    -------------------------------------------------------------------------
    
    -- Poste du joueur :
    -- attaquant, milieu, défenseur, gardien
    -- permet d'avoir une information joueur sans mémoriser son identité
    s.position_id,


    -------------------------------------------------------------------------
    -- Variables caractéristiques du tir
    -------------------------------------------------------------------------

    s.body_part_id,
    s.technique_id,
    s.shot_type_id,
    s.play_pattern_id,
    s.under_pressure,
    s.first_time,

    -------------------------------------------------------------------------
    -- Contexte match
    -------------------------------------------------------------------------
    m.competition_id,
    m.season_id,
    CASE
        WHEN s.team_id = m.home_team_id THEN 1
        ELSE 0
    END AS is_home,

    -------------------------------------------------------------------------
    -- Variable cible
    -------------------------------------------------------------------------

    CASE
        WHEN s.outcome_name = 'Goal' THEN 1
        ELSE 0
    END AS goal

FROM shots s
LEFT JOIN matches m
    ON s.match_id = m.match_id