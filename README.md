# 📊 Customer Service Quality Analysis Dashboard

An end-to-end **Customer Service Quality Analysis** project built to analyze customer-service interactions, monitor quality KPIs, evaluate agent performance, identify low-quality interaction patterns, and support root-cause analysis.

The project combines **Python, SQL, Excel, and Power BI** to demonstrate a practical data-analysis and business-reporting workflow.

> **Dataset:** 5,000 synthetic customer-service interactions covering January–June 2025. The dataset is for portfolio/educational use and contains no real customer or company data.

## 📌 Dashboard Preview

![Customer Service Quality Dashboard](Customer_Service_Quality_Dashboard.png)

## 🎯 Project Objectives

This project answers key operational questions:

- What is the overall customer-service quality?
- How satisfied are customers?
- What is the First Contact Resolution (FCR) rate?
- How frequently are cases escalated?
- Which agents perform above or below the overall quality level?
- Which issue types are associated with lower quality?
- Where are low-quality interactions concentrated?
- How does service quality change over time?

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| **Python** | Data validation, KPI analysis, EDA and visualization |
| **Pandas / NumPy** | Data manipulation and analysis |
| **SQL / MySQL** | KPI queries, aggregation and performance analysis |
| **Excel** | Data analysis and reporting |
| **Power BI** | Interactive dashboard and business reporting |
| **Git / GitHub** | Version control and project documentation |

## 📂 Repository Structure

```text
Customer-Service-Quality-Dashboard/
├── customer_service_interactions.csv          # Synthetic source dataset
├── analysis.py                                 # Python analysis workflow
├── analysis_queries.sql                         # SQL analysis queries
├── customer_service_quality_analysis.xlsx     # Excel analysis workbook
├── Customer_Service_Quality_Dashboard.xlsx    # Excel dashboard workbook
├── Customer_Service_Quality_Dashboard.pbix    # Power BI report
├── Customer_Service_Quality_Dashboard.png     # Dashboard preview
├── DEPLOYMENT.md                               # Power BI publishing guide
└── README.md
```

## 📊 Dataset

The dataset contains customer-service interaction records with fields including:

- `Interaction_ID`
- `Date`
- `Agent`
- `Issue_Type`
- `Priority`
- `Channel`
- `Response_Time_Minutes`
- `Resolution_Time_Hours`
- `Resolution_Status`
- `FCR`
- `Escalated`
- `Quality_Score`
- `CSAT`
- `Compliance_Score`

## 📈 Key KPIs

| KPI | Value |
|---|---:|
| Total Interactions | **5,000** |
| Average Quality Score | **81.5** |
| Average CSAT | **4.38 / 5** |
| FCR Rate | **77.96%** |
| Escalation Rate | **7.26%** |
| Average Response Time | **91.93 min** |
| Average Resolution Time | **40.99 hrs** |
| Average Compliance | **91.43%** |

These figures are calculated from the synthetic dataset included in the repository.

## 📊 Dashboard Analysis

The Power BI dashboard provides:

- **KPI monitoring** — interactions, quality, CSAT, FCR, escalation, response time, resolution time and compliance.
- **Monthly quality trends** — tracks changes in average quality over time.
- **Agent performance** — compares quality and service metrics across agents.
- **Issue-type analysis** — identifies issue categories with weaker quality performance.
- **Low-quality analysis** — examines interactions with `Quality_Score < 70` for root-cause analysis.
- **Interactive filters** — Date, Agent, Issue Type, Priority and Channel.

## 🧮 Key DAX Measures

### Total Interactions

```dax
Total Interactions =
COUNTROWS(Raw_Data)
```

### Average Quality

```dax
Avg Quality =
AVERAGE(Raw_Data[Quality_Score])
```

### Average CSAT

```dax
Avg CSAT =
AVERAGE(Raw_Data[CSAT])
```

### FCR Rate

```dax
FCR Rate =
DIVIDE(
    CALCULATE(
        COUNTROWS(Raw_Data),
        Raw_Data[FCR] = "Yes"
    ),
    [Total Interactions]
)
```

### Escalation Rate

```dax
Escalation Rate =
DIVIDE(
    CALCULATE(
        COUNTROWS(Raw_Data),
        Raw_Data[Escalated] = "Yes"
    ),
    [Total Interactions]
)
```

### Low Quality Cases

```dax
Low Quality Cases =
CALCULATE(
    COUNTROWS(Raw_Data),
    Raw_Data[Quality_Score] < 70
)
```

## 🔍 Analysis Workflow

```text
Synthetic Customer-Service Data
            ↓
Data Validation & Cleaning
            ↓
Python Exploratory Analysis
            ↓
SQL KPI & Performance Analysis
            ↓
Quality / Issue Analysis
            ↓
Low-Quality & Root-Cause Analysis
            ↓
Power BI Dashboard
            ↓
Business Insights & Reporting
```

## 🗄️ SQL Analysis

`analysis_queries.sql` contains queries for:

1. Overall KPI calculation
2. Agent-level performance
3. Issue-level quality analysis
4. Low-quality interactions for root-cause analysis
5. Monthly quality, CSAT and FCR trends
6. Pareto source analysis for low-quality cases

## 🐍 Python Analysis

`analysis.py` performs:

- Dataset shape and missing-value checks
- Duplicate interaction-ID checks
- KPI calculation
- Agent performance analysis
- Issue-level analysis
- Low-quality Pareto analysis
- Monthly quality/CSAT trends
- Portfolio-ready trend charts

## 🚀 How to Use

### Python

```bash
pip install pandas numpy matplotlib
python analysis.py
```

### SQL

Load `customer_service_interactions.csv` into a table named `customer_interactions`, then run:

```text
analysis_queries.sql
```

### Excel

Open either Excel workbook in Microsoft Excel for spreadsheet-based analysis and reporting.

### Power BI

Open `Customer_Service_Quality_Dashboard.pbix` in **Power BI Desktop** to explore the interactive report.

For publishing instructions, see [`DEPLOYMENT.md`](DEPLOYMENT.md).

## 💡 Business Insights This Project Supports

The analysis can help identify:

- Quality gaps across agents or issue categories
- Relationships between CSAT, FCR and quality
- High concentrations of low-quality cases
- Escalation-heavy service areas
- Trends that may require process improvement
- Operational areas where coaching or workflow changes could improve service quality

## 📌 Skills Demonstrated

- Data Cleaning & Validation
- SQL / MySQL
- Python
- Pandas / NumPy
- Exploratory Data Analysis
- KPI Development
- Customer Service Quality Analysis
- Customer Satisfaction Analysis
- Agent Performance Analysis
- Root-Cause Analysis
- Pareto Analysis
- Trend Analysis
- Power BI
- Dashboard Development
- Business Reporting

## 👨‍💻 Author

**Abdul Momin Siddiqui**

B.Tech — Electronics & Communication Engineering  
Indian Institute of Information Technology, Ranchi

- LinkedIn: `/in/abdul-momin-siddiqui-903147225/`
- GitHub: `SIDMINUL`

## ⚠️ Disclaimer

This project is intended for educational and portfolio purposes. The customer-service dataset is **synthetic** and should not be interpreted as real customer, employee, or company data.