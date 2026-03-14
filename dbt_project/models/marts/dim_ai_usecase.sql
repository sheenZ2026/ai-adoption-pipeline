-- DimAIUseCase: unique AI use cases

select
    {{ dbt_utils.generate_surrogate_key(['ai_use_case']) }} as usecase_key,
    ai_use_case,
    case
        when ai_use_case in ('Customer Service', 'Sales', 'Marketing')
            then 'Customer-Facing'
        when ai_use_case in ('HR', 'Finance', 'Operations')
            then 'Internal Operations'
        when ai_use_case in ('R&D', 'Product Development')
            then 'Innovation'
        else 'Other'
    end as usecase_category

from {{ ref('stg_ai_company_adoption') }}
qualify row_number() over (partition by ai_use_case order by ai_use_case) = 1