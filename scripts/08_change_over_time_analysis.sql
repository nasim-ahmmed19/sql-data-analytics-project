/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

use DataWarehouseAnalytics
-- Analyse sales performance over time

-- Using a CTE to handle time-based aggregations for better performance and readability
with cte_monthly as(
    select 
        year(order_date) as year_,
        MONTH(order_date) as month_,
        datename(MONTH,order_date) as month_name,
        count(distinct customer_key) as total_customers,
        sum(quantity) as total_quantity,
        sum(sales_amount) as total_revenue
    from gold.fact_sales where order_date is not null 
    group by year(order_date),MONTH(order_date),datename(MONTH,order_date) 
     )
    
    select  
        year_
        ,month_name,
        total_customers,
        total_quantity,
        total_revenue 
    from cte_monthly order by year_, month_ asc;


-- Direct aggregation using the FORMAT function (Converts date to string)
-- Note: FORMAT() is slower on large datasets compared to YEAR/MONTH functions
select 
    FORMAT(order_date,'yyyy-MMM') AS ORDER_DATE,
    count(distinct customer_key) as total_customers,
    sum(quantity) as total_quantity,
    sum(sales_amount) as total_revenue    
from gold.fact_sales  WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date,'yyyy-MMM') 
ORDER BY FORMAT(order_date,'yyyy-MMM')

