WITH matches AS (
    SELECT
        match_id,
        competition_id,
        season_id,
        match_date
    FROM {{ ref('stg_matches') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY match_id, event_id) AS shot_id,
    event_id,
    matches.match_date,
    match_id,
    player_id as striker_id,
    team_id,

    x as shot_x,
    y as shot_y,

    minute,
    second,
    period,
    position_id,

    body_part_id,
    xg,
    outcome_id,
    outcome_name AS is_goal,

    IFNULL(under_pressure, FALSE) AS under_pressure,
    IFNULL(first_time, FALSE) AS first_time,
    shot_type_id,
    play_pattern_id,
    technique_id,

        -- Distance entre le ballon et le centre du but
    SQRT(
        POW(120 - x, 2)
        +
        POW(40 - y, 2)
    ) AS distance_to_goal,

    -- Angle de tir
    -- Plus l'angle est grand, plus la fenêtre de tir est ouverte
    ATAN(
        7.32 * (120 - x)
        /
        (
            POW(120 - x, 2)
            + POW(40 - y, 2)
            - POW(7.32 / 2, 2)
        )
    ) * 180 / ACOS(-1)  AS shooting_angle

FROM {{ ref('stg_events') }}
JOIN matches USING(match_id)
WHERE type_name = 'Shot'
