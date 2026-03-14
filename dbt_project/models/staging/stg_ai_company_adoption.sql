-- Staging layer: raw AI company adoption data
-- Casts types and renames columns for consistency

select
    response_id,
    company_id,
    survey_year,
    quarter,
    country,
    region,
    industry,
    company_size,
    num_employees,
    annual_revenue_usd_millions,
    company_age,
    company_age_group,
    ai_adoption_stage,
    ai_primary_tool,
    ai_use_case,
    num_ai_tools_used,
    ai_projects_active,
    ai_budget_percentage,
    task_automation_rate,
    productivity_change_percent,
    jobs_displaced,
    jobs_created,
    revenue_growth_percent,
    cost_reduction_percent,
    survey_source,
    data_collection_method

from {{ source('ai_adoption_raw', 'ai_company_adoption') }}