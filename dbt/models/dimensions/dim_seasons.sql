{{ config(
    materialized='table'
) }}

select
    c.season_id,
    c.season_name,
    min(m.match_date) as date_start,
    max(m.match_date) as date_end

from {{ ref('stg_competitions') }} c

join {{ ref('stg_matches') }} m
    on c.season_id = m.season_id

group by
    c.season_id,
    c.season_name