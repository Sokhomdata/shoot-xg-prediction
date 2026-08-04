{{ config(
    materialized='table'
) }}

select distinct
    cast(competition_id as int64) as competition_id,
    cast(season_id as int64) as season_id,
    competition_name,
    country_name as country,
    competition_gender,
    competition_youth,
    competition_international

from {{ ref('stg_competitions') }}

where competition_id is not null