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
* **01_init_database.sql**: Creates the database and gold schema. Automates data ingestion using **BULK INSERT** with `TRY...CATCH` error handling.
  
> **Output Preview:** > ![Data Loading Output](../docs/1.png) 

### 2️⃣ Phase 2: Exploratory Data Analysis (EDA)
* **02 - 05_exploration.sql**: Auditing structure, checking constraints, and calculating foundational metrics like Total Sales and Customer Count.

> **Output Preview:** > ![EDA Results](../docs/2.png) 

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
