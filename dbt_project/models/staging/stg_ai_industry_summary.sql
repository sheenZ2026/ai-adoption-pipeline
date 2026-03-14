-- Staging layer: industry-level summary data

select
    industry,
    avg_ai_adoption_rate,
    avg_productivity_change_percent,
    avg_ai_maturity_score,
    avg_ai_failure_rate,
    avg_jobs_displaced,
    avg_jobs_created,
    avg_customer_satisfaction

from {{ source('ai_adoption_raw', 'ai_industry_summary') }}