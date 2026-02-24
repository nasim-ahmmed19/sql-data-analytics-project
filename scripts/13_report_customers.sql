/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order valued

				- average monthly spend+
===============================================================================
*/
use DataWarehouseAnalytics

-- =============================================================================
-- Create Report: gold.report_customers
-- =============================================================================
IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS

with cte_fact as(
	select 
		customer_key,
		max(order_date) as last_order,
		count(distinct order_number) as total_order,
		sum(quantity) as total_quantity,
		sum(sales_amount) as total_sales,
		DATEDIFF(MONTH,min(order_date),max(order_date)) as lifespan
	from gold.fact_sales where order_date is not null group by customer_key
),
cte_customer_join as(
	select 
		f.customer_key,
		c.full_name,
		c.country,
		c.marital_status,
		c.gender,
		DATEDIFF(year,c.birthdate,GETDATE()) as age,
		f.last_order,
		f.total_order,
		f.total_quantity,
		f.total_sales,
		f.lifespan
	
	from cte_fact as f left join gold.dim_customers as c on f.customer_key =c.customer_key
),
cte_logic as(
	select *,
		case 
			when age<20 then 'Under 20'
			when age <30 then '20-29'
			when age <40 then '30-39'
			when age <50 then '40-49'
			else '50 and above'
		end as age_group,
		case
			when lifespan>=12 and total_sales>5000 then 'VIP'
			when lifespan>=12 and total_sales<=5000 then 'Regular'
			else 'New'
		end as customer_segment,
		case
			when total_sales=0 then 0
			else round(cast(total_sales as float)/total_order,1)
		end as avg_order_sales,
		case
			when lifespan=0 then total_sales
			else round(cast(total_sales as float)/lifespan,1)
		end avg_montly_sales,
		DATEDIFF(month,last_order,GETDATE()) as recency
	from cte_customer_join
)
select 
	customer_key,full_name,country,marital_status,gender,age,age_group,lifespan,customer_segment,
	last_order,total_order,total_quantity,recency,avg_order_sales,avg_montly_sales,
	total_sales
from cte_logic


