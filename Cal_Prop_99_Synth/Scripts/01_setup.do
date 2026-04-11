* ==============================================================================
* Script 01: Data Ingestion
* ==============================================================================

* --- Step 1: Data Ingestion ---
* Pulling raw data directly from your repository to ensure reproducibility
use "https://github.com/ianschlagel/Causal-Inference/raw/main/Cal_Prop_99_Synth/Data/smoking-3.dta", clear

* --- Step 2: Panel Setup ---
* State 3 is California; data spans 1970-2000
xtset state year

display "Data successfully loaded from GitHub. Ready for Synthetic Control estimation."
