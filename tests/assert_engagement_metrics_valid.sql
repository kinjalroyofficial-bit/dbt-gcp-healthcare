select
    engagement_id,
    engagement_score,
    duration_minutes
from {{ ref('stg_hcp_engagements') }}
where
    engagement_score < 0
    or engagement_score > 100
    or duration_minutes < 0