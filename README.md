# ⚡ Global Electric Vehicle (EV) Industry Intelligence Suite

[![GitHub Pages](https://img.shields.io/badge/Live%20Demo-GitHub%20Pages-brightgreen?style=for-the-badge&logo=github)](index.html)
[![Tableau Public](https://img.shields.io/badge/Tableau-Public%202026.3-orange?style=for-the-badge&logo=tableau)](EV_Global_Market_Intelligence.twbx)
[![Dataset](https://img.shields.io/badge/Dataset-1%2C250%20Configurations-blue?style=for-the-badge&logo=databricks)](data/ev_market_dataset.csv)
[![License](https://img.shields.io/badge/License-MIT-purple?style=for-the-badge)](LICENSE)

A production-grade Business Intelligence and Data Visualization project analyzing the global Electric Vehicle (EV) market from **2021 to 2025**, tailored specifically for three executive stakeholders:
1. **Emily Johnson** — *EV Market Strategy Director* (Market segments, revenue share, consumer sentiment)
2. **David Chen** — *Automotive Business Intelligence Manager* (OEM market share, manufacturing footprint, battery tech mix)
3. **Dr. Sarah Williams** — *Sustainable Mobility Research Analyst* (Battery chemistry frontier, driving range vs. capacity, decarbonization)

---

## 🌐 Live Web Browser Dashboard

This repository includes a standalone interactive dashboard running entirely in client-side HTML5/JavaScript (Chart.js) with zero server dependencies.

* **Live Demo:** Open `index.html` in your web browser or view via **GitHub Pages**.
* **Interactive Tabs:** Switch seamlessly between **Scenario 1 (Emily)**, **Scenario 2 (David)**, and **Scenario 3 (Sarah)**.
* **Direct Downloads:** Export filtered charts, raw CSV data, and Tableau workbooks with a single click.

---

## 📊 Tableau BI Architecture

The repository contains both `.twbx` (Tableau Packaged Workbook with extracted dataset) and `.twb` (Tableau XML specification):

* **Workbook:** [`EV_Global_Market_Intelligence.twbx`](EV_Global_Market_Intelligence.twbx)
* **Pre-Built Worksheets:**
  * `Sales by Category` (Horizontal Bar Breakdown)
  * `Top Manufacturers` (OEM Market Share Benchmark)
  * `Battery Range by Tech` (Driving Range Frontier across Solid-State, NCA, NMC, LFP, Sodium-Ion)
  * `Price vs Satisfaction` (Strategic 4-Quadrant Matrix)
* **Master Dashboard:** `Global EV Intelligence Executive Dashboard` (1366x800 responsive layout)

---

## 📁 Repository Directory Structure

```
ev_market_analysis/
│
├── index.html                         <- Live Interactive Web Dashboard (for GitHub Pages)
├── launch_project.bat                 <- Windows One-Click Project Runner
├── EV_Global_Market_Intelligence.twbx <- Tableau Packaged Workbook
├── EV_Global_Market_Intelligence.twb  <- Tableau XML Workbook
├── README.md                          <- Main project documentation
│
├── data/
│   ├── ev_market_dataset.csv          <- 1,250 realistic vehicle configurations (2021-2025)
│   ├── ev_market_summary.json         <- Pre-computed statistical aggregations & KPIs
│   └── data_dictionary.md             <- Comprehensive data schema & variable definitions
│
├── tableau/
│   ├── tableau_calculated_fields.md   <- Ready-to-use formulas (LODs, YoY, Market Share, Ratios)
│   ├── tableau_step_by_step_guide.md  <- Complete tutorial for 14 worksheets & 3 dashboards
│   └── tableau_storyboard_spec.md     <- Design specifications, hex codes, container hierarchy
│
├── reports/
│   ├── executive_summary.md           <- Executive findings and strategic recommendations
│   └── epics_and_tasks_tracker.md     <- Audit matrix for all 8 Epics and 14 Tasks
│
├── dashboard_interactive/
│   └── index.html                     <- Backup copy of browser dashboard
│
└── scripts/
    ├── generate_data.ps1              <- Dataset generator (PowerShell)
    ├── data_analysis_summary.ps1      <- Automated EDA summary script
    └── build_tableau_workbook.ps1     <- Tableau workbook builder script
```

---

## 📈 Key Findings & Strategic Insights

| Metric / Dimension | Market Benchmark | Strategic Takeaway |
| :--- | :--- | :--- |
| **Cumulative Sales** | **143.25 Million Units** | Rapid 32.4% CAGR expansion across 2021–2025 |
| **Cumulative Revenue**| **$7.02 Trillion USD** | Heavily concentrated in SUVs ($3.01T) and Sedans ($2.18T) |
| **Top Category** | **Electric SUVs (37.8%)** | 54.2M units sold; high family adoption |
| **Top OEM Leaders** | **Tesla (17.9%) & BYD (15.3%)** | Global duopoly followed by Tata Motors (6.8%) & BMW (6.8%) |
| **Solid-State Frontier**| **815 km Avg Range** | Sub-25 min charge time; next-gen long-range champion |
| **Decarbonization** | **623.4 Mt CO2e** | Disproportionate carbon abated by Electric Buses & Commercial Trucks |

---

## 🚀 How to Run Locally

### 1. Web Browser Dashboard (Instant)
Simply double-click [`index.html`](index.html) or run `launch_project.bat` and select Option `[2]`.

### 2. Tableau Public / Desktop
Double-click [`EV_Global_Market_Intelligence.twbx`](EV_Global_Market_Intelligence.twbx) to open directly in Tableau Public or Tableau Desktop.

---

## 📝 License
This project is open-source under the MIT License.
