-- Customer Service Quality Analysis
-- Load customer_service_interactions.csv into a table named customer_interactions.

-- 1. Overall KPIs
SELECT
    COUNT(*) AS total_interactions,
    ROUND(AVG(quality_score), 2) AS avg_quality_score,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(100.0 * SUM(CASE WHEN fcr = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS fcr_rate,
    ROUND(100.0 * SUM(CASE WHEN escalated = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS escalation_rate,
    ROUND(AVG(response_time_minutes), 2) AS avg_response_minutes,
    ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_hours,
    ROUND(AVG(compliance_score), 2) AS avg_compliance_score
FROM customer_interactions;

-- 2. Agent performance
SELECT
    agent,
    COUNT(*) AS interactions,
    ROUND(AVG(quality_score), 2) AS avg_quality,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(100.0 * SUM(CASE WHEN fcr='Yes' THEN 1 ELSE 0 END)/COUNT(*), 2) AS fcr_rate,
    ROUND(100.0 * SUM(CASE WHEN escalated='Yes' THEN 1 ELSE 0 END)/COUNT(*), 2) AS escalation_rate,
    ROUND(AVG(response_time_minutes), 2) AS avg_response_minutes
FROM customer_interactions
GROUP BY agent
ORDER BY avg_quality DESC;

-- 3. Issue-level quality analysis
SELECT
    issue_type,
    COUNT(*) AS interactions,
    ROUND(AVG(quality_score), 2) AS avg_quality,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(100.0 * SUM(CASE WHEN escalated='Yes' THEN 1 ELSE 0 END)/COUNT(*), 2) AS escalation_rate
FROM customer_interactions
GROUP BY issue_type
ORDER BY avg_quality ASC;

-- 4. Low-quality interactions for RCA
SELECT
    issue_type,
    priority,
    COUNT(*) AS low_quality_cases
FROM customer_interactions
WHERE quality_score < 70
GROUP BY issue_type, priority
ORDER BY low_quality_cases DESC;

-- 5. Monthly trend
SELECT
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    ROUND(AVG(quality_score), 2) AS avg_quality,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(100.0 * SUM(CASE WHEN fcr='Yes' THEN 1 ELSE 0 END)/COUNT(*), 2) AS fcr_rate
FROM customer_interactions
GROUP BY EXTRACT(YEAR FROM date), EXTRACT(MONTH FROM date)
ORDER BY year, month;

-- 6. Pareto source table: low-quality cases by issue
SELECT
    issue_type,
    COUNT(*) AS low_quality_cases
FROM customer_interactions
WHERE quality_score < 70
GROUP BY issue_type
ORDER BY low_quality_cases DESC;
