# Causal Inference & Policy Evaluation

This repository features a collection of research projects focused on causal identification in public policy and political economy. Each project utilizes a distinct quasi-experimental framework to isolate treatment effects and test the robustness of modern econometric assumptions.

---

## 🔬 Featured Projects

### 1. California Proposition 99: Synthetic Control Replication
**Method:** Synthetic Control Method (SCM)  
* **Overview:** Replicates and extends the landmark **Abadie et al. (2010)** study on tobacco control.
* **Key Innovation:** Implemented an **"All-Lags" sensitivity model** and in-time/in-space placebo tests to validate the stability of the synthetic counterfactual against 38 donor states.
* **Result:** Confirms the significant divergence in smoking rates post-1988, robust to permutation testing.

### 2. Castle Doctrine Laws and Crime Rates
**Method:** Difference-in-Differences (DiD), Entropy Balancing, CSDID  
* **Overview:** Replicates and extends **Cheng & Hoekstra (2013)** to evaluate the impact of "Stand Your Ground" laws on violent and property crime.
* **Key Innovation:** Addresses staggered treatment timing using the **Callaway & Sant’Anna (2021)** estimator and ensures conditional parallel trends via **Entropy Balancing** on police presence and welfare spending.
* **Result:** Finds no evidence of deterrence; instead, reveals a significant increase in burglary following policy adoption.

### 3. Incumbency Advantage: Regression Discontinuity
**Method:** Regression Discontinuity Design (RDD)  
* **Overview:** Estimates the causal "boost" candidates receive in future elections by being the sitting incumbent.
* **Key Innovation:** Contrasts the **MSE-Optimal Continuity Approach** (16% effect) with a **Local Randomization Approach** (20% effect), identifying a narrow ±3.69% "window of randomization" where districts are statistically identical.
* **Result:** Demonstrates a significant incumbency advantage that persists even under the strictest bandwidth constraints.

---

## 📂 Repository Structure

```text
├── California_Prop99_SCM/
│   ├── Causal_SCM_Project.do     # Stata Script (Universal Data Access)
│   └── Causal_Proejct2_SC.pdf    # Technical Report & Placebo Tests
├── Castle_Doctrine_DiD/
│   ├── master.do                 # Primary Replication Pipeline
│   ├── Scripts/                  # Setup and Analysis Sub-scripts
│   └── Causal_Project1_DiD.pdf   # Technical Report & Event Study Plots
└── Incumbency_RDD/
    ├── Causal_RDD_Project.do     # Stata Script (Universal Data Access)
    └── Causal_Project3_RDD.pdf   # Technical Report & Covariate Balance
