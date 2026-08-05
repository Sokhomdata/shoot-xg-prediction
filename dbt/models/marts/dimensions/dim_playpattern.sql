{{ config(
    materialized='table'
) }}

select distinct
    play_pattern_id,
    play_pattern_name as name

from {{ ref('stg_events') }}

where play_pattern_id is not null