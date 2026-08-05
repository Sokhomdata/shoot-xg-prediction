{{ config(
    materialized='table'
) }}

with teams as (

    select
        home_team_id as team_id,
        home_team_name as name,
        home_team_country as country
    from {{ ref('stg_matches') }}

    union distinct

    select
        away_team_id as team_id,
        away_team_name as name,
        away_team_country as country
    from {{ ref('stg_matches') }}
)
select
    team_id,
    name,
    country

from teams
where team_id is not null