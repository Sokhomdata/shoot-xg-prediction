{{ config(
    materialized='table'
) }}

with players as (
    select
        player_id,
        player_name,
        position_id
    from {{ ref('stg_events') }}
    where player_id is not null

    union distinct

    select
        cast(player_id as int64) as player_id,
        player_name,
        cast(position_id as int64) as position_id
    from {{ ref('stg_lineups') }}
    where player_id is not null
)

select
    player_id,
    player_name as last_name_first_name,
    position_id as current_position_id

from players