# Tableau Storyboard Visual & Design Specification

### 1. Typography & Hierarchy
* **Dashboard Header:** Tableau Bold, 20pt, Dark Charcoal (`#1E293B`)
* **Section / Sheet Titles:** Tableau Semi-Bold, 13pt, Slate (`#334155`)
* **KPI Metrics:** Tableau Bold, 24pt, Dark Slate (`#0F172A`)
* **KPI Sub-labels:** Tableau Book, 9pt, Neutral Grey (`#64748B`)
* **Axis & Legend Titles:** Tableau Medium, 9pt, Slate (`#475569`)
* **Data Labels & Tooltips:** Tableau Book, 8.5pt, Neutral (`#334155`)

---

### 2. Standardized Color Palettes

#### **A. Vehicle Category Palette (Categorical 6)**
* **SUV:** `#2563EB` (Royal Blue)
* **Sedan:** `#0D9488` (Teal)
* **Two-Wheeler:** `#EA580C` (Warm Amber / Orange)
* **Hatchback:** `#8B5CF6` (Purple)
* **Truck:** `#475569` (Slate Grey)
* **Electric Bus:** `#059669` (Emerald Green)

#### **B. Battery Technology Palette (Technical 5)**
* **Solid-State:** `#10B981` (Vibrant Emerald - Next Gen)
* **NCA:** `#6366F1` (Indigo - Premium)
* **NMC:** `#3B82F6` (Electric Blue - Mainstream)
* **LFP:** `#F59E0B` (Amber - Cost / Durability)
* **Sodium-Ion:** `#EC4899` (Pink / Magenta - Urban / Fast Cycle)

#### **C. Diverging Value Palette (Price-to-Range / Efficiency)**
* **High Value (Low $/km):** `#10B981` (Green)
* **Average Value:** `#F59E0B` (Amber)
* **Premium / Low Efficiency:** `#EF4444` (Red)

---

### 3. Container Hierarchy & Layout Rules

```
Dashboard Canvas (1366 x 768 px)
│
├── [Vertical Container] Root Container (Background: #F8FAFC, Outer Padding: 12px)
│   │
│   ├── [Horizontal Container] Header Container (Height: 64px, White Card: #FFFFFF)
│   │   ├── Title & Persona Badge (Left aligned)
│   │   └── Parameter Controls & Global Year Filter (Right aligned)
│   │
│   ├── [Horizontal Container] KPI Metrics Ribbon (Height: 90px, 4 Equal-width White Cards)
│   │   ├── Card 1: Cumulative Sales
│   │   ├── Card 2: Market Revenue
│   │   ├── Card 3: Avg Driving Range
│   │   └── Card 4: Customer Satisfaction
│   │
│   └── [Horizontal Container] Main Visual Workspace (Height: 570px)
│       ├── [Vertical Container] Primary Analytics Area (Width: 62%)
│       │   ├── Sheet Visual A (Top)
│       │   └── Sheet Visual B (Bottom)
│       │
│       └── [Vertical Container] Secondary / Breakdown Area (Width: 38%)
│           ├── Sheet Visual C (Top)
│           └── Sheet Visual D (Bottom)
```

---

### 4. Interactive Action Directives

| Action Name | Source Sheet | Target Sheet | Run Action On | Filter / Parameter Target |
| :--- | :--- | :--- | :--- | :--- |
| **`act_Category_CrossFilter`** | Sheet 1.2 (Sales by Category) | Sheet 1.3 & 1.4 | Select (Click) | `[Vehicle_Category]` |
| **`act_Country_GeoDrill`** | Sheet 2.2 (Global Map) | Sheet 2.1 & 2.3 | Select (Click) | `[Manufacturing_Country]` |
| **`act_Battery_Filter`** | Sheet 3.1 (Box Plot) | Sheet 3.2 & 3.3 | Select (Click) | `[Battery_Technology]` |
| **`act_Reset_Hover`** | Any Sheet | Context Tooltip | Hover | Shows Model Specs & Price/Range |
