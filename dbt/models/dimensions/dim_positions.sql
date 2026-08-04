{{ config(
    materialized='table'
) }}

with positions as (
    select
        position_id,
        position_name
    from {{ ref('stg_events') }}
    where position_id is not null

    union distinct

    select
        cast(position_id as int64) as position_id,
        position_name

    from {{ ref('stg_lineups') }}
    where position_id is not null
)
select
    position_id as current_position_id,
    position_name as name

from positions