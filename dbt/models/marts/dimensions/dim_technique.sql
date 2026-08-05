{{ config(
    materialized='table'
) }}

select distinct
    technique_id,
    technique_name as name

from {{ ref('stg_events') }}

where technique_id is not null