* ==============================================================================
* MASTER REPLICATION FILE: California Prop 99 Synthetic Control
* ==============================================================================
clear all

* Set the working directory to the location of this master file
* This allows the relative paths to the Scripts and Results folders to work
cd "."

* Run the full research pipeline
do "Scripts/01_setup.do"
do "Scripts/02_synth_models.do"
do "Scripts/03_placebo_tests.do"

display "SUCCESS: All SCM models and placebo figures have been generated."
