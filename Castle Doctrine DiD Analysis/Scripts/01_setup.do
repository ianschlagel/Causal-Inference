* ==============================================================================
* PROJECT: Impact of Castle Doctrine Laws on Crime Rates
* SCRIPT: 01_setup.do
* PURPOSE: Data ingestion and variable construction (Leads, Lags, and Cohorts)
* ==============================================================================

clear all

* --- Step 1: Data Ingestion ---
* Pulling raw data directly from the Mixtape repository to ensure reproducibility
use "https://github.com/scunning1975/mixtape/raw/master/castle.dta", clear

* --- Step 2: Cohort Identification ---
* First, we need to find the specific year each state adopted the law
gen temp_treat_year = year if post == 1
bysort state: egen first_treat_year = min(temp_treat_year)

* --- Step 3: Sample Selection for 2x2 DiD ---
* To avoid staggered treatment bias in the baseline, we focus on the 2007 wave 
* and the never-treated group.
gen keep_sample = (first_treat_year == 2007 | missing(first_treat_year))
egen treatment_group = max(post), by(state)

* --- Step 4: Relative Time Construction ---
* Creating the 'Time-to-Treatment' variable for the Event Study models
gen relative_time = year - 2007 if first_treat_year == 2007
egen treated = max(post), by(state)

* --- Step 5: Leads and Lags Generation ---
* Constructing dummies for the Event Study, omitting t-1 as the reference period
forvalues i = 7(-1)2 {
    gen pre_`i' = (treated == 1 & relative_time == -`i')
}

forvalues i = 0(1)3 {
    gen post_`i' = (treated == 1 & relative_time == `i')
}

* --- Step 6: Covariate Pre-processing ---
* Generating base-year (2005) versions of our controls for Entropy Balancing
local balance_vars "police income exp_pubwelfare"
foreach var of local balance_vars {
    gen `var'_2005 = `var' if year == 2005
    bysort state: egen `var'_base = max(`var'_2005)
    drop `var'_2005
}

* Doing the same for the outcome variables (Assault and Burglary) in 2005
gen assault_2005 = assault if year == 2005
bysort state: egen assault_base = max(assault_2005)

gen burglary_2005 = burglary if year == 2005
bysort state: egen burglary_base = max(burglary_2005)

* Clean up helper variables
drop temp_treat_year assault_2005 burglary_2005
save "castle_cleaned.dta", replace
