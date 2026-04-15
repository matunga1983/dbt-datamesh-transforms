{{ config(
    materialized='table',
    tags=['staging', 'orders']
) }}

-- Staging: light cleanup from bronze raw orders
-- Source: dlt import from PostgreSQL → bronze.orders_partitioned

SELECT
    order_id,
    customer_id,
    product_name,
    category,
    CAST(quantity AS INT) AS quantity,
    CAST(unit_price AS DECIMAL(10,2)) AS unit_price,
    CAST(total_amount AS DECIMAL(10,2)) AS total_amount,
    LOWER(TRIM(status)) AS status,
    LOWER(TRIM(payment_method)) AS payment_method,
    UPPER(TRIM(country)) AS country,
    created_at
FROM nessie.bronze.orders_partitioned
