# 🗄️ SQL Analytics Scripts Library: Analytical Workflow

This folder contains a series of SQL scripts organized by execution order. The project follows a professional analytical path—starting from database setup and optimization to complex business logic and final automated reporting.

## 🛠️ Performance & Optimization Features
Before diving into the scripts, this project implements high-level optimization techniques:
* **Clustered Columnstore Indexes:** Applied on the `fact_sales` table to boost query performance by over **10x**.
* **Indexing Strategy:** Strategic use of Non-clustered indexes on Foreign Keys (`customer_key`, `product_key`) for lightning-fast joins.
* **Modular Logic:** Extensive use of **CTEs (Common Table Expressions)** to maintain clean, readable, and reusable code.

---

## 🚀 Script Execution Guide

### 1️⃣ Phase 1: Infrastructure & Data Loading
* **`01_init_database.sql`**: 
    * Creates the database and `gold` schema.
    * Contains a **Stored Procedure** (`gold.data_load`) with `TRY...CATCH` error handling.
    * Automates data ingestion using **BULK INSERT**.

### 2️⃣ Phase 2: Exploratory Data Analysis (EDA)
* **`02_database_exploration.sql`**: Auditing the database structure and metadata.
* **`03_dimensions_exploration.sql`**: Checking unique constraints and distributions in dimension tables.
* **`04_date_range_exploration.sql`**: Investigating the timeframe and data freshness.
* **`05_measures_exploration.sql`**: Calculating foundational metrics like Total Sales, Total Orders, and Customer Count.

### 3️⃣ Phase 3: Advanced Business Analytics
* **`06_magnitude_analysis.sql`**: Identifying the biggest revenue drivers across categories.
* **`07_ranking_analysis.sql`**: Implementing `RANK()` and `DENSE_RANK()` to find top-performing products and customers.
* **`08_change_over_time.sql`**: Time-series analysis to track monthly and yearly sales trends.
* **`09_cumulative_analysis.sql`**: Calculating **Running Totals** to observe growth momentum.
* **`10_performance_analysis.sql`**: Comparing current performance vs. Previous Year (YoY Analysis) using `LAG()`.
* **`11_data_segmentation.sql`**: Creating logical tiers (VIP, Regular, New) based on spending and lifespan.
* **`12_part_to_whole_analysis.sql`**: Percentage contribution analysis of categories to total sales.

### 4️⃣ Phase 4: Gold-Layer Reporting (Final Views)
* **`13_report_customers.sql`**: A consolidated view for **Customer Intelligence**, featuring Recency, Avg Monthly Spend, and Segment.
* **`14_report_products.sql`**: A comprehensive **Product Performance** report focusing on Profitability, Cost, and Sales Velocity.

---

## 💡 Notable Technical Achievement
In script **#07**, you will find a comparison between manual logic and optimized versions. This demonstrates the evolution of query writing—from basic problem-solving to high-performance, industry-standard SQL.

**Developed by:** [MD. Nasim Ahmmed](https://www.linkedin.com/in/md-nasim-analyest19/)
