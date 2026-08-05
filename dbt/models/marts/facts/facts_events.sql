SELECT
    event_id,
    related_event1 AS related_event_id,
    period,
    minute,
    second,
    type_id AS action_id,
    player_id AS play_actor_id,
    x AS x_actor,
    y AS y_actor,
    recipient_id AS player_target_id,
    pass_end_x AS x_target,
    pass_end_y AS y_target,
    possession
FROM {{ ref('stg_events') }} c