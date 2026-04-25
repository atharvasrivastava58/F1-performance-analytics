# 🏆 Formula 1 Performance Analytics Dashboard (1950–2024)

> **F1 is often seen as driver-driven — this analysis shows it's actually system-driven.**

---

## 📌 Project Summary

A two-page interactive Power BI dashboard built on SQL queries in Google BigQuery, analysing 74 years of Formula 1 World Championship data (1950–2024).

**Three core questions:**
- Which drivers and teams dominated — and why?
- Does operational efficiency (pit stops) explain outcomes as much as driver talent?
- Which circuits are genuinely unpredictable, and what does that mean for race strategy?

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| **SQL (Google BigQuery)** | Data extraction, cleaning, multi-table joins, STDDEV calculations |
| **Power BI** | Interactive dashboard, DAX measures, KPI cards, visual design |
| **DAX** | Custom measures — filtered DISTINCTCOUNT, CALCULATE with date/status filters |
| **Data Modelling** | Star schema across 9 relational tables with optimised aggregations in BigQuery |

---

## 📂 Dataset

**Source:** Kaggle — Formula 1 World Championship (1950–2024), originally compiled from the Ergast F1 API.

| Metric | Value |
|--------|-------|
| Races covered | 1,125 |
| Lap records | 589,000+ |
| Drivers (filtered scope) | **757** |
| Relational tables used | 9 |
| Years | 1950–2024 |

### Why 757 drivers — not 782 or 861?

The dataset returns **861 entries**, which includes drivers outside the filtered analytical scope (non-starters and Indianapolis 500 participants). The FIA recognises ~782 drivers historically.

This project uses **757** based on three filters:
- 1950–2024 date range only
- Indianapolis 500 excluded
- Only drivers who started a race (grid > 0)

This ensures all analysis reflects active race participants within a consistent competitive context.

---

## 📊 Dashboard Structure
![Executive Overview](dashboard_page1.png)
![Deep Analysis](dashboard_page2.png)

### Page 1 — Executive Overview

| Visual | Insight |
|--------|---------|
| KPI Cards | 757 drivers, 589K laps, 1K races |
| Top Driver Card | Lewis Hamilton — 94 wins |
| Bar Chart: Win Totals (2010–2024) | Hamilton vs Verstappen era comparison |
| Line Chart: 2023 Points Progression | Verstappen's dominant season by round |

### Page 2 — Deep Analysis

| Visual | Insight |
|--------|---------|
| Pit Stop Bar Chart | Red Bull leads operational efficiency (2010–2024) |
| DNF Rate by Circuit | Australia highest-risk; strategy implications |
| Lap Consistency Chart | Leclerc most consistent in 2023 — Ferrari still lost |
| Constructor Points | Mercedes + Red Bull structural dominance confirmed |

---

## 🔍 Key Findings

**1. Modern F1 is a team sport, not an individual one**
Data suggests car performance and team capability often outweigh individual driver skill. Hamilton's 94 wins reflect Mercedes superiority as much as personal talent.

**2. Pit stop efficiency compounds into a strategic advantage**
Red Bull's consistently lower average stop times (~1–1.5 seconds faster than competitors) create undercut and overcut opportunities that reshape race outcomes. For teams, investing in pit stop operations can deliver returns comparable to driver performance improvements.

**3. Consistency ≠ Championship**
Leclerc was the most consistent driver in 2023. Ferrari still finished third. Individual metric optimisation without addressing systemic performance constraints does not deliver results.

**4. High DNF circuits demand a different risk model**
Circuit risk, not just driver error, drives DNFs. Australia's rate is the highest in the dataset — a strategic input for race engineers, not just an observation.

**5. Early momentum defines seasons**
Verstappen's 2023 advantage started at Round 5 and continued to grow with each race. Early-season momentum in F1 can eliminate competitive pressure for an entire season.

> These insights support performance benchmarking, race strategy optimisation, and operational decision-making in high-pressure environments.

---

## ⚙️ Data Preprocessing (SQL — BigQuery)

```sql
-- Safe casting to fix inconsistent data types across decades
SAFE_CAST(milliseconds AS INT64) AS lap_ms

-- Filter invalid pit stop durations
WHERE duration_seconds BETWEEN 1.5 AND 120

-- DNF classification
CASE WHEN status NOT IN ('Finished', '+1 Lap', '+2 Laps') THEN 1 ELSE 0 END AS dnf_flag

-- Lap time consistency (standard deviation)
STDDEV(milliseconds) AS lap_stddev

-- Exclude Indianapolis 500
WHERE races.name != 'Indianapolis 500'

-- Starters only
WHERE grid > 0
```

---

## 📐 DAX Measures (Power BI)

```dax
-- Filtered driver count (757)
Total_Drivers =
CALCULATE(
    DISTINCTCOUNT(drivers[driverId]),
    FILTER(results, results[grid] > 0),
    races[name] <> "Indianapolis 500",
    YEAR(races[date]) >= 1950 && YEAR(races[date]) <= 2024
)

-- DNF Rate per circuit
DNF_Rate = DIVIDE(COUNTROWS(FILTER(results, [dnf_flag] = 1)), COUNTROWS(results)) * 100
```

---

## ⚠️ Limitations

- **Weather conditions:** not captured — significantly influences DNF rates and lap consistency at specific circuits
- **Mid-season car upgrades:** not reflected — team metrics are season averages
- **Budget differences:** not captured in the dataset
- **Pit stop data:** available from 2010 only
- **Driver count (757):** reflects filtered scope — see Dataset section for full explanation
- **External factors:** tyre choices, safety car timing, qualifying penalties out of scope

---

## 📁 Repository Structure
f1-performance-analytics/
│
├── sql/
│   ├── 01_data_cleaning.sql
│   ├── 02_driver_analysis.sql
│   ├── 03_pit_stop_efficiency.sql
│   ├── 04_circuit_dnf_analysis.sql
│   ├── 05_consistency_analysis.sql
│   └── 06_constructor_points.sql
│
├── powerbi/
│   ├── F1_Analytics_Dashboard.pbix
│   └── dashboard.png
│
├── report/
│   └── F1_Analytics_Report.docx
│
└── README.md
---

## 🚀 How to Use

1. Clone this repository
2. Run SQL files in `/sql/` sequentially in Google BigQuery against the Kaggle dataset
3. Open `F1_Analytics_Dashboard.pbix` in Power BI Desktop
4. Read `F1_Analytics_Report.docx` for full methodology and insight interpretation

---

## 👤 Author

**Atharva Santosh Srivastava**
Data Analytics | SQL · Power BI · DAX · Data Modelling

- LinkedIn: [linkedin.com/in/atharvasrivastava-automotive](https://linkedin.com/in/atharvasrivastava-automotive)
- GitHub: [github.com/atharvasrivastava58](https://github.com/atharvasrivastava58/F1-performance-analytics)

---

*Dataset: Kaggle — Formula 1 World Championship (1950–2024) | Originally from Ergast F1 API*
