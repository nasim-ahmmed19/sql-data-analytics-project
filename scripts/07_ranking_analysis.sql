/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/
use DataWarehouseAnalytics

-- Which 5 products generating the highest revenue?
select top 5
    p.product_id,
    p.product_key,
    p.product_name,
    sum(s.quantity) as total_sold_unit,
    sum(s.sales_amount) as total_revenue
from gold.dim_products as p right join gold.fact_sales as s
on p.product_key=s.product_key group by     p.product_id,p.product_key,
p.product_name order by total_revenue desc;

-- Complex but flexibly Ranking using Window Functions
select * from
(select 
    p.product_id,
    p.product_key,
    p.product_name,
    sum(f.quantity) as total_sold_unit,
    sum(f.sales_amount) as total_revenue,
    ROW_NUMBER() over(order by sum(f.sales_amount) desc) as ranks
from gold.fact_sales as f left join gold.dim_products as p 
on f.product_key=p.product_key group by     p.product_id,p.product_key,
p.product_name)t where ranks<=5;

-- What are the 5 worst performing products in terms of sales?
select * from 
    (select top 5
        p.product_key,
        p.category,
        p.product_name,
        sum(f.quantity) as sold_items,
        sum(f.sales_amount) as revenue,
        ROW_NUMBER() over(order by sum(f.sales_amount)) as prd_rank
    from gold.fact_sales as f left join gold.dim_products as p
    on f.product_key=p.product_key group by 
        p.product_key,
        p.category,
        p.product_name
    )t where prd_rank<=5;


-- Find the top 10 customers who have generated the highest revenue?
with top_10 as (
    select 
        c.customer_key,
        c.full_name,
        c.gender,
        c.country,
        DATEDIFF(year,birthdate ,GETDATE()) as age,
        sum(f.quantity) as quantity,
        sum(f.sales_amount) as revenue,
        ROW_NUMBER() over(order by sum(f.sales_amount) desc) as cust_rank
    from gold.fact_sales as f left join gold.dim_customers as c
    on f.customer_key=c.customer_key group by     
        c.customer_key,
        c.full_name,
        c.gender,            
        c.country,
        birthdate
    )
    select *
    from top_10 where cust_rank<=10;

-- Find the top 10 customers who have generated the highest revenue?
with top_10 as (
select 
    c.customer_key,
    c.full_name,
    c.gender,
    c.country,
    DATEDIFF(year,birthdate ,GETDATE()) as age,
    sum(f.quantity) as quantity,
    sum(f.sales_amount) as revenue,
    ROW_NUMBER() over(order by sum(f.sales_amount) desc) as cust_rank
from gold.fact_sales as f left join gold.dim_customers as c
on f.customer_key=c.customer_key group by     
    c.customer_key,
    c.full_name,
    c.gender,            
    c.country,
    birthdate
)
select * from top_10 where cust_rank<=10;


-- The 3 customers with the fewest orders placed
select * from
(select 
    c.customer_key,
    c.full_name,
    c.gender,
    c.country,
    DATEDIFF(year,birthdate ,GETDATE()) as age,
    COUNT(DISTINCT order_number) AS total_orders,
    sum(f.quantity) as quantity,
    sum(f.sales_amount) as revenue,
    ROW_NUMBER() over(order by COUNT(DISTINCT order_number) ) as cus_rank
from gold.fact_sales as f left join gold.dim_customers as c
on f.customer_key=c.customer_key group by     
    c.customer_key,
    c.full_name,
    c.gender,
    c.country,
    birthdate)t where cus_rank<=3;
--------------------------------------------------------------------------------------------------------------------
 --Top 5 Customers and Their Purchased Products
--"I wrote this code entirely on my own using my own brain, without any help from ChatGPT. Even though it might not be perfectly optimized yet, I'm proud that I could solve the problem by myself."
with cte_top as(
     select 
        c.customer_id,
        c.customer_key,
        c.full_name,
        p.category,
        p.subcategory,
        p.product_name,
        f.order_date,
        sum(f.quantity) as total_sold_unit,
        sum(f.sales_amount) as total_revenue
     from gold.fact_sales as f left join gold.dim_customers as c
     on f.customer_key=c.customer_key left join gold.dim_products as p
     on f.product_key=p.product_key group by c.customer_id,c.customer_key,
     c.full_name,p.category,p.subcategory,p.product_name,f.order_date ),

