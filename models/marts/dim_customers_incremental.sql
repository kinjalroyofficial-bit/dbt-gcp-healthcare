    {{ config(
    materialized='incremental',
    unique_key='customer_id',
    incremental_strategy='merge'
) }}

select
    customer_id,
    customer_name,
    customer_city,
    customer_status,
    updated_at
from `xyz-healthcare.public.raw_customers`

{% if is_incremental() %}

where updated_at > (
    select coalesce(max(updated_at), timestamp('1900-01-01'))
    from {{ this }}
)

{% endif %}