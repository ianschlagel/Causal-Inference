# Evaluating the Impact of Castle Doctrine Laws on Violent & Property Crime
**Technical Stack:** Stata (`reghdfe`, `ebalance`, `csdid`), Causal Inference, Synthetic Control logic.

## Project Overview
This project provides a rigorous econometric evaluation of "Stand Your Ground" (Castle Doctrine) laws, replicating and extending the work of Cheng & Hoekstra (2013). The study focuses on identifying whether these laws act as a deterrent for property crime or unintentionally escalate violent confrontations.

## Data & Identification Strategy
Using a panel dataset of U.S. states (`castle.dta`), I employ three distinct identification strategies to ensure the robustness of the causal estimates:

1.  **2x2 Difference-in-Differences (DiD):** Focusing on the 2007 treatment cohort to establish a clean baseline against never-treated units.
2.  **Entropy Balancing:** Pre-processing the control group to match the treatment group's covariate moments (Income, Police presence, Public spending), ensuring a more plausible counterfactual.
3.  **Callaway & Sant’Anna (2021) CSDID:** Addressing the bias of "staggered treatment" and "forbidden comparisons" inherent in traditional Two-Way Fixed Effects (TWFE) models.

## Key Technical Implementations

### 1. Pre-Analysis Balancing
To address potential selection bias, I utilized **Entropy Balancing** to achieve perfect covariate balance between treated and control states in the pre-treatment period (2005).

| Variable | Treated (Mean) | Control (Balanced) |
| :--- | :--- | :--- |
| Median HH Income | $52,341 | $52,341 |
| Police per 100k | 28.4 | 28.4 |

### 2. Addressing Staggered Timing (CSDID)
Given that states adopted these laws at different times, I implemented the **CSDID** estimator. This ensures that "already-treated" units are not used as controls for "newly-treated" units, which can bias coefficients in standard OLS.

## Key Findings
* **Assault (Violent Crime):** Most specifications yielded null results in the immediate short-term. However, the CSDID model revealed a significant negative effect in the 5th year post-treatment, suggesting long-term shifts in violent crime dynamics.
* **Burglary (Property Crime):** Initial DiD suggested a significant increase in burglary (p=0.017). However, after applying **Entropy Balancing** and **CSDID**, the effect became less stable, highlighting the importance of proper control group weighting.
* **Deterrence Hypothesis:** The results largely fail to support the "deterrence" hypothesis, as property crime did not see a statistically significant, sustained decrease across robust specifications.

## Repository Structure
* `/Scripts`: Stata `.do` files including data cleaning, dummy variable generation for leads/lags, and estimation.
* `/Results`: Final analysis report (PDF) and high-resolution Event Study plots.
* `master.do`: Run this file to replicate the entire pipeline.

## How to Replicate
1. Ensure `reghdfe`, `ebalance`, and `csdid` are installed in Stata.
2. Run `Scripts/01_setup.do` to pull the raw data and generate running variables.
3. Run `Scripts/02_analysis.do` to generate the 8 main models and CSDID estimates.
