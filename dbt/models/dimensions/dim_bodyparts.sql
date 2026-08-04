{{ config(
    materialized='table'
) }}

select distinct
    body_part_id,
    body_part_name as name

from {{ ref('stg_events') }}

where body_part_id is not null