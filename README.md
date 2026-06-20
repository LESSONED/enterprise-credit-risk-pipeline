# Enterprise Credit Risk Architecture: End-to-End Pipeline & Executive Dashboard

![Credit Risk Operations: Applicants Scoring And Default Tracking](dashboard.png)

## Business Context
Evaluating credit default risk requires more than analyzing point-in-time loan applications; it demands an understanding of historical behavioral economics. The objective of this project was to ingest, model, and visualize 13 million rows of raw transactional data to provide underwriters with an instantaneous, highly accurate risk matrix.

Instead of relying on standard BI templates, this project was built using progressive data engineering principles—pushing heavy transformations upstream to a PostgreSQL relational database and designing a custom, high-performance executive UI in Power BI.

## System Architecture & Engineering

### 1. Backend Compression (PostgreSQL)
Handling a multi-million-row relational dataset locally requires strict adherence to Roche’s Maxim: *Data should be transformed as far upstream as possible.*
* Data Ingestion: Loaded massive CSV files into a local PostgreSQL server using optimized COPY commands.
* Flattening the Grain: Engineered SQL CREATE VIEW scripts to aggregate historical bureau records and installment payments.
* Behavioral Signal Extraction: Rather than loading raw transactional noise into the BI engine, SQL was used to extract precise behavioral risk signals, such as calculating the maximum days past due (MAX(days_past_due)) and active external loan counts per applicant.

### 2. The Semantic Model (Power BI Star Schema)
By performing the heavy aggregation upstream in PostgreSQL, the BI semantic layer was kept mathematically pure.
* Cartesian Explosion Prevention: Avoided the severe performance degradation and inaccurate calculations caused by many-to-many relationships.
* Flawless Cross-Filtering: Built a perfect Star Schema with the application data acting as the central fact table, surrounded by 1-to-1 aggregated satellite views. This ensured cross-filtering across the dashboard was mathematically sound and instantaneous.
* Centralized DAX Logic: Engineered a dedicated Measure Table to house all analytical calculations (e.g., Default Rate, Avg Max Days Late), ensuring the data model remained scalable for enterprise deployment.

### 3. Interface Architecture (UI/UX)
The dashboard was treated as a modern software interface, deliberately bypassing cluttered, generic BI templates to reduce cognitive load for executive stakeholders.
* Neumorphic Skeleton: Engineered a bespoke 16:9 structural background using a strict 3-tier color system to create a clean, app-like environment.
* Visual Filtering over Slicers: Removed traditional dropdown slicers to maximize canvas real estate. The entire dashboard relies on visual cross-filtering—allowing users to click directly on demographic or income bars to seamlessly filter the macroeconomic matrix.
* High Data-to-Ink Ratio: Stripped away decorative logos, heavy borders, and unnecessary gridlines. Every pixel is dedicated to conveying mathematical risk or operational exposure.

## Key Insights & Deliverables
The final product is a dynamic Risk Matrix that allows underwriters to instantly assess baseline exposure. Key historical findings include:

* Macro-Level Risk: Analysis revealed that applicants concentrated in lower-skill labor sectors exhibited a baseline default probability significantly higher than the portfolio average, necessitating adjusted approval thresholds for these demographics.
* Behavioral Friction: Upstream extraction of historical bureau records confirmed a severe correlation between applicants with a maximum past-due history exceeding 30 days and their likelihood to default on active applications.
* Portfolio Composition: Over 90% of the institutional liquidity and overall risk exposure is heavily concentrated in standard Cash Loans rather than Revolving Credit, highlighting the critical need for strict upfront underwriting in this primary product line.
