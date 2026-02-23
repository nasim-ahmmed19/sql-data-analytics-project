/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

use DataWarehouseAnalytics

-- Calculating cumulative revenue across multiple years and months
with cte_year_monthly_cum as(
    select 
        year(order_date) as ye,
        MONTH(order_date) as mo,
        DATENAME(MONTH,order_date) as month_name,
        count(distinct customer_key) as total_customer,
        sum(quantity) as total_quantity,
        sum(sales_amount) as total_revenue
    from gold.fact_sales where order_date is not null
    group by year(order_date),MONTH(order_date) ,DATENAME(MONTH,order_date)
    ) 
    select *,
        sum(total_revenue) over(order by ye, mo ) as runing_sum
    from cte_year_monthly_cum;
  
  -----------------------------------------------------------------------
  -- Calculating cumulative revenue by month across all years combined
   with cte_monthly_cum as(
    select
        MONTH(order_date) as mo,
        DATENAME(MONTH,order_date) as month_name,
        count(distinct customer_key) as total_customer,
        sum(quantity) as total_quantity,
        sum(sales_amount) as total_revenue
    from gold.fact_sales where order_date is not null
    group by MONTH(order_date) ,DATENAME(MONTH,order_date)
    ) 
    select *,
        sum(total_revenue) over(order by  mo ) as runing_sum
    from cte_monthly_cum;

---------------------------------------------------------------------------
-- Calculating year-over-year cumulative revenue
with cte_year_cum as(
    select 
        year(order_date) as year_,
        count(distinct customer_key) as total_customer,
        sum(quantity) as total_quantity,
        sum(sales_amount) as total_revenue
    from gold.fact_sales where order_date is not null
    group by year(order_date)
    ) 
    select *,
        sum(total_revenue) over(order by year_) as runing_sum
    from cte_year_cum;
