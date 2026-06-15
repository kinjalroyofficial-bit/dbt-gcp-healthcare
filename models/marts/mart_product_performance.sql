{{ config(materialized='table') }}

select
    product_name,

    count(*) as total_engagements,
    count(distinct npi_number) as unique_hcps,

    round(avg(engagement_score), 2) as avg_engagement_score,
    round(avg(duration_minutes), 2) as avg_duration_minutes,

    sum(case when follow_up_required then 1 else 0 end) as follow_up_required_count

from {{ ref('stg_hcp_engagements') }}

group by
    product_name