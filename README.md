# India Tech Hiring Analytics

> An end-to-end data analytics project analyzing 97,682 Indian job postings to understand technology hiring, fresher opportunities, skills, salaries, locations, and tech-adjacent roles.

## 📌 Project Overview

This project analyzes the Indian job market to answer:

- Which technology roles have the most opportunities?
- Which skills are frequently requested?
- Where are fresher-friendly tech jobs concentrated?
- How do salaries vary across technology roles?
- What technology-adjacent opportunities exist?

The analysis was performed using **Python, PostgreSQL, SQL, and Excel**.

## 🛠️ Tools Used

Python · Pandas · NumPy · Regex (re) · PostgreSQL · SQL · Excel

## 📊 Key Findings

| Metric | Finding |
|---|---:|
| Total Job Postings | **97,682** |
| Technology Jobs | **22,325** |
| Fresher-Friendly Tech Jobs | **1,803** |
| Tech-Adjacent / Borderline Jobs | **3,015** |
| Fresher-Friendly Tech-Adjacent Jobs | **214** |

### Technology Roles

The largest technology categories were:

- Software Development — **8,579**
- Cloud / DevOps — **3,419**
- Data Engineering — **2,491**
- QA / Testing — **1,849**
- Data Science / ML — **1,347**
- Data Analytics — **1,183**

### Data Analytics Skills

Frequently listed skills in Data Analytics postings included:

**Data Analysis · Power BI · SQL · Python · Tableau · Advanced Excel**

### Salary Analysis

Median salaries varied considerably across technology roles. Among salary-disclosed postings:

- AI / GenAI — **₹22.5 LPA**
- Data Engineering — **₹20 LPA**
- Data Science / ML — **₹18 LPA**
- Software Development — **₹15 LPA**
- Data Analytics — **₹9.5 LPA**

## 📂 Project Files

| File | Description |
|---|---|
| 📊 [Excel Dashboard](./India_Tech_Market_Dashboard.xlsx) | Complete dashboard, salary, skills and career analysis |
| 🗃️ [SQL Analysis](./India_tech_market_sql_analysis.sql) | PostgreSQL business questions and queries |
| 📄 [Cleaned Dataset](./india_tech_market_cleaned.csv) | Cleaned dataset used for analysis |

The Excel workbook contains:

**Dashboard · Salary Analysis · Skills Analysis · Career Insights · Market Analysis · Cleaned Data**

## 🔄 Workflow

```text
Raw Data
   ↓
Python Cleaning & Feature Engineering
   ↓
PostgreSQL
   ↓
SQL Business Analysis
   ↓
Excel Dashboard
   ↓
Insights

⚠️ Limitations
The dataset represents job postings, not confirmed hires.
Salary analysis uses only postings with disclosed INR salaries.
"Fresher-friendly" means minimum experience requirement ≤ 1 year.
Tech / Non-Tech classification is rule-based.
Findings describe the dataset and are not forecasts of future hiring.

👩‍💻 Author
Niyati Gupta
B.Tech — Computer Science & Data Science

Skills: Python · SQL · PostgreSQL · Excel · Data Analysis · Data Cleaning · Data Visualization
