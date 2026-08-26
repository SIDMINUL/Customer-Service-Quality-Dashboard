import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("customer_service_interactions.csv", parse_dates=["Date"])

# Basic data-quality checks
print("Shape:", df.shape)
print("\nMissing values:\n", df.isna().sum())
print("\nDuplicate interaction IDs:", df["Interaction_ID"].duplicated().sum())

# KPI summary
kpis = {
    "Total Interactions": len(df),
    "Avg Quality Score": round(df["Quality_Score"].mean(), 2),
    "Avg CSAT": round(df["CSAT"].mean(), 2),
    "FCR Rate %": round((df["FCR"].eq("Yes").mean()) * 100, 2),
    "Escalation Rate %": round((df["Escalated"].eq("Yes").mean()) * 100, 2),
    "Avg Response (min)": round(df["Response_Time_Minutes"].mean(), 2),
    "Avg Resolution (hrs)": round(df["Resolution_Time_Hours"].mean(), 2),
    "Avg Compliance": round(df["Compliance_Score"].mean(), 2),
}
print("\nKPIs:\n", pd.Series(kpis))

# Agent performance
agent_perf = (
    df.groupby("Agent")
      .agg(
          Interactions=("Interaction_ID", "count"),
          Quality=("Quality_Score", "mean"),
          CSAT=("CSAT", "mean"),
          FCR=("FCR", lambda x: (x == "Yes").mean() * 100),
          Escalation=("Escalated", lambda x: (x == "Yes").mean() * 100),
          Avg_Response=("Response_Time_Minutes", "mean"),
      )
      .round(2)
      .sort_values("Quality", ascending=False)
)
print("\nTop 5 agents:\n", agent_perf.head())
print("\nBottom 5 agents:\n", agent_perf.tail())

# Issue analysis
issue_perf = (
    df.groupby("Issue_Type")
      .agg(
          Interactions=("Interaction_ID", "count"),
          Quality=("Quality_Score", "mean"),
          CSAT=("CSAT", "mean"),
          Escalation=("Escalated", lambda x: (x == "Yes").mean() * 100),
      )
      .round(2)
      .sort_values("Quality")
)
print("\nIssue performance:\n", issue_perf)

# Pareto analysis of low-quality cases
low = df[df["Quality_Score"] < 70]
pareto = low.groupby("Issue_Type").size().sort_values(ascending=False).to_frame("Low_Quality_Cases")
pareto["Cumulative_%"] = pareto["Low_Quality_Cases"].cumsum() / pareto["Low_Quality_Cases"].sum() * 100
print("\nPareto table:\n", pareto)

# Monthly trend
monthly = (
    df.assign(Month=df["Date"].dt.to_period("M").astype(str))
      .groupby("Month")
      .agg(Quality=("Quality_Score", "mean"), CSAT=("CSAT", "mean"))
      .reset_index()
)
print("\nMonthly trend:\n", monthly.round(2))

# Optional charts for your portfolio screenshots
monthly.plot(x="Month", y="Quality", kind="line", marker="o", title="Monthly Quality Score")
plt.tight_layout()
plt.savefig("monthly_quality_trend.png", dpi=180)
plt.close()

issue_perf["Quality"].sort_values().plot(kind="barh", title="Quality Score by Issue Type")
plt.tight_layout()
plt.savefig("quality_by_issue.png", dpi=180)
plt.close()
