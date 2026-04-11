* =====================================================
* PROJECT: Incumbency Advantage Replication
* AUTHOR: Ian Schlagel
* =====================================================

use "https://github.com/ianschlagel/Causal-Inference/raw/main/Incumbency%20Advantage%20RDD/Data/RDReplication-2.dta", clear

use "C:\Users\ischlage\Downloads\RDReplication-2.dta", clear

*ssc install rddensity, replace
*ssc install lpdensity, replace
*net install rdrobust, from(https://raw.githubusercontent.com/rdpackages/rdrobust/master/stata) replace

* Perform the manipulation test on the margin variable
rddensity margin, c(0) all

rddensity margin, c(0) plot h(5/3)

*** 1. COVARIATE: ForgnPct (Foreign-born Percentage) ***
rdrobust ForgnPct margin, c(0)
rdplot ForgnPct margin, c(0) p(2)
* p(1) requests a linear fit

*** 2. COVARIATE: GovWkPct (Government Worker Percentage) ***
rdrobust GovWkPct margin, c(0)
rdplot GovWkPct margin, c(0) p(2)

*** 3. COVARIATE: BlackPct (Black Population Percentage) ***
rdrobust BlackPct margin, c(0)
rdplot BlackPct margin, c(0) p(2)

*** 4. COVARIATE: VtTotPct (Voter-to-Total Population Percentage) ***
rdrobust VtTotPct margin, c(0)
rdplot VtTotPct margin, c(0) p(2)

*** 5. COVARIATE: GovDem (Governor is a Democrat Dummy) ***
rdrobust GovDem margin, c(0)
rdplot GovDem margin, c(0) p(2)

*Estimate the model:*

*======== p=1 =========*
rdrobust outcome margin, c(0)

* Plot the outcome using the optimal bandwidth and linear polynomial (p=1)
*Put optimal bandwidth output inside h()
rdplot outcome margin, c(0) h(26.579) p(1)


*======== p=2 =========*
rdrobust outcome margin, c(0) h(53.158) p(2)
*
rdplot outcome margin, c(0) h(53.158) p(2)
*======== p=0 =========*
rdrobust outcome margin, c(0) h(13.290) p(0) 

rdplot outcome margin, c(0) h(13.290) p(0)

*======== p=1 but under-smooth (cut p=1 optimal bandwidth in half) ============*
rdrobust outcome margin, c(0) h(13.290) p(1)

rdplot outcome margin, c(0) h(13.290) p(1)

*\\\\\\\\\\ Local Randomization //////////*

*net install rdlocrand, from(https://raw.githubusercontent.com/rdpackages/rdlocrand/master/stata) replace

* Run rdwinselect to find the largest window (W) that fails to reject balance (p-value > 0.15)

* Run rdwinselect but drop missing covariate observations *
rdwinselect margin ForgnPct GovWkPct BlackPct VtTotPct GovDem, cutoff(0) nwindows(100) dropmissing

*RDD with Randomization*
*Take the last one that passes the test*
rdrandinf outcome margin, cutoff(0) wl(-3.690) wr(3.690)


*Cut the last one that passes in half (Kevin's request)*
rdrandinf outcome margin, cutoff(0) wl(-1.845) wr(1.845)













