{{ config(
    materialized='table'
) }}

select
    match_id,
    competition_id,
    season_id,
    match_date,
    kick_off,
    home_team_id,
    away_team_id,
    home_score,
    away_score

from {{ ref('stg_matches') }}

where match_id is not null