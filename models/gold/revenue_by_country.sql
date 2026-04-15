{{ config(
    materialized='table',
    tags=['gold', 'revenue']
) }}

-- Gold: revenue aggregated by country and month
-- Business-ready KPI table for dashboards

SELECT
    country,
    order_year,
    order_month,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(quantity) AS total_items_sold
FROM {{ ref('orders_cleaned') }}
GROUP BY country, order_year, order_month
