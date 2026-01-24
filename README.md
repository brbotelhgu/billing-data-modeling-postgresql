📊 GCP FinOps Data Warehouse

SQL-first ELT · Medallion Architecture · PostgreSQL 16

Self-taught study project simulating cloud cost analysis with a production-oriented dimensional model.

Overview

This is a study project simulating a FinOps audit of GCP Billing data using PostgreSQL and a medallion-style architecture (Bronze → Silver → Gold).

It follows a SQL-first ELT approach, focusing on data modeling, data quality, and analytical transformations.
All data represents a fictional GCP billing account, created exclusively for learning purposes.

🎯 Objectives

Simulate cloud cost analysis from a FinOps perspective

Apply the medallion architecture as a logical data organization pattern

Practice dimensional modeling and partitioned fact tables

Identify usage outliers and cost patterns

Build analytical SQL views for reporting and analysis

🚀 Quick Start

Clone the repository and start PostgreSQL 16

Execute SQL scripts in order:

sql/01_bronze.sql → sql/04_gold_views.sql

Test with:

SELECT * 
FROM project.gold_top_usage 
LIMIT 10;

🏗️ Medallion Architecture

This project uses the medallion architecture as a conceptual pattern, not as an orchestrated pipeline.



<img width="883" height="425" alt="image" src="https://github.com/user-attachments/assets/7981e242-b363-471b-91aa-3a3a065e1e15" />




Bronze → raw, immutable billing data for traceability

Silver → cleaning, standardization, classification, and modeling

Gold → analytical, business-oriented views

Each layer increases data reliability and analytical value.

🥉 Bronze Layer — Raw Data

Stores raw billing records with minimal transformation

No joins or aggregations

Preserves original structure and values

Acts as the source of truth for audits and reprocessing

Table

project.raw_bronze

🥈 Silver Layer — Cleaning & Modeling

This layer contains the core ELT logic.

Key operations

Text normalization using TRIM, INITCAP, COALESCE

Rule-based classification using REGEXP

Creation of 8 dimensional tables

Partitioned fact table: main_silver

Calculation of usage percentiles (P50 / P90)

Text Classification (REGEXP)

BigQuery query text is classified using regex patterns such as:

INSERT|MERGE → write operations

SELECT\s+\* → full scans

JOIN.*?JOIN → multi-joins

GROUP BY|ORDER BY → aggregations

Fact Table

main_silver

Partitioned by invoice_month

Designed for analytical queries and window functions

🥇 Gold Layer — Analytical Views

The Gold layer exposes read-only views for BI tools or ad-hoc analysis.

Examples:

Monthly usage and cost per team

Daily cost accumulation

Cost distribution by team

Monthly rankings (ROW_NUMBER)

Outlier detection based on P90 thresholds

Window functions heavily used:

SUM() OVER

ROW_NUMBER() OVER

🧠 SQL Techniques Applied

SQL-first ELT transformations

Text cleaning and normalization

Regular expressions (~*)

Window functions (ranking, cumulative metrics)

Partitioned fact tables

Multi-table joins (8 dimensions)

🛠️ Technologies

PostgreSQL 16

pgAdmin 4

SQL


📈 Sample Results
Usage and cost per month
<img width="781" height="160" alt="image" src="https://github.com/user-attachments/assets/65332757-71f4-4ed9-9883-cb5f00d8e8bf" />


Records exceeding the P90 usage threshold
<img width="1211" height="157" alt="image" src="https://github.com/user-attachments/assets/b5b6af4a-83af-469e-8a04-358e913fd4f7" />


⚠️ Limitations

No orchestration or scheduling

Manual CSV ingestion

Local prototype only
