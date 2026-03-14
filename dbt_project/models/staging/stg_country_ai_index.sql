-- Staging layer: country-level AI index data

select
    country,
    region,
    gdp_per_capita,
    internet_penetration,
    digital_maturity_index,
    country_ai_policy,
    ai_patent_filings_2024,
    ai_researchers_per_million

from {{ source('ai_adoption_raw', 'country_ai_index') }}