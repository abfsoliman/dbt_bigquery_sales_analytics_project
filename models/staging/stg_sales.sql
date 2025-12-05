{{ config(materialized='view') }}

SELECT
    order_id,
    product_name,
    amount,
    country,
    order_date,
    {{ dynamic_partition('order_date', 'MONTH') }}  -- Dynamic partitioning
FROM `dbt-gcp-480310.sales_dataset.raw_sales`