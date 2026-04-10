* ==============================================================================
* PROJECT: Impact of Castle Doctrine Laws on Crime Rates
* SCRIPT: 02_analysis.do
* PURPOSE: Run DiD, Event Study, Entropy Balancing, and CSDID Estimations
* ==============================================================================

use "castle_cleaned.dta", clear

* --- 1. Basic 2x2 DiD (2005 vs 2009) ---
display "--- Baseline DiD: Assault and Burglary ---"
gen after = (year == 2009)
reg assault i.treatment_group##i.after if (year == 2005 | year == 2009) & keep_sample == 1, vce(cluster state)
reg burglary i.treatment_group##i.after if (year == 2005 | year == 2009) & keep_sample == 1, vce(cluster state)
drop after

* --- 2. Event Study: Unweighted ---
display "--- Running Basic Event Studies ---"
reghdfe assault pre_* post_* if keep_sample == 1, absorb(sid year) vce(cluster sid)
coefplot, vertical keep(pre_* post_*) yline(0) title("Assault: Basic Event Study")

reghdfe burglary pre_* post_* if keep_sample == 1, absorb(sid year) vce(cluster sid)
coefplot, vertical keep(pre_* post_*) yline(0) title("Burglary: Basic Event Study")

* --- 3. Entropy Balancing ---
display "--- Calculating Entropy Weights (Base Year 2005) ---"
* Weights for Assault
ebalance treated police_base income_base exp_pubwelfare_base assault_base if year == 2005 & keep_sample == 1
gen wt_assault = _webal
bysort state: egen wt_assault_full = max(wt_assault)
drop _webal wt_assault

* Weights for Burglary
ebalance treated police_base income_base exp_pubwelfare_base burglary_base if year == 2005 & keep_sample == 1
gen wt_burglary = _webal
bysort state: egen wt_burglary_full = max(wt_burglary)
drop _webal wt_burglary

* --- 4. Weighted Analysis (DiD & Event Study) ---
gen after = (year == 2009)
reg assault i.treated##i.after [aweight=wt_assault_full] if year == 2005 | year == 2009, vce(cluster state)
reg burglary i.treated##i.after [aweight=wt_burglary_full] if year == 2005 | year == 2009, vce(cluster state)
drop after

* --- 5. Staggered DiD (Callaway & Sant'Anna) ---
display "--- Running CSDID (Correcting for Staggered Timing) ---"
* We reload the full dataset here to include all treatment cohorts
use "https://github.com/scunning1975/mixtape/raw/master/castle.dta", clear
gen temp_treat_year = year if post == 1
bysort sid: egen first_treat_year = min(temp_treat_year)
replace first_treat_year = 0 if missing(first_treat_year)

csdid assault, ivar(sid) time(year) gvar(first_treat_year) long2 vce(cluster sid)
estat event, window(-7 5)
csdid_plot

csdid burglary, ivar(sid) time(year) gvar(first_treat_year) long2 vce(cluster sid)
estat event, window(-7 5)
csdid_plot
