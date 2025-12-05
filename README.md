# Sales Analytics Project: dbt, BigQuery & GitHub

A sample end-to-end data‑engineering / analytics project demonstrating how to use dbt with BigQuery to transform and manage large datasets (1M+ records) with version control through GitHub, and a modular dbt project structure.

## 🔎 Project Overview

- Generate a synthetic dataset (1,000,000+ records) in BigQuery for demonstration / testing.  
- Use dbt to build staging, transformation, and modelling layers on top of that data.  
- Use Jinja macros and standard SQL for reusable, maintainable transformations.  
- Maintain full version control of your analytical code (models, macros, seeds, configs) via GitHub.  
- Demonstrate a clean dbt project structure for production‑grade analytics pipelines.

## 🧰 Technologies & Tools Used

- **dbt (Data Build Tool)** — for data transformations, modeling, testing, and documentation.  
- **BigQuery (Google Cloud)** — as the data warehouse / analytics engine.  
- **SQL + Jinja macros** — for dynamic, reusable SQL transformations.  
- **Git / GitHub** — version control for all code (models, macros, configs, etc.). 

## ✅ Prerequisites

- A Google Cloud Platform (GCP) project with BigQuery enabled.  
- A service account JSON key with appropriate BigQuery permissions (e.g. BigQuery Admin / data editor + job user).  
- Python 3.9+ (or any version compatible with dbt + BigQuery adapter).  
- dbt installed with BigQuery adapter (`pip install dbt-bigquery`).  
- git installed and configured for version control.

## Quick Start / Setup

1. Configure dbt profiles
```dbt init <project_name>```

2. Authenticate with Google Cloud or Service Account json key
3. Test the conection
> N.B. Navigate to the project's directory first
```dbt debug```

4. Generate the raw dataset to be used in this project (in BigQuery)
```sql
CREATE OR REPLACE TABLE your_project.your_dataset.raw_sales AS
WITH raw_data AS (
  SELECT
    GENERATE_UUID() AS order_id,
    ARRAY<STRING>['Laptop', 'Phone', 'Tablet', 'Headphones', 'Monitor'][OFFSET(CAST(FLOOR(RAND() * 5) AS INT64))] AS product_name,
    CAST(FLOOR(RAND() * 7000 + 100) AS INT64) AS amount,
    ARRAY<STRING>['USA', 'UK', 'Canada', 'Germany', 'France'][OFFSET(CAST(FLOOR(RAND() * 5) AS INT64))] AS country,
    DATE_ADD(DATE '2024-01-01', INTERVAL CAST(FLOOR(RAND() * 365) AS INT64) DAY) AS order_date,
    CAST(FLOOR(RAND() * 100) AS INT64) AS discount
  FROM UNNEST(GENERATE_ARRAY(1, 1000000))  -- Generates 1 Million Rows
)
SELECT * FROM raw_data;
```
5. Run dbt models
```dbt compile      # Check the models syntax and run```

```dbt run          # Run all models```

```dbt test         # Run tests on models```

## Resources:
This project is inspired by the DBT Crash Course below

[DBT Crash Course](https://www.youtube.com/watch?v=RdiOhhHIAmI)
