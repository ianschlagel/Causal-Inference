* ==============================================================================
* MASTER REPLICATION FILE: Castle Doctrine DiD Analysis
* ==============================================================================
clear all

* Set the working directory to the location of this master file
* This allows the relative paths to the Scripts folder to work correctly
cd "."

* Run the full research pipeline
do "Scripts/01_setup.do"
do "Scripts/02_analysis.do"

display "SUCCESS: All models and figures have been generated."
