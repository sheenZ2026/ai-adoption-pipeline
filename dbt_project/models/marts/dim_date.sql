-- DimDate: unique survey time periods

select
    {{ dbt_utils.generate_surrogate_key(['survey_year', 'quarter']) }} as date_key,
    survey_year,
    quarter,
    concat(cast(survey_year as string), '-', quarter) as year_quarter,
    case
        when survey_year = extract(year from current_date()) then true
        else false
    end as is_latest_year

from {{ ref('stg_ai_company_adoption') }}
qualify row_number() over (partition by survey_year, quarter order by survey_year) = 1