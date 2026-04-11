* ==============================================================================
* Script 03: Placebo Testing & Inference
* ==============================================================================

* --- 1. In-Time Placebo Model (Fake Treatment in 1981) ---
* Uses original predictors but a fake treatment year to check for pre-trends 
synth cigsale lnincome(1972(1)1980) age(1970(1)1980) retprice(1970(1)1980) ///
      cigsale(1975) cigsale(1980), ///
      trunit(3) trperiod(1981) ///
      counit(1 2 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39) ///
      keep(Results/synth_placebo_1981, replace)

preserve
    use "Results/synth_placebo_1981.dta", clear
    twoway (line _Y_treated _time if _time <= 1988, lcolor(blue)) ///
           (line _Y_synthetic _time if _time <= 1988, lcolor(red) lpattern(dash)) ///
           , ///
           xline(1980, lpattern(dash) lcolor(gray)) ///
           xtitle("Year") ytitle("Per-Capita Cigarette Sales (Packs)") ///
           title("In-Time Placebo (Fake Treatment at 1981)") ///
           xscale(range(1970 1988)) ///
           legend(order(1 "California" 2 "Synthetic California (Placebo)") ring(0) pos(1) col(1))
    
    graph export "Results/Graph3.pdf", replace 
restore


* --- 2. In-Space Placebos (Permutation Tests) ---
* Using synth_runner to estimate p-values for the 38 control states
synth_runner cigsale lnincome(1980(1)1988) beer(1984(1)1988) age(1980(1)1988) ///
             retprice(1980(1)1988) cigsale(1988) cigsale(1980) cigsale(1975), ///
             trunit(3) trperiod(1989) gen_vars 

* Graphing standardized p-values
pval_graphs
graph export "Results/Graph4.pdf", replace 

* Manual Placebo Plot (Standardized by Pre-MSPE) 
quietly summarize pre_rmspe if state == 3
local mspe_threshold = 2 * (r(mean)^2) 

twoway (line effect lead if state != 3 & (pre_rmspe^2) <= `mspe_threshold', lcolor(gs10) lwidth(thin)) ///
       (line effect lead if state == 3, lcolor(black) lwidth(medthick)) ///
       , ///
       xline(0, lcolor(black)) xtitle("Years Relative to Treatment") ///
       ytitle("Gap (Actual - Synthetic)") ///
       title("In-Space Placebo (Pre-MSPE < 2x Treated)") legend(off)

graph export "Results/Graph5.pdf", replace
