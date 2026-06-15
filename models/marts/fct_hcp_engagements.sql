{{ config(
    materialized='incremental',
    unique_key='engagement_id'
) }}

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

where _fivetran_synced > (
    select coalesce(max(_fivetran_synced), timestamp('1900-01-01'))
    from {{ this }}
)

{% endif %}