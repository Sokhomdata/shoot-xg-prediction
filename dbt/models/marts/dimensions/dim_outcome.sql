{{ config(
    materialized='table'
) }}

select distinct
    outcome_id,
    outcome_name as name

from {{ ref('stg_events') }}

where outcome_id is not null