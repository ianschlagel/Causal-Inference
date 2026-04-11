# Causal Inference & Program Evaluation

This repository serves as a portfolio of advanced econometric applications in causal inference. It features three distinct research projects utilizing quasi-experimental designs to evaluate policy impacts and market behavior.

---

## 🔬 Featured Projects

### 1. The Electoral College & Distributive Politics
**Method:** Synthetic Control Method (SCM)  
**Tools:** Stata (`synth`)
* **Overview:** Evaluates whether changes in a state's Electoral College weight (following a census) lead to shifts in federal grant allocations. 
* **Key Innovation:** Utilizes the Synthetic Control Method to construct a "Counterfactual Nevada/Colorado" to isolate the causal effect of electoral vote shifts on distributive spending.
* ****

### 2. Wine Demand Analysis: Locational Preferences in Portugal
**Method:** Almost Ideal Demand System (AIDS)  
**Tools:** R (`micEconAids`, `systemfit`)
* **Overview:** A structural demand analysis of the Portuguese wine market, investigating the substitutability between French, Italian, and Spanish imports.
* **Key Innovation:** Employs a **Universal Data Pipeline**; the R script pulls data directly from this GitHub repository to ensure 100% reproducibility across environments.
* ****

### 3. Estimating the Impact of Minimum Wage on Employment
**Method:** Regression Discontinuity Design (RDD)  
**Tools:** Stata (`rdrobust`)
* **Overview:** An analysis of employment levels across state borders with differing minimum wage policies.
* **Key Innovation:** Implements local linear regressions and sensitivity checks to validate the continuity assumption at the treatment threshold.
* ****

---

## 📂 Repository Structure

```text
├── Demand_Analysis_Portugal_Wine/
│   ├── Portugal_Wine_AIDS_Model.R     # R script (Universal Data Access)
│   ├── Portugal_Wine_Demand_Paper.pdf  # Full Research Paper
│   └── Data/                          # CSV Datasets
├── Electoral_College_Synth/
│   ├── Electoral_College_SCM.do        # Stata Replication Script
│   └── Electoral_College_Paper.pdf     # Full Research Paper
└── Minimum_Wage_RDD/
    └── Min_Wage_Analysis.do           # Stata Replication Script
