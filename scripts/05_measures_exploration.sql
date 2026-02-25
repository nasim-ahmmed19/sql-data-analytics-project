/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/
use DataWarehouseAnalytics

--Find the total sales
select concat(round(sum(CAST(sales_amount AS FLOAT))/1000000,2),' M')
as total_sales from gold.fact_sales

--Find how many items are sold
select sum(quantity) as total_quantity from gold.fact_sales

--Find the avarage selling price
select avg(sales_amount) as avg_selling_price from gold.fact_sales

--Find the total number of products
select count(distinct product_name) total_products from gold.dim_products

--Find the total number of products
select count(distinct order_number) as total_Nof_order from gold.fact_sales

--Find the total number of customers
select count( customer_key) as total_customers from gold.dim_customers

-- Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;


-- Generate a Report that shows all key metrics of the business
select 'Total_sales' as measure_name,sum(sales_amount) as measure_value from gold.fact_sales
union all
select 'Total quantity',sum(quantity) from gold.fact_sales
union all
select 'Avg Seales',avg(sales_amount) from gold.fact_sales
union all 
select 'Total orders',count(distinct order_number) from gold.fact_sales
union all
select 'Total Customer',count(customer_key) from gold.dim_customers
