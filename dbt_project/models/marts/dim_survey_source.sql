-- DimSurveySource: unique survey sources and collection methods

select
    {{ dbt_utils.generate_surrogate_key(['survey_source', 'data_collection_method']) }} as source_key,
    survey_source,
    data_collection_method

from {{ ref('stg_ai_company_adoption') }}
qualify row_number() over (
    partition by survey_source, data_collection_method
    order by survey_source
) = 1