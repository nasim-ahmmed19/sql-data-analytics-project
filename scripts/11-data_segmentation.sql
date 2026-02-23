/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/
use DataWarehouseAnalytics

/*Segment products into cost ranges and 
count how many products fall into each segment*/

with cte_product_segment as (
    select 
        product_key,
        product_name,
        cost,
        case
            when cost<100 then 'Below 100'
            when cost<500 then '100-500'
            when cost<1000 then '500-1000'
            else 'Above  1000'
        end as segment
    from gold.dim_products
    )
    select segment,count(product_key) as total_produts
    from cte_product_segment group by segment order by total_produts desc;
    ------------------------------------------------------------

    /*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/
with cte_customer_segments as(
    select 
        customer_key,
        sum(sales_amount) as total_spending ,
        min(order_date) as first_order,
        max(order_date) as last_order,
        count(distinct order_number) as total_order,
        DATEDIFF(month,min(order_date),max(order_date)) as lifespan
    from gold.fact_sales group by customer_key 
),
cte_logic as (
    select *,
    case
        when lifespan>=12 and total_spending >5000 then 'VIP'
        when lifespan >=12 and total_spending <=5000 then 'Regular'
        else 'New'
    end as customer_segment
    from cte_customer_segments
)
select 
    customer_segment,
    count(customer_key) as total_customers
from cte_logic group by customer_segment order by total_customers desc;
