{{ config(
    materialized='table'
) }}

select distinct
    shot_type_id,
    shot_type_name as name

from {{ ref('stg_events') }}

where shot_type_id is not null