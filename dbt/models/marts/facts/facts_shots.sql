SELECT
    ROW_NUMBER() OVER (ORDER BY match_id, event_id) AS shot_id,
    event_id,
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
    outcome_name,

    IFNULL(under_pressure, FALSE) AS under_pressure,
    IFNULL(first_time, FALSE) AS first_time,
    shot_type_id,
    play_pattern_id,
    technique_id

FROM {{ ref('stg_events') }}
WHERE type_name = 'Shot'
