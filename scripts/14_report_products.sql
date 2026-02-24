/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
use DataWarehouseAnalytics

   


-- =============================================================================
-- Create Report: gold.report_products
-- =============================================================================
IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
    DROP VIEW gold.report_products;
GO

CREATE VIEW gold.report_products AS

with cte_fact as(
    select 
        product_key,
        max(order_date) as last_order,
        count(distinct customer_key) as total_customers,
        count(distinct order_number) as total_order,
        sum(quantity) as total_quantity,
        sum(sales_amount) as total_sales,
        datediff(MONTH,min(order_date),max(order_date)) as lifespan
    from gold.fact_sales where order_date is not null group by product_key
    ),
cte_product_join as (
    select 
        f.product_key,
        p.product_name,
        p.category,
        p.subcategory,
        f.last_order,
        f.total_customers,
        f.total_order,
        f.total_quantity,
        p.cost * f.total_quantity as overall_cost,
        f.total_sales,
        f.lifespan
    from cte_fact as f left join gold.dim_products as p
    on f.product_key=p.product_key
    ),
cte_logic as(
    select *,
        case
            when lifespan=0 then total_sales
            else round(cast(total_sales as float)/lifespan,1)
        end  as avg_montly_sales,
        case
            when total_order=0 then 0
            else round(cast(total_sales as float)/total_order,1)
        end as avg_order_sales,
        round(cast(total_sales as float)/total_quantity,1) as avg_selling_price,
        case
            when total_sales>50000 then 'High-performer'
            when total_sales >=10000 then 'Mid-Range'
            else 'Low-performer'
        end as product_segment,
        datediff(MONTH,last_order,GETDATE()) as recency_month,
        total_sales - overall_cost AS total_profit
    from cte_product_join
    )
    select * from cte_logic 

select * from gold.report_products 