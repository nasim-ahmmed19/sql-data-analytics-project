# 🗄️ SQL Analytics Scripts Library: Analytical Workflow

This folder contains a series of SQL scripts organized by execution order. The project follows a professional analytical path—starting from database setup and optimization to complex business logic and final automated reporting.

## 🛠️ Performance & Optimization Features
Before diving into the scripts, this project implements high-level optimization techniques:
* **Clustered Columnstore Indexes:** Applied on the `fact_sales` table to boost query performance.
* **Indexing Strategy:** Strategic use of Non-clustered indexes on Foreign Keys for lightning-fast joins.
* **Modular Logic:** Extensive use of CTEs for clean and reusable code.

---

## 🚀 Script Execution Guide

### 1️⃣ Phase 1: Infrastructure & Data Loading
* **`01_init_database.sql`**: This script serves as the backbone of the project, responsible for database creation and schema definition.
* **Automated Data Pipeline**: It features a robust **Stored Procedure** (`gold.data_load`) designed for high-performance data ingestion:
    * **Dynamic Truncation**: Automatically clears existing data to ensure a fresh load every time.
    * **High-Speed Ingestion**: Utilizes the **BULK INSERT** command to load thousands of records from CSV files in milliseconds.
    * **Audit & Logging**: Prints detailed execution logs, including the number of rows processed and the time taken for each table.
    * **Error Resilience**: Implemented with a `TRY...CATCH` block to capture and display descriptive error messages (Error Number, State, and Message) in case of failures.

> **Output Preview:**
<p align="left">
  <img src="../docs/1.png" width="500">
</p>


### 2️⃣ Phase 2: Structural Exploration & Data Quality Audit
This phase is dedicated to understanding the technical foundation of the database and ensuring the integrity of the dimension tables.

* **`02_database_exploration.sql`**: Audits the entire database structure. It uses system views like `INFORMATION_SCHEMA.TABLES` and `COLUMNS` to verify data types, nullability, and schema constraints.
* **`03_dimensions_exploration.sql`**: Performs a deep dive into the business entities.
    * **Customer Demographics**: Analyzes customer distribution by country to identify key markets.
    * **Product Categorization**: Audits the product catalog to ensure correct mapping of categories and subcategories.

> **Output Preview:**
<div style="display: flex; justify-content: space-between;">
  <img src="../docs/2.png" width="400" />
  <img src="../docs/3.png" width="400" />
</div>

---

### 3️⃣ Phase 3: Date Range Profiling & Key Business Measures
In this phase, I transitioned from structural audit to behavioral analysis, identifying the timeframe of the data and calculating the core "Vital Signs" of the business.

* **`04_date_range_exploration.sql`**: Focuses on the temporal aspect of the data.
    * **Order Lifecycle**: Calculates the months of data available and identifies the first and last transaction dates.
    * **Customer Demographics**: Analyzes the age range of the customer base using `DATEDIFF()` on birthdates to understand target audience maturity.
* **`05_measures_exploration.sql`**: The "Executive Summary" script.
    * **Unified Metrics**: I developed a consolidated report using `UNION ALL` that presents **Total Sales (in Millions)**, **Total Order Volume**, and **Active Customer Base** in a single high-level view.
    * **Averages & Totals**: Calculates critical KPIs like Average Selling Price and total quantity sold to establish a performance baseline.

> **Output Preview:**
<div style="display: flex; justify-content: space-between;">
  <img src="../docs/4.png" width="400" />
  <img src="../docs/5.png" width="400" />
</div>

### 3️⃣ Phase 3: Advanced Business Analytics
* **06 - 09_analysis.sql**: Revenue drivers, Ranking, and Time-series analysis to track trends and Running Totals.
* **10 - 12_performance_&_segmentation.sql**: **YoY Analysis** using `LAG()` and creating logical tiers (VIP, Regular, New) based on spending.

> **Output Preview:** > ![Advanced Analytics](../docs/output_analytics.png) *(এখানে র‍্যাঙ্কিং বা সেগমেন্টেশনের স্ক্রিনশট দিন)*

### 4️⃣ Phase 4: Gold-Layer Reporting (Final Views)
* **13_report_customers.sql**: Customer Intelligence (Recency, Avg Spend, Segment).
* **14_report_products.sql**: Product Performance (Profitability, Cost, Sales Velocity).

> **Output Preview:** > ![Final Gold Report](../docs/output_report.png) *(এখানে ফাইনাল ভিউ বা রিপোর্টের স্ক্রিনশট দিন)*

---

## 💡 Notable Technical Achievement
In script **#07**, you will find a comparison between manual logic and optimized versions. This demonstrates the evolution of query writing—from basic problem-solving to high-performance, industry-standard SQL.

**Developed by:** [MD. Nasim Ahmmed](https://www.linkedin.com/in/md-nasim-analyest19/)
