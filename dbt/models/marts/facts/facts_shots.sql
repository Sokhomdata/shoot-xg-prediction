SELECT
    event_id as shot_id,
    match_id,
    player_id as striker_id,
    team_id,
    recipient_id as goalkeeper_id,
    event_id,

    x,
    y,

    minute,
    second,
    period,
    position_id,

    body_part_id,
    xg,
    outcome_id,
    outcome_name,

    under_pressure,
    first_time,
    shot_type_id,
    play_pattern_id,
    technique_id

FROM {{ ref('stg_events') }}
WHERE type_name = 'Shot'
