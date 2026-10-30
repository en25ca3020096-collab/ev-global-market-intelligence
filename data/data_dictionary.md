# Electric Vehicle (EV) Industry Data Dictionary

**Dataset File:** `data/ev_market_dataset.csv`  
**Total Records:** 1,250 observations  
**Temporal Coverage:** 2021 – 2025  
**Domain:** Global Automotive & Sustainable Transportation BI  

---

### Fields & Variable Definitions

| Variable Name | Data Type | Tableau Role | Description | Allowed / Sample Values | Unit |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **`Vehicle_ID`** | String | Dimension | Unique identification key for each vehicle model configuration. | `EV-10001`, `EV-10002`... | Text Key |
| **`Model_Year`** | Integer / Date | Dimension | Model release and reporting year. | `2021`, `2022`, `2023`, `2024`, `2025` | YYYY |
| **`Manufacturer`** | String | Dimension | Electric vehicle Original Equipment Manufacturer (OEM). | Tesla, BYD, Volkswagen, BMW, Mercedes-Benz, Hyundai, Kia, Ford, Rivian, NIO, Volvo, Geely, Tata Motors, Ather Energy, Ola Electric, Zero Motorcycles, Proterra, Scania | Brand Name |
| **`Model_Name`** | String | Dimension | Specific commercial model name of the vehicle. | Model 3, Model Y, Seal, Dolphin, ID.4, Ioniq 5, EV6, i4, Mach-E, F-150 Lightning, R1T, ET7, Nexon EV, 450X, S1 Pro | Model Name |
| **`Vehicle_Category`** | String | Dimension | Vehicle classification segment. | Hatchback, Sedan, SUV, Electric Bus, Truck, Two-Wheeler | Category |
| **`Battery_Technology`** | String | Dimension | Core battery chemistry architecture powering the pack. | Lithium Iron Phosphate (LFP), Nickel Manganese Cobalt (NMC), Nickel Cobalt Aluminum (NCA), Sodium-Ion, Solid-State | Chemistry |
| **`Battery_Capacity_kWh`** | Float | Measure | Total usable battery pack energy capacity. | `2.5` to `600.0` | Kilowatt-hour (kWh) |
| **`Driving_Range_km`** | Float | Measure | Certified WLTP / EPA estimated driving range per full charge. | `80` to `1000` | Kilometers (km) |
| **`Driving_Range_miles`**| Float | Measure | Driving range converted to imperial miles (`Range_km * 0.621371`). | `50` to `621` | Miles |
| **`Charging_Time_Min`** | Integer | Measure | DC Fast Charging time required to charge battery from 10% to 80% SoC. | `12` to `90` | Minutes |
| **`Base_Price_USD`** | Float | Measure | Base MSRP / retail selling price in US Dollars. | `$1,200` to `$520,000` | USD ($) |
| **`Annual_Sales_Units`** | Integer | Measure | Total volume of vehicle units delivered/sold in the given calendar year. | `800` to `250,000` | Vehicles Sold |
| **`Annual_Revenue_USD`** | Float | Measure | Total gross sales revenue (`Annual_Sales_Units * Base_Price_USD`). | Computed metric | USD ($) |
| **`Manufacturing_Country`**| String | Dimension (Geo) | Primary assembly facility country of origin (Geographic Role: Country/Region). | USA, China, Germany, South Korea, India, Sweden | Country Name |
| **`Customer_Rating`** | Float | Measure | Normalized aggregate customer satisfaction score (scale 1.0 to 5.0). | `3.2` to `5.0` | Rating Score |
| **`Energy_Efficiency_km_per_kWh`** | Float | Measure | Energy consumption efficiency ratio (`Driving_Range_km / Battery_Capacity_kWh`). | `1.5` to `25.0` | km / kWh |
| **`Price_per_Range_USD_per_km`** | Float | Measure | Cost-to-range value metric (`Base_Price_USD / Driving_Range_km`). | `$15` to `$1,200` | USD / km |
| **`Total_Carbon_Offset_Tons`** | Float | Measure | Estimated annual CO2 greenhouse gas emissions avoided compared to an equivalent ICE vehicle. | `600` to `1,000,000` | Metric Tons CO2e |

---

### Integrity Rules & Validation Checks

1. **No Null Values:** All 1,250 rows have 100% complete field occupancy.
2. **Standardized Geographies:** `Manufacturing_Country` names match Tableau's internal worldwide geographic database directly for instant plotting on symbol/choropleth maps.
3. **Valid Battery Distributions:** Emerging chemistries like `Solid-State` are restricted to 2024–2025, while mature chemistries (`LFP`, `NMC`, `NCA`) span the entire timeline.
