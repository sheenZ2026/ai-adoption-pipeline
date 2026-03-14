-- DimAIAdoptionStage: ordered AI maturity stages

with stage_values as (
    select
        ai_adoption_stage as adoption_stage,
        case ai_adoption_stage
            when 'Exploring'    then 1
            when 'Piloting'     then 2
            when 'Scaling'      then 3
            when 'Optimizing'   then 4
            when 'Transforming' then 5
            else 0
        end as stage_order,
        case ai_adoption_stage
            when 'Exploring'    then 'Stage 1 - Exploring'
            when 'Piloting'     then 'Stage 2 - Piloting'
            when 'Scaling'      then 'Stage 3 - Scaling'
            when 'Optimizing'   then 'Stage 4 - Optimizing'
            when 'Transforming' then 'Stage 5 - Transforming'
            else 'Unknown'
        end as stage_label
    from {{ ref('stg_ai_company_adoption') }}
    -- 核心修复：只保留这 5 个标准值，剔除那 4 个导致报错的异常值
    where ai_adoption_stage in ('Exploring', 'Piloting', 'Scaling', 'Optimizing', 'Transforming')
)

select
    {{ dbt_utils.generate_surrogate_key(['adoption_stage']) }} as stage_key,
    adoption_stage,
    stage_order,
    stage_label
from stage_values
-- 确保每个阶段只出现一次
qualify row_number() over (partition by adoption_stage order by stage_order) = 1