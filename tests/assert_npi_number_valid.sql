select
    engagement_id,
    npi_number
from {{ ref('stg_hcp_engagements') }}
where
    npi_number is null
    or safe_cast(npi_number as int64) is null
    or safe_cast(npi_number as int64) <= 0