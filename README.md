# 📊 SQL Data Analytics Portfolio: Strategic Business Intelligence

Welcome to my SQL Data Analytics project. This repository is built on a structured Data Warehouse environment where I transform Gold-layer tables into high-value business insights. The project focuses on the analytical journey—from data exploration and auditing to advanced performance analysis and automated reporting.

---

## 🗺️ Project Roadmap
<p align="center">
  <img src="MD.Nasim%20Ahmmed(1).jpg" alt="SQL Data Analytics Roadmap" width="900">
</p>

---

## 🚀 Performance & Optimization Features
To ensure enterprise-grade analytics, I implemented advanced SQL optimization techniques:

| Feature | Implementation Detail | Business Value |
| :--- | :--- | :--- |
| **Indexing Strategy** | Clustered Columnstore Indexes on `fact_sales`. | Massive data compression and 10x faster query execution. |
| **Join Optimization** | Non-clustered indexes on Foreign Keys. | Seamless integration between fact and dimension tables. |
| **Modular Logic** | Extensive use of Common Table Expressions (CTEs). | Clean, readable, and highly maintainable codebase. |

---

## 📑 Analytical Workflow Highlights
<p align="center">
  <img src="Gemini_Generated_Image_9hdlky9hdlky9hdl.jpg" alt="Analytical Workflow Highlights" width="600">
</p>

---

## 📑 Analytical Roadmap
The project follows a logical analytical workflow to ensure data integrity and actionable outputs:
1. **🏗️ Infrastructure**: Environment setup and automated data loading.
2. **🔍 Exploration**: Comprehensive data profiling and health audits.
3. **📊 Analytics**: Ranking, Time-series analysis, and Strategic Segmentation.
4. **📈 Reporting**: Final automated business views for executive decision-making.

---

## 📁 Repository Structure & Script Guide
For a deep dive into each analytical phase, please visit the [**Scripts Library**](./scripts).

### 🏗️ 1. Infrastructure: Database & Schema Setup
* **`01_init_database.sql`**: Features a robust **Stored Procedure** (`gold.data_load`) for high-performance ingestion using **BULK INSERT** and `TRY...CATCH` error resilience.

### 🔍 2. Exploration: Auditing Data Quality
* **`02-05_exploration.sql`**: Audits schema constraints, customer demographics, and core business measures (Total Sales, Volume, and Active Customers).

### 📊 3. Analytics: Strategic Insights & Performance
* **`06-12_analytics.sql`**:
    * **Ranking**: Identifying Top/Bottom performers using Window Functions.
    * **Time-Series**: Tracking **YoY Growth** and Monthly Sales Trends.
    * **Segmentation**: Dividing customers into **VIP, Regular, and New** tiers.

### 📈 4. Reporting: Automated Gold Layer Reports
* **`13-14_reports.sql`**: Consolidated 360-degree views of **Customer Intelligence** and **Product Profitability**.

---

## 💡 Top Business Insights Delivered

* **🚀 10x Performance**: Optimized queries to run 10 times faster than baseline SQL logic.
* **🚲 Revenue Anchor**: Identified that the **'Bikes'** category drives over **96%** of total revenue.
* **💎 Customer Value**: Established a segmentation model that identifies high-value **VIP customers** for targeted marketing.
* **📈 Growth Tracking**: Implemented automated YoY benchmarking to identify seasonal growth momentum.

---

## 🎯 Project Conclusion
This project bridges the gap between raw data and business strategy. By focusing on both **Technical Optimization** (Indexing, CTEs) and **Business Intelligence** (RFM, YoY, Profitability), it demonstrates a complete framework for modern data analytics.

---

## 👨‍💻 Connect with Me
**MD. Nasim Ahmmed** *Data Analyst*

[🔗 LinkedIn Profile](https://www.linkedin.com/in/md-nasim-analyest19/) | [📧 Email Me](mailto:nasimahmmed807@gmail.com)
