/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

use DataWarehouseAnalytics

 /* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */

with cte_perfomance as (
    select 
        year(order_date) as order_year,
        product_name,
        sum(sales_amount) as current_sales
    from gold.fact_sales as f left join gold.dim_products as p
    on f.product_key = p.product_key where order_date is not null group by year(order_date),product_name
),
cte_calculation as (
    select 
        *,
        avg(current_sales) over(partition by product_name) as avg_sales,
        lag(current_sales) over(partition by product_name order by order_year) as py_sales
    from cte_perfomance
)
select * ,
    case
        when current_sales-avg_sales >0 then 'Above avg'
        when current_sales-avg_sales <0 then 'Below avg'
        else 'No change'
    end as diff_avg,
    case
        when current_sales-py_sales >0 then 'Increase'
        when current_sales-py_sales <0 then 'Decrease'
        else 'No py'
    end as diff_cu_py_sales

from cte_calculation order by product_name,order_year




