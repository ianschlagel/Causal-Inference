* ==============================================================================
* Script 02: Synthetic Control Models (Replication & Lags)
* ==============================================================================

* --- Model 1: Abadie et al. (2010) Replication ---
* This model uses 'nested' optimization and averages predictors over 1980-1988 [cite: 1]
synth cigsale lnincome(1980(1)1988) beer(1984(1)1988) age(1980(1)1988) ///
      retprice(1980(1)1988) cigsale(1975) cigsale(1980) cigsale(1988), ///
      trunit(3) ///
      counit(1 2 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39) ///
      trperiod(1989) ///
      keep(Results/synth_results, replace) nested 

* Graphing Model 1 Results
preserve
    use "Results/synth_results.dta", clear [cite: 3]
    twoway (line _Y_treated _time, lcolor(blue)) ///
           (line _Y_synthetic _time, lcolor(red) lpattern(dash)), ///
           xline(1988, lpattern(solid) lcolor(black)) ///
           xtitle("Year") ///
           ytitle("Per-Capita Cigarette Sales (Packs)") ///
           title("Effect of Prop 99 on Cigarette Sales") ///
           xscale(range(1970 2000)) ///
           legend(order(1 "California" 2 "Synthetic California") ring(0) pos(1) col(1)) [cite: 3, 4]
    
    graph export "Results/Graph1.pdf", replace
restore


* --- Model 2: All Lags Sensitivity ---
* This version utilizes all possible lagged outcome variables and no other covariates [cite: 5]
synth cigsale cigsale(1970(1)1988), ///
      trunit(3) ///
      counit(1 2 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39) ///
      trperiod(1989) ///
      keep(Results/synth_results_lags, replace) [cite: 5]

* Graphing Model 2 Results
preserve
    use "Results/synth_results_lags.dta", clear [cite: 5]
    twoway (line _Y_treated _time, lcolor(blue)) ///
           (line _Y_synthetic _time, lcolor(red) lpattern(dash)), ///
           xline(1988, lpattern(solid) lcolor(black)) ///
           xtitle("Year") ///
           ytitle("Per-Capita Cigarette Sales (Packs)") ///
           title("Effect of Prop 99 (Lags-Only Model)") ///
           xscale(range(1970 2000)) ///
           legend(order(1 "California" 2 "Synthetic California (Lags Only)") ring(0) pos(1) col(1)) ///
           ylabel(0(25)150) [cite: 5, 6]
    
    graph export "Results/Graph2.pdf", replace
restore
