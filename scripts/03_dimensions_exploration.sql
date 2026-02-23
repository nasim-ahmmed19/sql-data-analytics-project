use DataWarehouseAnalytics

select 
	country,count(*) as customer_count
from gold.dim_customers group by country

select category,count(*) as category_count from gold.dim_products group by
category

