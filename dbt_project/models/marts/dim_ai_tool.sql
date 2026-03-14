-- DimAITool: unique AI tools used by companies

select
    {{ dbt_utils.generate_surrogate_key(['ai_primary_tool']) }} as ai_tool_key,
    ai_primary_tool,
    case
        when ai_primary_tool in ('ChatGPT', 'Claude', 'Gemini', 'Copilot')
            then 'LLM / Generative AI'
        when ai_primary_tool in ('TensorFlow', 'PyTorch', 'Scikit-learn')
            then 'ML Framework'
        when ai_primary_tool in ('Power BI', 'Tableau', 'Looker')
            then 'BI / Analytics'
        else 'Other'
    end as tool_vendor_category

from {{ ref('stg_ai_company_adoption') }}
qualify row_number() over (partition by ai_primary_tool order by ai_primary_tool) = 1