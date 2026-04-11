# California Proposition 99: A Synthetic Control Replication

## 📋 Project Overview
This repository replicates and **extends** the landmark study by **Abadie, Diamond, and Hainmueller (2010)** regarding California’s Proposition 99. While the original study relies on a subset of economic predictors and three specific outcome lags, this project pushes the analysis further by implementing an **"All-Lags" sensitivity model** to test the absolute stability of the synthetic counterfactual.

By utilizing the **Synthetic Control Method (SCM)**, the analysis compares California's actual outcomes to a weighted "counterfactual" constructed from 38 donor states.

## 📂 Repository Contents
* **`Causal_SCM_Project.do`**: The complete Stata research script. It is designed for 100% reproducibility by pulling the required data directly from this repository's raw URL.
* **`smoking-3.dta`**: The primary dataset (Smoking panel data, 1970–2000).
* **`Causal_Proejct2_SC.pdf`**: The final technical report containing the replication results, sensitivity checks, and placebo tests.

## 🚀 Key Features of the Analysis
* **JASA Replication**: Recreates the original results using `nested` optimization and 1980–1988 predictor balancing.
* **Sensitivity Testing**: Includes an "All-Lags" model using every pre-treatment year as a predictor to test result robustness.
* **In-Time Placebo**: Runs a "fake" treatment in 1981 to validate the identification strategy.
* **In-Space Placebos**: Uses permutation testing (`synth_runner`) to calculate standardized p-values and MSPE ratios.

## 🛠 How to Replicate
To reproduce the findings on your machine:

1. **Software Requirements**: Ensure Stata is installed with the following packages:
   ```stata
   ssc install synth
   ssc install synth_runner

2. Run: **`Causal_SCM_Project.do`**
