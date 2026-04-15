{% macro generate_schema_name(custom_schema_name, node) -%}
    {#
        Override default dbt schema naming.
        If a custom schema is set (via +schema in dbt_project.yml),
        use ONLY that — don't prepend the default schema.
        This gives us clean namespace names: silver, gold (not default_silver, default_gold)
    #}
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
