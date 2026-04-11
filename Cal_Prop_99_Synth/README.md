# California Proposition 99: A Synthetic Control Replication

## 📋 Project Overview
This repository replicates and extends the landmark study by **Abadie, Diamond, and Hainmueller (2010)** regarding the impact of California’s 1988 tobacco control program (Proposition 99). 

The analysis utilizes the **Synthetic Control Method (SCM)** to construct a "Counterfactual California" from a donor pool of 38 states. By comparing the actual cigarette consumption in California to this synthetic version, I evaluate the program's effectiveness in reducing smoking rates.

## 🚀 Key Features
* **Exact Replication:** Successfully recreates the original JASA paper results using `nested` optimization and specific covariate matching (1980–1988).
* **Sensitivity Analysis:** Tests the model's robustness using an "All-Lags" approach, utilizing every pre-treatment year as a predictor.
* **In-Time Placebo:** Validates the identification strategy by running a "fake" treatment in 1981 to ensure the model doesn't find effects where none should exist.
* **In-Space Placebos (Permutation Tests):** Leverages `synth_runner` to generate p-values and MSPE ratios, providing a rigorous statistical basis for inference.

## 📂 Repository Structure
* **`master.do`**: The primary replication script that executes the entire pipeline.
* **`Scripts/`**: 
    * `01_setup.do`: Downloads the smoking dataset and prepares the panel structure (`xtset`).
    * `02_synth_models.do`: Estimates the Abadie replication and the all-lags sensitivity model.
    * `03_placebo_tests.do`: Executes in-time and in-space (permuted) placebo tests.
* **`Results/`**: 
    * `California_Smoking_Report.pdf`: The final technical report containing SCM plots and predictor balance tables.

## 📊 Summary of Findings
The baseline model suggests that Proposition 99 reduced cigarette consumption by approximately **20 packs per capita annually** by the year 2000. Permutation tests confirm that California's divergence is an outlier relative to the 38 donor states, yielding a standardized p-value of **p < 0.05**.

## 🛠 How to Replicate
1. **System Requirements:** Open Stata and ensure the following packages are installed:
   ```stata
   ssc install synth
   ssc install synth_runner
