-- DimCompany: unique companies with their attributes

select
    {{ dbt_utils.generate_surrogate_key(['company_id']) }} as company_key,
    company_id,
    industry,
    num_employees,
    annual_revenue_usd_millions,
    company_age,
    company_size,
    country,
    region,
    company_age_group

from {{ ref('stg_ai_company_adoption') }}
qualify row_number() over (partition by company_id order by company_id) = 1