{% snapshot snap_hcp_profile %}

{{
    config(
      target_schema='dbt_kroy',
      unique_key='npi_number',
      strategy='check',
      check_cols=[
        'hcp_first_name',
        'hcp_last_name',
        'hcp_full_name',
        'hcp_specialty',
        'organization_name',
        'hcp_city',
        'hcp_state'
      ]
    )
}}

select distinct
    npi_number,
    hcp_first_name,
    hcp_last_name,
    hcp_full_name,
    hcp_specialty,
    organization_name,
    hcp_city,
    hcp_state
from {{ ref('stg_hcp_engagements') }}
where npi_number is not null

{% endsnapshot %}