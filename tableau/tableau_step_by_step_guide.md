# Tableau Step-by-Step Construction Guide

This guide details how to build all **14 Worksheets**, **3 Interactive Dashboards**, and the **Master Storyboard** in Tableau Desktop or Tableau Public.

---

## Part 1: Connecting Data & Project Setup

1. Open **Tableau Desktop** or **Tableau Public**.
2. Under **Connect > To a File**, click **Text file** (or Excel).
3. Select `data/ev_market_dataset.csv`.
4. Verify the Data Source preview:
   * Ensure `Manufacturing_Country` is detected as **Geographic Role: Country/Region** (globe icon).
   * Ensure `Model_Year` is recognized as an Integer or Date.
   * Switch the connection to **Extract** for maximum performance.
5. Create a new Worksheet and navigate to the Sheet workspace.

---

## Part 2: Dashboard 1 — Executive Market Strategy (Emily Johnson)

### **Worksheet 1.1: Executive KPI Cards**
* **Columns:** *(None)*
* **Rows:** *(None)*
* **Marks Card (Text):**
  * `AGG([Dynamic_Sales_Metric])`
  * `AVG([Driving_Range_km])`
  * `AVG([Customer_Rating])`
  * `[Total_Carbon_Offset_Mt]`
* **Formatting:** Set text size to 24pt Bold for values, 10pt Regular for labels.

### **Worksheet 1.2: Annual Sales by Vehicle Category**
* **Columns:** `SUM([Annual_Sales_Units])`
* **Rows:** `[Vehicle_Category]` (Sort descending by sales)
* **Color:** `[Vehicle_Category]` (Use Tableau 10 or modern palette)
* **Label:** `SUM([Annual_Sales_Units])` and `[Category_Market_Share_Pct]` (Format as % of total)
* **Visual Type:** Horizontal Bar Chart.

### **Worksheet 1.3: Price vs. Satisfaction Strategic Matrix**
* **Columns:** `AVG([Base_Price_USD])`
* **Rows:** `AVG([Customer_Rating])`
* **Detail:** `[Model_Name]`
* **Color:** `[Vehicle_Category]`
* **Size:** `SUM([Annual_Sales_Units])`
* **Analytics Pane:** Drag **Average Line** onto both X and Y axes to create a 4-quadrant benchmark (High Value / High Satisfaction).

### **Worksheet 1.4: Multi-Year Segment Adoption Trend**
* **Columns:** `[Model_Year]` (Discrete)
* **Rows:** `SUM([Annual_Sales_Units])`
* **Color:** `[Vehicle_Category]`
* **Visual Type:** Stacked Area Chart or Multi-Line Chart with markers.

---

## Part 3: Dashboard 2 — OEM Competitive BI & Global Hubs (David Chen)

### **Worksheet 2.1: Manufacturer Market Share Treemap**
* **Marks:** Treemap
* **Text / Label:** `[Manufacturer]`, `[OEM_Market_Share_LOD]`
* **Size:** `SUM([Annual_Sales_Units])`
* **Color:** `SUM([Annual_Sales_Units])` (Sequential Blue or Teal)
* **Filter:** Drag `[Filter_Top_N_OEMs]` to Filters shelf, check `True`.

### **Worksheet 2.2: Global Manufacturing Footprint (Map)**
* **Marks:** Filled Map or Symbol Map
* **Detail:** `[Manufacturing_Country]` (Tableau auto-generates Latitude & Longitude)
* **Size:** `SUM([Annual_Sales_Units])`
* **Color:** `SUM([Annual_Sales_Units])`
* **Tooltip:** Include Country, Total Vehicles Produced, Top Manufacturer, and Dominant Battery Tech.

### **Worksheet 2.3: Battery Portfolio Mix by OEM**
* **Columns:** `SUM([Annual_Sales_Units])` (Add Quick Table Calc > **Percent of Total**, Compute using: Cell)
* **Rows:** `[Manufacturer]` (Top 10 OEMs)
* **Color:** `[Battery_Technology]` (Distinct categorical colors: LFP = Orange, NMC = Blue, NCA = Purple, Solid-State = Green, Sodium-Ion = Yellow)
* **Visual Type:** 100% Stacked Bar Chart.

### **Worksheet 2.4: Price-to-Range Efficiency Benchmark**
* **Columns:** `[Price_to_Range_Ratio]`
* **Rows:** `[Manufacturer]` (Sorted ascending — lower cost per km is superior value)
* **Color:** `[Price_to_Range_Ratio]` (Diverging Red-Green, reversed so lower values are green).

