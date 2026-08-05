SELECT
    JSON_VALUE(competition_json, '$.competition_gender') AS competition_gender,
    SAFE_CAST(JSON_VALUE(competition_json, '$.competition_id') AS INT64)AS competition_id,
    SAFE_CAST(JSON_VALUE(competition_json, '$.competition_international') AS BOOL) AS competition_international,
    JSON_VALUE(competition_json, '$.competition_name') AS competition_name,
    SAFE_CAST(JSON_VALUE(competition_json, '$.competition_youth') AS BOOL) AS competition_youth,
    JSON_VALUE(competition_json, '$.country_name') AS country_name,
    JSON_VALUE(competition_json, '$.match_available') AS match_available,
    JSON_VALUE(competition_json, '$.match_available_360') AS match_available_360,
    JSON_VALUE(competition_json, '$.match_updated') AS match_updated,
    JSON_VALUE(competition_json, '$.match_updated_360') AS match_updated_360,
    SAFE_CAST(JSON_VALUE(competition_json, '$.season_id') AS INT64) AS season_id,
    JSON_VALUE(competition_json, '$.season_name') AS season_name
FROM {{ source('statsbomb_data', 'competitions_raw') }}