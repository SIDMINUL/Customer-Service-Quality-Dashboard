# Customer Service Quality Analysis Dashboard

## Goal
Build a quality-analytics portfolio project aligned with a Quality Analyst role:
quality monitoring, KPI reporting, agent performance analysis, Pareto/RCA, and process-improvement insights.

## Dataset
`customer_service_interactions.csv` contains 5,000 synthetic customer-service interactions covering January-June 2025.

Important: this dataset is synthetic. It is intended for portfolio practice and dashboard development, not as real company/customer data.

## Files
- `customer_service_interactions.csv` — raw dataset for SQL/Power BI
- `analysis_queries.sql` — SQL KPI, agent, issue, RCA and trend queries
- `analysis.py` — Python validation, EDA and charts
- `customer_service_quality_analysis.xlsx` — Excel workbook with raw data and analysis sheets
- `powerbi_dashboard_guide.txt` — Power BI dashboard layout and DAX measures

## Recommended workflow
1. Inspect and clean data in Python/Excel.
2. Load the CSV into MySQL/PostgreSQL and run `analysis_queries.sql`.
3. Build the Power BI dashboard using the DAX measures and chart blueprint.
4. Take 2-3 dashboard screenshots for GitHub/portfolio.
5. Write a short README explaining the business problem, KPIs, findings and recommendations.
6. Only put numerical findings on your resume after you personally run the analysis and verify them.

## Quality Analyst concepts demonstrated
- KPI monitoring
- Data validation
- Quality-score analysis
- Agent performance evaluation
- Customer satisfaction analysis
- FCR and escalation analysis
- Pareto analysis
- Root-cause analysis
- Trend reporting
- Dashboarding