cte_top5 as (
    select top 5
        c.customer_key,
        sum(f.sales_amount) as total_revenue
    from gold.fact_sales as f left join gold.dim_customers as c
    on f.customer_key=c.customer_key group by c.customer_key order by 
    total_revenue desc
)

select 
    t.customer_id,
    t.customer_key,
    t.full_name,
    t.category,
    t.subcategory,
    t.product_name,
    t.order_date,
    t.total_sold_unit,
    t.total_revenue as product_wise_revenue,
    sum(t.total_revenue) over(partition by t.customer_key order by t.order_date desc rows between current row and unbounded following) as total_revenue
from cte_top as t inner join cte_top5 as t5 
on t.customer_key=t5.customer_key; 



--"ChatGPT generated this optimized version after I provided my initial code and asked for performance improvements."
WITH CustomerSales AS (
   
    SELECT 
        c.customer_id,
        c.customer_key,
        c.full_name,
        p.category,
        p.subcategory,
        p.product_name,
        f.order_date,
        f.quantity,
        f.sales_amount,
        SUM(f.sales_amount) OVER(PARTITION BY f.customer_key) as total_cust_revenue
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c ON f.customer_key = c.customer_key
    LEFT JOIN gold.dim_products p ON f.product_key = p.product_key
),
Top5Filter AS (
   
    SELECT *,
           DENSE_RANK() OVER (ORDER BY total_cust_revenue DESC) as rnk
    FROM CustomerSales
)

SELECT 
    customer_id,
    customer_key,
    full_name,
    category,
    subcategory,
    product_name,
    order_date,
    quantity,
    sales_amount as product_wise_revenue,
    SUM(sales_amount) OVER(
        PARTITION BY customer_key 
        ORDER BY order_date DESC 
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    ) AS running_total_revenue
FROM Top5Filter
WHERE rnk <= 5
ORDER BY total_cust_revenue DESC , order_date ;



-- "I developed this code myself after taking some optimization concepts from ChatGPT. While the core logic is my own, I integrated ChatGPT's suggestions to improve the performance."
with cte_top5_customers_details as (
    select 
        c.customer_id,
        c.customer_key,
        c.full_name,
        c.country,
        c.gender,
        c.marital_status,
        c.birthdate,
        p.category,
        p.subcategory,
        p.product_name,
        f.order_date,
        datediff(year,c.birthdate,GETDATE()) as age,
        sum(f.quantity)  as p_quantity,
        sum(f.sales_amount) as product_wise_revenue,
        SUM(SUM(f.sales_amount)) OVER(PARTITION BY c.customer_key) AS customer_revenue
    from gold.fact_sales as f left join gold.dim_customers as c on f.customer_key=c.customer_key
    left join gold.dim_products as p on f.product_key=p.product_key
    GROUP BY c.customer_id, c.customer_key, c.full_name, c.country, c.gender, 
    c.marital_status, c.birthdate, p.category, p.subcategory, p.product_name,f.order_date
    ),

    cte_filters as (
    select 
        *,dense_rank() over(order by customer_revenue desc ) as cust_rank,
        sum(product_wise_revenue) over(partition by customer_key order by order_date desc rows between current row and unbounded following) as cum_revenue
    from cte_top5_customers_details
    )
    select 
        customer_key,full_name,country,gender,age,category,subcategory,product_name,order_date,p_quantity,product_wise_revenue,cum_revenue,customer_revenue,cust_rank
    from cte_filters where cust_rank<=5 order by cust_rank ;

select * from gold.dim_customers
select * from gold.dim_products
select * from gold.fact_sales
--ami quries speed fast korar jonno index make korsi.amer quirey onk fast korci more than 10x
create clustered columnstore index fact_sales_index on gold.fact_sales
create nonclustered index fact_customer_key on gold.fact_sales(customer_key)
create nonclustered index fact_product_key on gold.fact_sales(product_key)
create clustered index idx_customer_key on gold.dim_customers(customer_key)
create clustered index idx_product_key on gold.dim_products(product_key)