{{ config(
    materialized='table',
    tags=['silver', 'orders']
) }}

-- Silver: cleaned orders — no cancelled, with derived fields
-- Reads from staging, writes to silver zone

SELECT
    order_id,
    customer_id,
    product_name,
    category,
    quantity,
    unit_price,
    total_amount,
    status,
    payment_method,
    country,
    created_at,
    YEAR(created_at) AS order_year,
    MONTH(created_at) AS order_month,
    CURRENT_TIMESTAMP() AS _loaded_at
FROM {{ ref('stg_orders') }}
WHERE status != 'cancelled'
