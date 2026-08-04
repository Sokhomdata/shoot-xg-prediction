SELECT
    JSON_VALUE(competition_json, '$.competition_gender') AS competition_gender,
    JSON_VALUE(competition_json, '$.competition_id') AS competition_id,
    JSON_VALUE(competition_json, '$.competition_international') AS competition_international,
    JSON_VALUE(competition_json, '$.competition_name') AS competition_name,
    JSON_VALUE(competition_json, '$.competition_youth') AS competition_youth,
    JSON_VALUE(competition_json, '$.country_name') AS country_name,
    JSON_VALUE(competition_json, '$.match_available') AS match_available,
    JSON_VALUE(competition_json, '$.match_available_360') AS match_available_360,
    JSON_VALUE(competition_json, '$.match_updated') AS match_updated,
    JSON_VALUE(competition_json, '$.match_updated_360') AS match_updated_360,
    JSON_VALUE(competition_json, '$.season_id') AS season_id,
    JSON_VALUE(competition_json, '$.season_name') AS season_name
FROM {{ source('statsbomb_data', 'competitions_raw') }}