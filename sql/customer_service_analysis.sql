-- =========================================
-- 1. OVERALL KPI SUMMARY
-- =========================================

SELECT
    COUNT(*) AS total_interactions,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(AVG(fcr) * 100, 2) AS fcr_percentage,
    ROUND(AVG(escalated) * 100, 2) AS escalation_percentage,
    ROUND(AVG(sla_breached) * 100, 2) AS sla_breach_percentage,
    ROUND(AVG(response_time_min), 2) AS avg_response_time_min,
    ROUND(AVG(resolution_time_min), 2) AS avg_resolution_time_min
FROM customer_interactions;



-- =========================================
-- 2. CHANNEL PERFORMANCE
-- =========================================

SELECT
    channel,
    COUNT(*) AS total_interactions,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(AVG(fcr) * 100, 2) AS fcr_percentage,
    ROUND(AVG(escalated) * 100, 2) AS escalation_percentage,
    ROUND(AVG(sla_breached) * 100, 2) AS sla_breach_percentage,
    ROUND(AVG(response_time_min), 2) AS avg_response_time,
    ROUND(AVG(resolution_time_min), 2) AS avg_resolution_time
FROM customer_interactions
GROUP BY channel
ORDER BY total_interactions DESC;


-- =========================================
-- 3. ISSUE CATEGORY ANALYSIS
-- =========================================

SELECT
    issue_category,
    COUNT(*) AS total_interactions,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(AVG(fcr) * 100, 2) AS fcr_percentage,
    ROUND(AVG(escalated) * 100, 2) AS escalation_percentage,
    ROUND(AVG(response_time_min), 2) AS avg_response_time,
    ROUND(AVG(resolution_time_min), 2) AS avg_resolution_time
FROM customer_interactions
GROUP BY issue_category
ORDER BY escalation_percentage DESC;


-- =========================================
-- 4. TEAM PERFORMANCE
-- =========================================

SELECT
    team,
    COUNT(*) AS total_interactions,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(AVG(fcr) * 100, 2) AS fcr_percentage,
    ROUND(AVG(escalated) * 100, 2) AS escalation_percentage,
    ROUND(AVG(sla_breached) * 100, 2) AS sla_breach_percentage,
    ROUND(AVG(response_time_min), 2) AS avg_response_time,
    ROUND(AVG(resolution_time_min), 2) AS avg_resolution_time
FROM customer_interactions
GROUP BY team
ORDER BY total_interactions DESC;


-- =========================================
-- 5. MONTHLY TREND
-- =========================================

SELECT
    DATE_TRUNC('month', interaction_date) AS month,
    COUNT(*) AS total_interactions,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(AVG(fcr) * 100, 2) AS fcr_percentage,
    ROUND(AVG(escalated) * 100, 2) AS escalation_percentage,
    ROUND(AVG(sla_breached) * 100, 2) AS sla_breach_percentage,
    ROUND(AVG(response_time_min), 2) AS avg_response_time
FROM customer_interactions
GROUP BY DATE_TRUNC('month', interaction_date)
ORDER BY month;


-- =========================================
-- 6. PRIORITY ANALYSIS
-- =========================================

SELECT
    priority,
    COUNT(*) AS total_interactions,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(AVG(fcr) * 100, 2) AS fcr_percentage,
    ROUND(AVG(escalated) * 100, 2) AS escalation_percentage,
    ROUND(AVG(sla_breached) * 100, 2) AS sla_breach_percentage,
    ROUND(AVG(response_time_min), 2) AS avg_response_time
FROM customer_interactions
GROUP BY priority
ORDER BY
    CASE priority
        WHEN 'Critical' THEN 1
        WHEN 'High' THEN 2
        WHEN 'Medium' THEN 3
        WHEN 'Low' THEN 4
    END;


    -- =========================================
-- 7. CUSTOMER SEGMENT ANALYSIS
-- =========================================

SELECT
    customer_segment,
    COUNT(*) AS total_interactions,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(AVG(fcr) * 100, 2) AS fcr_percentage,
    ROUND(AVG(escalated) * 100, 2) AS escalation_percentage,
    ROUND(AVG(response_time_min), 2) AS avg_response_time
FROM customer_interactions
GROUP BY customer_segment
ORDER BY total_interactions DESC;

-- =========================================
-- 8. AGENT PERFORMANCE
-- =========================================

SELECT
    agent_id,
    COUNT(*) AS interactions_handled,
    ROUND(AVG(csat), 2) AS avg_csat,
    ROUND(AVG(fcr) * 100, 2) AS fcr_percentage,
    ROUND(AVG(escalated) * 100, 2) AS escalation_percentage,
    ROUND(AVG(response_time_min), 2) AS avg_response_time,
    ROUND(AVG(resolution_time_min), 2) AS avg_resolution_time,
    ROUND(AVG(sla_breached) * 100, 2) AS sla_breach_percentage
FROM customer_interactions
GROUP BY agent_id
HAVING COUNT(*) >= 50
ORDER BY avg_csat DESC;


-- =========================================
-- 9. HIGH-RISK INTERACTIONS
-- =========================================

SELECT
    interaction_id,
    customer_id,
    interaction_date,
    channel,
    team,
    issue_category,
    priority,
    response_time_min,
    resolution_time_min,
    csat,
    fcr,
    escalated,
    sla_breached,
    resolution_status
FROM customer_interactions
WHERE
    escalated = 1
    OR csat <= 2
    OR sla_breached = 1
ORDER BY interaction_date DESC;



-- =========================================
-- 10. TEAM PERFORMANCE VS OVERALL
-- =========================================

WITH team_metrics AS (

    SELECT
        team,
        COUNT(*) AS interactions,
        AVG(csat) AS avg_csat,
        AVG(escalated) * 100 AS escalation_rate
    FROM customer_interactions
    GROUP BY team

),

overall_metrics AS (

    SELECT
        AVG(csat) AS overall_csat,
        AVG(escalated) * 100 AS overall_escalation_rate
    FROM customer_interactions

)

SELECT
    t.team,
    t.interactions,
    ROUND(t.avg_csat, 2) AS avg_csat,
    ROUND(t.escalation_rate, 2) AS escalation_rate,

    ROUND(
        t.avg_csat - o.overall_csat,
        2
    ) AS csat_difference,

    ROUND(
        t.escalation_rate - o.overall_escalation_rate,
        2
    ) AS escalation_difference

FROM team_metrics t
CROSS JOIN overall_metrics o
ORDER BY t.team;


-- =========================================
-- 11. MONTHLY CSAT WITH ROLLING AVERAGE
-- =========================================

WITH monthly_metrics AS (

    SELECT
        DATE_TRUNC('month', interaction_date) AS month,
        AVG(csat) AS avg_csat
    FROM customer_interactions
    GROUP BY DATE_TRUNC('month', interaction_date)

)

SELECT
    month,
    ROUND(avg_csat, 2) AS avg_csat,

    ROUND(
        AVG(avg_csat) OVER (
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS rolling_3_month_csat

FROM monthly_metrics
ORDER BY month;