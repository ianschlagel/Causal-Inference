* =====================================================
* PROJECT: California Proposition 99 --- Abadie, et al. (2010) Replication 
* AUTHOR: Ian Schlagel
* =====================================================

use "https://github.com/ianschlagel/Causal-Inference/raw/main/Cal_Prop_99_Synth/Data/smoking-3.dta", clear
*browse
*ssc install synth
*net install synth_runner, from(https://raw.github.com/bquistorff/synth_runner/master/) replace

*Step 1: Run synth

* Define the full list of predictors.
* Run the main command (treatment in 1989)
xtset state year
synth cigsale lnincome(1980(1)1988) beer(1984(1)1988) age(1980(1)1988) retprice(1980(1)1988) cigsale(1975) cigsale(1980) cigsale(1988), ///
      trunit(3) ///
      counit(1 2 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39) ///
      trperiod(1989) ///
      keep(synth_results, replace) nested

preserve

*Step 2: Plot outcome
use "synth_results.dta", clear

twoway (line _Y_treated _time, lcolor(blue)) ///
       (line _Y_synthetic _time, lcolor(red) lpattern(dash)) ///
       , ///
       xline(1988, lpattern(solid) lcolor(black)) ///
       xtitle("Year") ///
       ytitle("Per-Capita Cigarette Sales (Packs)") ///
       title("Effect of Prop 99 on Cigarette Sales") ///
       xscale(range(1970 2000)) ///
       legend(order(1 "California" 2 "Synthetic California") ring(0) pos(1) col(1)) ///

restore

*Step 3: Run all lags
use "https://github.com/ianschlagel/Causal-Inference/raw/main/Cal_Prop_99_Synth/Data/smoking-3.dta", clear
xtset state year
synth cigsale cigsale(1970) cigsale(1971) cigsale(1972) cigsale(1973) cigsale(1974) cigsale(1975) cigsale(1976) cigsale(1977) cigsale(1978) cigsale(1979) cigsale(1980) cigsale(1981) cigsale(1982) cigsale(1983) cigsale(1984) cigsale(1985) cigsale(1986) cigsale(1987) cigsale(1988), ///
      unitvar(state) ///
      timevar(year) ///
      trunit(3) ///
      counit(1 2 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39) ///
      trperiod(1989) ///
      keep(synth_results_lags, replace)

preserve

use "synth_results_lags.dta", clear

*Step 4: Plot outcome
twoway (line _Y_treated _time, lcolor(blue)) ///
       (line _Y_synthetic _time, lcolor(red) lpattern(dash)) ///
       , ///
       xline(1988, lpattern(solid) lcolor(black)) ///
       xtitle("Year") ///
       ytitle("Per-Capita Cigarette Sales (Packs)") ///
       title("Effect of Prop 99 (Lags-Only Model)") ///
       xscale(range(1970 2000)) ///
       legend(order(1 "California" 2 "Synthetic California (Lags Only)") ring(0) pos(1) col(1)) ///
       ylabel(0(25)150)

restore


*Step 5: In-Time Placebo model
use "https://github.com/ianschlagel/Causal-Inference/raw/main/Cal_Prop_99_Synth/Data/smoking-3.dta", clear
xtset state year
synth cigsale lnincome(1972(1)1980) age(1970(1)1980) retprice(1970(1)1980) cigsale(1975) cigsale(1980), ///
      unitvar(state) ///
      timevar(year) ///
      trunit(3) ///
      counit(1 2 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39) ///
      trperiod(1981) ///
      keep(synth_placebo_1981, replace)

* --- 5.1. Preserve your original dataset ---
preserve

* --- 5.2. Open the new results file ---
use "synth_placebo_1981.dta", clear

* --- 5.3. Run the plot command (with 1988 cutoff) ---
twoway (line _Y_treated _time if _time <= 1988, lcolor(blue)) ///
       (line _Y_synthetic _time if _time <= 1988, lcolor(red) lpattern(dash)) ///
       , ///
       xline(1980, lpattern(dash) lcolor(gray)) ///
       xtitle("Year") ///
       ytitle("Per-Capita Cigarette Sales (Packs)") ///
       title("In-Time Placebo (Fake Treatment at 1981)") ///
       xscale(range(1970 1988)) ///
       legend(order(1 "California" 2 "Synthetic California (Placebo)") ring(0) pos(1) col(1)) ///
       ylabel(0(25)150)

* --- 5.4. Restore your original dataset ---
restore


*Step 6: Placebos for first model*
use "https://github.com/ianschlagel/Causal-Inference/raw/main/Cal_Prop_99_Synth/Data/smoking-3.dta", clear
xtset state year
synth_runner cigsale lnincome(1980(1)1988) beer(1984(1)1988) age(1980(1)1988) retprice(1980(1)1988) cigsale(1988) cigsale(1980) cigsale(1975), ///
      trunit(3) ///
      trperiod(1989) ///
      gen_vars
    single_treatment_graphs, trlinediff(-1) 
    effect_graphs , trlinediff(-1)
    pval_graphs


*Step 7: Manual Placebo plot

twoway (line effect lead if state != 3, lcolor(gs10) lwidth(thin) connect(ascending)) ///
       (line effect lead if state == 3, lcolor(black) lwidth(medthick)) ///
       , ///
       xline(0, lpattern(solid) lcolor(black)) ///
       xtitle("Years Relative to Treatment (0 = 1988)") ///
       ytitle("Gap (Actual - Synthetic)") ///
       title("In-Space Placebo Test") ///
       legend(off)
	   
*Step 7b: Edited Placebo plot

* Get California's (state == 3) pre-treatment RMSPE
quietly summarize pre_rmspe if state == 3
local cali_pre_rmspe = r(mean)

* Calculate the MSPE (RMSPE^2) and the threshold (2 * MSPE)
local cali_pre_mspe = `cali_pre_rmspe'^2
local mspe_threshold = 2 * `cali_pre_mspe'

*Check to see what that threshold is
di "California's Pre-MSPE: `cali_pre_mspe'"
di "Plotting threshold (2x): `mspe_threshold'"

* --- Manually Build the Trimmed Placebo Plot ---

twoway (line effect lead if state != 3 & (pre_rmspe^2) <= `mspe_threshold', lcolor(gs10) lwidth(thin) connect(ascending)) ///
       (line effect lead if state == 3, lcolor(black) lwidth(medthick)) ///
       , ///
       xline(0, lpattern(solid) lcolor(black)) ///
       xtitle("Years Relative to Treatment (0 = 1988)") ///
       ytitle("Gap (Actual - Synthetic)") ///
       title("In-Space Placebo Test (Pre-MSPE < 2x Treated)") ///
       legend(off)
	   
	   
*Step 8: Placebos for second model*
use "https://github.com/ianschlagel/Causal-Inference/raw/main/Cal_Prop_99_Synth/Data/smoking-3.dta", clear
xtset state year
synth_runner cigsale cigsale(1970) cigsale(1971) cigsale(1972) cigsale(1973) cigsale(1974) cigsale(1975) cigsale(1976) cigsale(1977) cigsale(1978) cigsale(1979) cigsale(1980) cigsale(1981) cigsale(1982) cigsale(1983) cigsale(1984) cigsale(1985) cigsale(1986) cigsale(1987) cigsale(1988), ///
      trunit(3) ///
      trperiod(1989) ///
      gen_vars
    single_treatment_graphs, trlinediff(-1) 
    effect_graphs , trlinediff(-1)
    pval_graphs


*Step 9: Manual Placebo plot

twoway (line effect lead if state != 3, lcolor(gs10) lwidth(thin) connect(ascending)) ///
       (line effect lead if state == 3, lcolor(black) lwidth(medthick)) ///
       , ///
       xline(0, lpattern(solid) lcolor(black)) ///
       xtitle("Years Relative to Treatment (0 = 1988)") ///
       ytitle("Gap (Actual - Synthetic)") ///
       title("In-Space Placebo Test") ///
       legend(off)

*Step 9b: Edited Placebo plot

* Get California's (state == 3) pre-treatment RMSPE
quietly summarize pre_rmspe if state == 3
local cali_pre_rmspe = r(mean)

* Calculate the MSPE (RMSPE^2) and the threshold (2 * MSPE)
local cali_pre_mspe = `cali_pre_rmspe'^2
local mspe_threshold = 2 * `cali_pre_mspe'

*Check to see what that threshold is
di "California's Pre-MSPE: `cali_pre_mspe'"
di "Plotting threshold (2x): `mspe_threshold'"

* ---  Manually Build the Trimmed Placebo Plot ---

twoway (line effect lead if state != 3 & (pre_rmspe^2) <= `mspe_threshold', lcolor(gs10) lwidth(thin) connect(ascending)) ///
       (line effect lead if state == 3, lcolor(black) lwidth(medthick)) ///
       , ///
       xline(0, lpattern(solid) lcolor(black)) ///
       xtitle("Years Relative to Treatment (0 = 1988)") ///
       ytitle("Gap (Actual - Synthetic)") ///
       title("In-Space Placebo Test (Pre-MSPE < 2x Treated)") ///
       legend(off)
	   

*Step 10: Placebos for third model*
use "https://github.com/ianschlagel/Causal-Inference/raw/main/Cal_Prop_99_Synth/Data/smoking-3.dta", clear
xtset state year
synth_runner cigsale lnincome(1972(1)1980) age(1970(1)1980) retprice(1970(1)1980) cigsale(1975) cigsale(1980), ///
      trunit(3) ///
      trperiod(1981) ///
      gen_vars ///
	  max_lead(8)
    single_treatment_graphs, trlinediff(-1) 
    effect_graphs , trlinediff(-1)
    pval_graphs


*Step 11: Manual Placebo plot

twoway (line effect lead if state != 3 & lead <= 8, lcolor(gs10) lwidth(thin) connect(ascending)) ///
       (line effect lead if state == 3 & lead <= 8, lcolor(black) lwidth(medthick)) ///
       , ///
       xline(0, lpattern(solid) lcolor(black)) ///
       xtitle("Years Relative to Treatment (0 = 1980)") ///
       ytitle("Gap (Actual - Synthetic)") ///
       title("In-Space Placebo Test (1981-1988)") ///
       legend(off)
	   
	   
	   
*Step 11b: Edited Placebo plot

quietly summarize pre_rmspe if state == 3
local cali_pre_rmspe = r(mean)

local cali_pre_mspe = `cali_pre_rmspe'^2
local mspe_threshold = 2 * `cali_pre_mspe'

di "California's Pre-1981 MSPE: `cali_pre_mspe'"
di "Plotting threshold (2x): `mspe_threshold'"


twoway (line effect lead if state != 3 & lead <= 8 & (pre_rmspe^2) <= `mspe_threshold', lcolor(gs10) lwidth(thin) connect(ascending)) ///
       (line effect lead if state == 3 & lead <= 8, lcolor(black) lwidth(medthick)) ///
       , ///
       xline(0, lpattern(solid) lcolor(black)) ///
       xtitle("Years Relative to Treatment (0 = 1980)") ///
       ytitle("Gap (Actual - Synthetic)") ///
       title("In-Space Placebo (1981-1988, Pre-MSPE < 2x Treated)") ///
       legend(off)