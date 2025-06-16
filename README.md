# End-to-End-Data-Pipeline-and-Transformation-for-Global-Indicators-Using-Databricks-DBT-and-Power-BI

---

# 🌍 Global Development Dashboard: End-to-End EDA & Visualisation Using Databricks, dbt (MSSQL), and Power BI

This project showcases an end-to-end data pipeline and visualisation process for analysing global development indicators between **2000 and 2020** using:

* 🧠 **Databricks** (for notebook-based data exploration and transformation)
* 🏗️ **dbt (MSSQL)** (for structured modelling and SQL transformation)
* 📊 **Power BI** (for dashboard design and storytelling)

---

## 📁 Repository Structure

```
├── dbt-mssql/
│   ├── import/                     # Contains bar population data and schema.sql for database setup
│   ├── global_development/        # Your dbt project folder (you must match this with your own project name)
│   │   ├── models/                # Modified SQL models (to merge with your existing dbt project)
│   │   ├── dbt_project.yml        # Updated dbt configuration file
│   │   └── ...                    # Other dbt project files
│
├── data/                           # Raw CSV files for Databricks notebook execution
│   └── *.csv
│
├── Global_Development.ipynb        # Databricks-compatible notebook for EDA and data transformation
│   └── (Note: This notebook also references its own required data)
│
├── powerbi/
│   └── Global_Development.pdf      # Exported Power BI dashboard (since Desktop .pbix not included)
│
└── README.md                       # This file

```

---

## 🚀 Getting Started

### 1. Databricks

* Launch **Databricks**.
* Open and run `Global_Development.ipynb`.
* It processes the data using Spark and prepares it for further transformation.
* Ensure the raw CSVs from the `/data` folder are uploaded into your Databricks environment.

### 2. dbt (MSSQL)

* Navigate to the `dbt-mssql/global_development` directory.
* Initialise your dbt project using:

  ```bash
  dbt init global_development
  ```
* Merge the provided `models/` folder and `dbt_project.yml` file into your initialised project.
* Place `import/bar_population.csv` and use `schema.sql` to create the necessary tables in your MSSQL database.
* Run the dbt transformations:

  ```bash
  dbt run
  ```

### 3. Power BI

* Open Power BI Desktop.
* Connect to your MSSQL database where the transformed models are stored.
* Build dashboards or refer to the included `Global_Development.pdf` for design examples (note: the PDF is used because Power BI Desktop doesn't export `.pbix` natively for version control).

---

## 📈 What’s Visualised?

The dashboards explore:

* **Economic Indicators** (GNI, GDP, inflation, unemployment)
* **Tourism Analytics** (arrivals, departures, revenue vs. GDP)
* **Environmental Trends** (CO₂ emissions, renewable usage)
* **Social Development** (internet usage, life expectancy, human development)

Each dashboard is built using **DAX**, calculated fields, smart filters, and storytelling visuals to uncover 20 years of global development trends.

---

## 📬 Contact

For any questions, feedback, or collaboration opportunities:
🔗 [LinkedIn – Aidin Miralmasi](https://www.linkedin.com/in/aidin-miralmasi)

---

