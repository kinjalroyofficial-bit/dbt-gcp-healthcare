{{ config(
    materialized='incremental',
    unique_key='engagement_id',
    incremental_strategy='merge'
) }}

with hcp_engagements as (

    select
        engagement_id,
        npi_number,
        hcp_full_name,
        hcp_city,
        hcp_state,
        hcp_specialty,
        organization_name,
        engagement_date,
        created_at,
        product_name,
        engagement_channel,
        engagement_type,
        engagement_score,
        duration_minutes,
        follow_up_required,
        _fivetran_synced
    from {{ ref('stg_hcp_engagements') }}

    {% if is_incremental() %}

    where _fivetran_synced >= timestamp_sub(
        (
            select coalesce(max(_fivetran_synced), timestamp('1900-01-01'))
            from {{ this }}
        ),
        interval 2 day
    )

    {% endif %}

),

engagement_channel_mapping as (

    select
        engagement_channel,
        channel_group,
        channel_priority
    from {{ ref('engagement_channel_mapping') }}

)

select
    h.engagement_id,
    h.npi_number,
    h.hcp_full_name,
    h.hcp_city,
    h.hcp_state,
    h.hcp_specialty,
    h.organization_name,
    h.engagement_date,
    h.created_at,
    h.product_name,
    h.engagement_channel,
    m.channel_group,
    m.channel_priority,
    h.engagement_type,
    h.engagement_score,
    {{ get_engagement_score_category('h.engagement_score') }} as engagement_score_category,
    h.duration_minutes,
    h.follow_up_required,
    h._fivetran_synced
from hcp_engagements h
left join engagement_channel_mapping m
    on h.engagement_channel = m.engagement_channel