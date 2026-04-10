# Impact Analysis: Castle Doctrine Laws and Crime Rates
**Methods:** Difference-in-Differences (DiD), Event Study, Entropy Balancing, Callaway & Sant’Anna (CSDID)  
**Tools:** Stata (`reghdfe`, `ebalance`, `csdid`, `coefplot`)

## Project Overview
This project replicates and extends the study by **Cheng & Hoekstra (2013)** to evaluate the causal effect of "Stand Your Ground" (Castle Doctrine) laws on violent and property crime. Using panel data from the United States, the analysis investigates whether these laws successfully deter crime or unintentionally escalate violence through increased lethal confrontations.

## Identification Strategy
To ensure a robust causal claim and account for the complexities of observational data, I implemented a tiered econometric approach:

1.  **Baseline 2x2 DiD:** A focused analysis on the 2007 treatment wave—the largest single-year policy adoption in the sample—against never-treated states to establish a clean counterfactual.
2.  **Entropy Balancing:** A preprocessing step using the `ebalance` algorithm. I balanced the first moments (means) of treatment and control groups on key covariates (Police per 100k, Median HH Income, and Public Welfare Spending) to satisfy the conditional parallel trends assumption.
3.  **Event Study:** A dynamic specification used to test for pre-treatment parallel trends and visualize the specific timing of treatment effects for both Assault and Burglary.
4.  **Callaway & Sant’Anna (2021):** Implementation of the `csdid` estimator to address the potential bias of "forbidden comparisons" inherent in traditional Two-Way Fixed Effects (TWFE) when treatment timing is staggered.

## Key Findings
* **Property Crime (Burglary):** While initial models suggested a significant increase in burglary (approx. 64 per 100k), results were sensitive to weighting. However, the robust **CSDID estimator** identified a significant increase in burglaries (15 per 100k) specifically within the first year of law adoption.
* **Violent Crime (Assault):** Standard DiD models yielded null results. However, the staggered event study revealed a significant **negative effect** on assaults five years post-treatment (approx. 112 per 100k), suggesting potential long-run behavioral shifts.
* **Deterrence Hypothesis:** Overall, the results fail to provide evidence that Castle Doctrine laws act as an immediate or meaningful deterrent for property or violent crime.

## Repository Structure
* `master.do`: The primary replication script that runs the entire pipeline.
* `Scripts/01_setup.do`: Handles data ingestion from the Mixtape repository and variable construction (leads, lags, and treatment cohorts).
* `Scripts/02_analysis.do`: Contains all econometric estimations, entropy balancing, and graph generation commands.
* `Results/`: Contains the full technical report (PDF) and high-resolution Event Study plots.

## How to Replicate
1.  **System Requirements:** Open Stata and ensure the following packages are installed:
    ```stata
    ssc install reghdfe
    ssc install ebalance
    ssc install csdid
    ssc install drdid
    ```
2.  **Execution:** Clone this repository, set your working directory to this project folder, and execute:
    ```stata
    do master.do
    ```
