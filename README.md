# 📊 SQL Data Analytics Portfolio: End-to-End Medallion Architecture

Welcome to my comprehensive SQL Data Analytics project. This repository demonstrates a complete data lifecycle—from database initialization and automated data loading to advanced analytical modeling and reporting using **SQL Server**.

## 🚀 Project Overview
This project showcases a structured workflow (Bronze to Gold) to transform raw e-commerce data into business-ready insights. By implementing high-performance SQL techniques, I've built a system that tracks customer behavior, product performance, and overall business growth.

### 🗺️ Project Roadmap
<p align="center">
  <img src="docs/MD.Nasim%20Ahmmed(1).png" alt="SQL Data Analytics Roadmap" width="900">
</p>

## 📂 Repository Structure
* **/dataset**: Source CSV files used for the analysis.
* **/scripts**:
    * `01_init_database.sql`: Schema creation and automated **Bulk Insert** procedure with error handling.
    * `02-05_exploration.sql`: Data profiling, health checks, and metadata exploration.
    * `06-12_analytics.sql`: Advanced analysis including **YoY Growth, Cumulative Sales, Ranking, and Segmentation**.
    * `13_report_customers.sql`: Gold-layer View for Customer Intelligence (Recency, Lifespan, VIP Status).
    * `14_report_products.sql`: Gold-layer View for Product Performance (Profitability, Cost, Segmenting).

## 💡 Key Business Insights Delivered

### 👤 Customer Intelligence
Developed a 360-degree customer view to track:
- **RFM-based Segmentation**: Categorizing customers as **VIP, Regular, or New**.
- **Customer Lifespan**: Measuring the duration from the first to the last order.
- **Recency Analysis**: Identifying inactive customers based on months since their last order.

### 📦 Product Performance
Consolidated product metrics to identify:
- **Profitability**: Calculating `total_profit` by subtracting `overall_cost` from `total_sales`.
- **Performance Tiers**: High-performer, Mid-range, and Low-performer segments based on revenue.
- **Sales Velocity**: Tracking average selling price and monthly revenue trends.

## 🛠️ Technical Skills Demonstrated
- **Performance Optimization**: Improved query speed by over **10x** using **Clustered Columnstore Indexes**.
- **Advanced SQL**: Expert use of CTEs, Window Functions (`RANK`, `LAG`, `SUM OVER`), and Stored Procedures.
- **Robust Logic**: Implementation of `TRY...CATCH` for error handling and protection against "Division by Zero".

## 👨‍💻 Author
**MD. Nasim Ahmmed** *Data Analyst*

Let's connect and discuss data!  
[🔗 LinkedIn Profile](https://www.linkedin.com/in/md-nasim-analyest19/) | [📧 Email Me](mailto:nasimahmmed807@gmail.com)
