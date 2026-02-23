/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates a schema called gold
	
WARNING:
    Running this script will drop the entire 'DataWarehouseAnalytics' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

create database  DataWarehouseAnalytics;
use datawarehouseanalytics
create schema gold


if OBJECT_ID('gold.dim_customers','u') is not null
	drop table gold.dim_customers;
create table gold.dim_customers(
	customer_key int,
	customer_id int ,
	customer_number nvarchar(50),
	full_name nvarchar(50),
	country nvarchar(50),
	marital_status nvarchar(50),
	gender nvarchar(50),
	birthdate date,
	create_date date
);
go

if OBJECT_ID('gold.dim_products','u') is not null
	drop table gold.dim_products;
create table gold.dim_products(
	product_key int,
	product_id int,
	product_number nvarchar(50),
	product_name nvarchar(50),
	category_id nvarchar(50),
	category nvarchar(50),
	subcategory nvarchar(50),
	maintenance nvarchar(50),
	cost int,
	product_line nvarchar(50),
	start_date date
);
go

if OBJECT_ID('gold.fact_sales','u') is not null
	drop table gold.fact_sales;
go
create table gold.fact_sales(
	order_number nvarchar(50),
	product_key bigint,
	customer_key bigint,
	order_date date,
	ship_date date,
	due_date date,
	sales_amount int,
	quantity int,
	price int
);

exec gold.data_load
create or alter procedure gold.data_load as
begin
	set nocount on;
	declare @row int,@start_date date,@end_date date,@batch_start_date date,@batch_end_date date;
	begin try
		set @batch_start_date=GETDATE();
		print'___________________Load all data set___________________';
		print'';
------------------------- dim_customer table _________________________
		print'-------- ***** dim_customer table ***** --------';
		set @start_date=GETDATE();
		print'Truncate dim_customers ...';
		truncate table gold.dim_customers;
		print 'loading data in dim_customers table.....';
		bulk insert gold.dim_customers from 'C:\Users\NASIM\Source\Repos\sql-data-analytics-project\dataset\gold.dim_customers.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @row=@@ROWCOUNT;
		set @end_date=GETDATE();
		print'dim_customers table load: '+cast(@row as nvarchar)+' rows in: '+cast(datediff(millisecond,@start_date,@end_date) as nvarchar)+' millisecond.';
		print'------------------- ***** -------------------';
		print' ';
------------------------------ dim products table ---------------------------------
		print'-------- ***** dim_products table ***** --------';
		set @start_date=GETDATE();		
		print'Truncate dim_products ...';
		truncate table gold.dim_products;
		print 'loading data in dim_products table.....';
		bulk insert gold.dim_products from 'C:\Users\NASIM\Source\Repos\sql-data-analytics-project\dataset\gold.dim_products.csv'
		with(
			firstrow=2,
			fieldterminator=',',
			tablock
		);

		set @row=@@ROWCOUNT;
		set @end_date=GETDATE();
		print'dim_products table load: '+cast(@row as nvarchar)+' rows in: '+cast(datediff(millisecond,@start_date,@end_date) as nvarchar)+' millisecond.';
		print'------------------- ***** -------------------';
		print' ';
-------------------------------- fact sales table -----------------------------------------
		print'-------- ***** fact_sales table ***** --------';
		set @start_date=GETDATE();
		print'Truncate gold.fact_sales ...';
		truncate table gold.fact_sales;
		print 'loading data in fact_sales table.....';
		bulk insert gold.fact_sales from 'C:\Users\NASIM\Source\Repos\sql-data-analytics-project\dataset\gold.fact_sales.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @row=@@ROWCOUNT;
		set @end_date=GETDATE();
		print'fact_sales table load: '+cast(@row as nvarchar)+' rows in: '+cast(datediff(millisecond,@start_date,@end_date) as nvarchar)+' millisecond.';
		print'------------------- ***** -------------------';
		print' ';
		set @batch_end_date=GETDATE();
		print'All table loading time: '+cast(datediff(millisecond,@batch_start_date,@batch_end_date) as nvarchar)+' millisecond.';
		print'___________________________ ***** ___________________________';
	end try
----------------------------------------------------------------------------------
	begin catch
		print'______________________________________ ***** ______________________________________';
		PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER';
		print'Error Message: '+error_message();
		print 'Error Number: '+CAST(Error_number() as nvarchar);
		print 'Error State: '+cast(error_state() as nvarchar);
		print'______________________________________ ***** ______________________________________';
	end catch
end;