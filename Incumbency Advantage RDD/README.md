# Incumbency Advantage: Regression Discontinuity Analysis

## 📋 Project Overview
This project provides a rigorous econometric evaluation of the **Incumbency Advantage**. Using a **Regression Discontinuity Design (RDD)**, the analysis estimates the causal "boost" a candidate receives in future elections simply by being the sitting incumbent.

The analysis follows two distinct econometric traditions to ensure robustness:
1. **The Continuity Approach**
2. **The Local Randomization Approach**

## 🔬 Research Method & Findings

### 1. Continuity vs. Local Randomization
This project highlights a critical debate in modern econometrics regarding bandwidth selection:
* **Continuity (MSE-Optimal)**: The software-selected "optimal" bandwidth was **26.579%**. This yields an incumbency advantage of ~**16.18%**. 
* **Local Randomization**: By forcing strict covariate balance (testing `BlackPct`, `ForgnPct`, `GovWkPct`, etc.), I identified a much narrower "window of randomization" at **±3.690%**.
* **Key Finding**: Even under the stricter local randomization window, the incumbency advantage remains highly significant, with an estimated margin boost of **19.5% to 20.4%**.

### 2. Covariate Balance Check
I tested 5 major demographic and political covariates for continuity at the cutoff to validate the RDD assumptions:
* **BlackPct, ForgnPct, GovWkPct, VtTotPct, and GovDem.**
* All covariates exhibited strong balance ($p > 0.15$), confirming that districts that barely win are statistically comparable to those that barely lose.

## 📂 Repository Contents
* **`Causal_RDD_Project.do`**: The complete Stata research script. It is configured for universal reproducibility, pulling data directly from this repository's raw URL.
* **`RDReplication-2.dta`**: The replication dataset
* **`Causal_Project3_RDD.pdf`**: The final technical report, including density plots, covariate balance tables, and sensitivity checks across various polynomial degrees.
