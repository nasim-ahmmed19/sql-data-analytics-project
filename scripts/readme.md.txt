# 📂 SQL Analytics Scripts Library

This folder contains a comprehensive collection of SQL scripts designed to transform raw data into actionable business insights. The scripts follow a structured analytical workflow, moving from initial data exploration to advanced business logic and automated reporting.

## 🚀 Execution Roadmap

For consistent results and data integrity, it is recommended to execute the scripts in the following numerical order:

### 1️⃣ Phase 1: Data Infrastructure & Health Check
* **`01_init_database.sql`**: Sets up the database architecture and required tables.
* **`02_database_exploration.sql`**: Initial audit to understand data quality and table structures.
* **`03_dimensions_exploration.sql`**: Validates descriptive data in Dimension tables (Customers, Products, etc.).
* **`04_date_range_exploration.sql`**: Analyzes the timeframe of transactions to define the analysis period.
* **`05_measures_exploration.sql`**: Checks the statistics of core numeric metrics like sales and quantity.

### 2️⃣ Phase 2: Advanced Data Analytics & KPI Development
* **`06_magnitude_analysis.sql`**: Identifies high-volume sales patterns and major business drivers.
* **`07_ranking_analysis.sql`**: Uses window functions like `RANK()` to identify top-performing entities.
* **`08_change_over_time_analysis.sql`**: Tracks growth trends and period-over-period changes.
* **`09_cumulative_analysis.sql`**: Calculates running totals and cumulative growth metrics.
* **`10_performance_analysis.sql`**: Compares actual performance against targets or previous years (YoY).
* **`11_data_segmentation.sql`**: Groups customers and products into logical tiers (e.g., High/Low Value).
* **`12_part_to_whole_analysis.sql`**: Analyzes the percentage contribution of specific categories to the total business.

### 3️⃣ Phase 3: Automated Business Reporting (Gold Layer)
* **`13_report_customers.sql`**: A consolidated view of customer behavior, featuring Recency, Lifespan, and Segmentation.
* **`14_report_products.sql`**: A comprehensive product performance report focusing on Profitability, Cost, and Average Selling Price.

---

## 🛠️ Key Technical Features
* **Optimized Architecture**: Every script utilizes **Common Table Expressions (CTEs)** to ensure modularity and high performance on large datasets.
* **Robust Logic**: Implements best practices for handling **Division by Zero** and precise data type casting for financial accuracy.
* **Medallion Approach**: Demonstrates the transition of data from raw state to "Gold" reporting layer logic.