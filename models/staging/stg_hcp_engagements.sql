

select
    engagement_id,
    cast(npi_number as string) as npi_number,

    trim(hcp_first_name) as hcp_first_name,
    trim(hcp_last_name) as hcp_last_name,
    concat(trim(hcp_first_name), ' ', trim(hcp_last_name)) as hcp_full_name,

    trim(hcp_city) as hcp_city,
    trim(hcp_state) as hcp_state,
    trim(hcp_specialty) as hcp_specialty,
    trim(organization_name) as organization_name,

    engagement_date,
    created_at,

    trim(product_name) as product_name,
    trim(engagement_channel) as engagement_channel,
    trim(engagement_type) as engagement_type,

    engagement_score,
    duration_minutes,
    follow_up_required,

    _fivetran_synced

from {{ source('public', 'hcp_engagements') }}

where coalesce(_fivetran_deleted, false) = false