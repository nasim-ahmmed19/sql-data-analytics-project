use DataWarehouseAnalytics

select 
	min(order_date) as first_order_date,
	max(order_date) as last_order_date,
	DATEDIFF(MONTH,min(order_date),max(order_date)) as order_range_month
from gold.fact_sales

select 
	min(birthdate) as oldest_brithday,
	DATEDIFF(year,min(birthdate),GETDATE()) as oldest_age,
	max(birthdate) as younest_brithday,
	DATEDIFF(year,max(birthdate),GETDATE()) as younest_age
from gold.dim_customers

select 
	customer_id,customer_key,full_name,birthdate,
	DATEDIFF(year,birthdate,GETDATE()) as age
from gold.dim_customers 
