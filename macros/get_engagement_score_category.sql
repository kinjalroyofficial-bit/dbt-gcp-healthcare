{% macro get_engagement_score_category(score_column) %}

    case
        when {{ score_column }} >= 80 then 'High'
        when {{ score_column }} >= 50 then 'Medium'
        else 'Low'
    end

{% endmacro %}