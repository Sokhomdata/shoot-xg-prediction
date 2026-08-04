SELECT
    shot_id,
    match_id,
    striker_id,
    team_id,
    recipient_id AS goalkeeper_id,
    event_id,
    x,
    y,
    body_part_id,
    xG,
    outcome_id,
    under_pressure,
    first_time,
    shot_type_id,
    play_pattern_id,
    technique_id
FROM {{ ref('stg_events') }} e

JOIN {{ ref('dim_matches') }} m
    on e.match_id = p.match_id

JOIN {{ ref('dim_players') }} p
    on e.striker_id = p.player_id

JOIN {{ ref('dim_teams') }} t
    on e.team_id = t.team_id

JOIN {{ ref('facts_events') }} fe
    on e.event_id = fe.event_id

JOIN {{ ref('dim_bodyparts') }} b
    on e.body_part_id = b.body_part_id

JOIN {{ ref('dim_shot_type') }} sh
    on e.shot_type_id = sh.shot_type_id

JOIN {{ ref('dim_playpattern') }} pp
    on e.play_pattern_id = pp.play_pattern_id

JOIN {{ ref('dim_technique') }} te
    on e.technique_id = te.technique_id

JOIN {{ ref('dim_outcome') }} o
    on e.outcome_id = o.outcome_id