# Tableau Calculated Fields & Parameter Specifications

This document contains production-ready formulas and parameter definitions for Tableau Desktop / Tableau Public.

---

## 1. Parameters Setup

### **Parameter 1: `p_Select_Metric`**
* **Data type:** String
* **Allowable values:** List
  * `Sales Units` (Display as: "Annual Sales (Units)")
  * `Revenue` (Display as: "Annual Revenue (USD $)")
* **Current value:** `Sales Units`

### **Parameter 2: `p_Distance_Unit`**
* **Data type:** String
* **Allowable values:** List
  * `KM` (Display as: "Kilometers (km)")
  * `Miles` (Display as: "Miles (mi)")
* **Current value:** `KM`

### **Parameter 3: `p_Top_N_OEMs`**
* **Data type:** Integer
* **Allowable values:** Range
  * Minimum: `5`
  * Maximum: `20`
  * Step size: `1`
* **Current value:** `10`

---

## 2. Dynamic Calculated Fields (Driven by Parameters)

### **Calculation 1: Dynamic Metric Selector**
* **Field Name:** `[Dynamic_Sales_Metric]`
* **Formula:**
```tableau
CASE [p_Select_Metric]
  WHEN "Sales Units" THEN SUM([Annual_Sales_Units])
  WHEN "Revenue" THEN SUM([Annual_Revenue_USD])
END
```

### **Calculation 2: Dynamic Driving Range**
* **Field Name:** `[Dynamic_Driving_Range]`
* **Formula:**
```tableau
IF [p_Distance_Unit] = "KM" THEN
    [Driving_Range_km]
ELSE
    [Driving_Range_miles]
END
```

---

## 3. Executive Market Strategy (Emily Johnson — Scenario 1)

### **Calculation 3: Vehicle Category Market Share %**
* **Field Name:** `[Category_Market_Share_Pct]`
* **Formula:**
```tableau
SUM([Annual_Sales_Units]) / TOTAL(SUM([Annual_Sales_Units]))
```
* **Format:** Percentage, 2 decimal places (`37.83%`).

### **Calculation 4: Year-over-Year (YoY) Sales Growth Rate**
* **Field Name:** `[YoY_Sales_Growth_Rate]`
* **Formula:**
```tableau
(ZN(SUM([Annual_Sales_Units])) - LOOKUP(ZN(SUM([Annual_Sales_Units])), -1)) 
/ 
ABS(LOOKUP(ZN(SUM([Annual_Sales_Units])), -1))
```
* **Compute Using:** `[Model_Year]` (Table Across / Specific Dimensions: Model_Year).

### **Calculation 5: Customer Satisfaction Tier**
* **Field Name:** `[Satisfaction_Tier]`
* **Formula:**
```tableau
IF [Customer_Rating] >= 4.75 THEN "Elite Satisfaction (>= 4.75)"
ELSEIF [Customer_Rating] >= 4.50 THEN "High Satisfaction (4.50 - 4.74)"
ELSEIF [Customer_Rating] >= 4.00 THEN "Moderate Satisfaction (4.00 - 4.49)"
ELSE "Needs Improvement (< 4.00)"
END
```

---

## 4. Competitive Intelligence & Manufacturing (David Chen — Scenario 2)

### **Calculation 6: Fixed Manufacturer Market Share (LOD Expression)**
* **Field Name:** `[OEM_Market_Share_LOD]`
* **Formula:**
```tableau
{ FIXED [Manufacturer] : SUM([Annual_Sales_Units]) } 
/ 
{ FIXED : SUM([Annual_Sales_Units]) }
```
* **Description:** Accurately computes OEM market share regardless of dimension filters applied to the sheet.

### **Calculation 7: Manufacturer Rank by Sales**
* **Field Name:** `[OEM_Sales_Rank]`
* **Formula:**
```tableau
RANK_DENSE(SUM([Annual_Sales_Units]), 'desc')
```

### **Calculation 8: Top N OEM Filter Condition**
* **Field Name:** `[Filter_Top_N_OEMs]`
* **Formula:**
```tableau
[OEM_Sales_Rank] <= [p_Top_N_OEMs]
```
* **Usage:** Drag to **Filters shelf** and select `True`.

### **Calculation 9: Cost per Driving Unit (Price-to-Range Ratio)**
* **Field Name:** `[Price_to_Range_Ratio]`
* **Formula:**
```tableau
SUM([Base_Price_USD]) / SUM([Driving_Range_km])
```
* **Format:** Currency standard USD (`$115.40/km`).

---

## 5. Battery Innovation & Sustainability (Dr. Sarah Williams — Scenario 3)

### **Calculation 10: Energy Efficiency Classification**
* **Field Name:** `[Efficiency_Segment]`
* **Formula:**
```tableau
IF [Energy_Efficiency_km_per_kWh] >= 10.0 THEN "Ultra Efficient (>= 10 km/kWh)"
ELSEIF [Energy_Efficiency_km_per_kWh] >= 6.0 THEN "Standard High (6 - 9.9 km/kWh)"
ELSE "Heavy Pack Consumption (< 6 km/kWh)"
END
```

### **Calculation 11: Total Carbon Offset in Megatons (Mt)**
* **Field Name:** `[Total_Carbon_Offset_Mt]`
* **Formula:**
```tableau
SUM([Total_Carbon_Offset_Tons]) / 1000000.0
```
* **Description:** Scales tons into Millions of Metric Tons (Mt CO2e) for clean KPI card presentation.

### **Calculation 12: Battery Technology Range Benchmark**
* **Field Name:** `[Battery_Avg_Range_LOD]`
* **Formula:**
```tableau
{ FIXED [Battery_Technology] : AVG([Driving_Range_km]) }
```