---

## Part 4: Dashboard 3 — Battery Innovation & Sustainability (Dr. Sarah Williams)

### **Worksheet 3.1: Driving Range Distribution by Battery Tech (Box Plot)**
* **Columns:** `[Battery_Technology]`
* **Rows:** `[Driving_Range_km]`
* **Detail:** `[Vehicle_ID]`
* **Show Me:** Select **Box-and-Whisker Plots**.
* **Insight:** Clearly highlights the leap in driving range offered by Solid-State batteries (>800 km) vs. mature LFP and NMC chemistries.

### **Worksheet 3.2: Battery Capacity vs. Driving Range Frontier**
* **Columns:** `[Battery_Capacity_kWh]`
* **Rows:** `[Driving_Range_km]`
* **Detail:** `[Model_Name]`
* **Color:** `[Battery_Technology]`
* **Size:** `[Charging_Time_Min]` (Reversed: smaller circles = faster charging)
* **Analytics Pane:** Add **Linear Trend Line** to demonstrate energy density elasticity.

### **Worksheet 3.3: Battery Technology Evolution Over Time**
* **Columns:** `[Model_Year]`
* **Rows:** `SUM([Annual_Sales_Units])`
* **Color:** `[Battery_Technology]`
* **Visual Type:** Area Chart illustrating the rise of Sodium-Ion and Solid-State batteries from 2023 onward.

### **Worksheet 3.4: Environmental Impact & Carbon Abatement**
* **Columns:** `[Vehicle_Category]`
* **Rows:** `[Total_Carbon_Offset_Mt]`
* **Color:** `[Vehicle_Category]`
* **Label:** `[Total_Carbon_Offset_Mt]` (Formatted to 1 decimal place with "Mt CO2e" suffix).

---

## Part 5: Assembling the Dashboards & Actions

### **Dashboard 1 Setup (Emily Johnson — Market Strategy):**
1. Canvas Size: **1366 x 768 px** (Fixed) or **Automatic**.
2. Top: Header container with Title, Subtitle, and Parameter Controls (`p_Select_Metric`, `p_Distance_Unit`).
3. Upper Middle: KPI Summary Cards (Worksheet 1.1) in a Horizontal Container.
4. Lower Section: Split container with Worksheet 1.2 (Sales by Category) on left, and Worksheet 1.3 (Price vs. Rating) + Worksheet 1.4 (Multi-Year Trend) on right.
5. **Dashboard Filter Action:** Configure a filter action where clicking a Vehicle Category in Sheet 1.2 filters Sheets 1.3 and 1.4.

### **Dashboard 2 Setup (David Chen — OEM Intelligence):**
1. Canvas Size: **1366 x 768 px**.
2. Top: Parameter `p_Top_N_OEMs` slider + Country dropdown filter.
3. Left: Worksheet 2.1 (Treemap) and Worksheet 2.4 (Price per km).
4. Right: Worksheet 2.2 (Global Map) and Worksheet 2.3 (Battery Mix Stacked Bar).
5. **Dashboard Filter Action:** Clicking any country on the map filters the OEM list and Battery mix to that country's assembly plants.

### **Dashboard 3 Setup (Dr. Sarah Williams — R&D & Sustainability):**
1. Canvas Size: **1366 x 768 px**.
2. Top: Environmental Carbon Savings Banner.
3. Upper Section: Worksheet 3.1 (Box Plot) and Worksheet 3.2 (Capacity vs. Range Frontier).
4. Lower Section: Worksheet 3.3 (Technology Evolution) and Worksheet 3.4 (Carbon Abatement).

---

## Part 6: Creating the Master Tableau Story

1. Click **New Story** tab at the bottom of Tableau.
2. Set Story Canvas Size: **1366 x 800 px**.
3. **Story Point 1:** Drag *Dashboard 1* — Title: *"Executive Strategy: Category Sales & High-Growth Segments"*.
4. **Story Point 2:** Drag *Dashboard 2* — Title: *"Competitive Intelligence: OEM Market Share & Global Production"*.
5. **Story Point 3:** Drag *Dashboard 3* — Title: *"Technological Frontier: Battery Innovation & Green Impact"*.
6. Add Story Navigator captions summarizing key findings on each tab.
7. Save workbook as `EV_Industry_Intelligence_Suite.twbx` (Tableau Packaged Workbook).
