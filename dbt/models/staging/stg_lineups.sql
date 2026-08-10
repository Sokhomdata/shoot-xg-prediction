SELECT
    JSON_VALUE(lineup_json, '$.team_id') AS team_id,
    JSON_VALUE(lineup_json, '$.team_name') AS team_name,
    JSON_VALUE(player, '$.player_id') AS player_id,
    JSON_VALUE(player, '$.player_name') AS player_name,
    JSON_VALUE(position, '$.position_id') AS position_id,
    JSON_VALUE(position, '$.position') AS position_name,
    JSON_VALUE(position, '$.start_reason') AS start_reason,
    JSON_VALUE(position, '$.end_reason') AS end_reason,
    JSON_VALUE(position, '$.from') AS from_time,
    JSON_VALUE(position, '$.to') AS to_time,
    JSON_VALUE(position, '$.from_period') AS from_period,
    JSON_VALUE(position, '$.to_period') AS to_period

FROM {{ source('statsbomb_data', 'raw_lineups') }}

CROSS JOIN UNNEST(
    JSON_QUERY_ARRAY(lineup_json, '$.lineup')
) AS player

LEFT JOIN UNNEST(
    JSON_QUERY_ARRAY(player, '$.positions')
) AS position