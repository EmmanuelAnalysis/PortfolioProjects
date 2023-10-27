* Xavier Emmanuel Ithier - Porfolio Website Stata

* Some key commands for Data Analysis 

* Load dataset 
use "portfoliowebsite.dta", clear

* To Explore the data
describe

* To show summary statistics
summarize

* Frequency distribution for a categorical variable
tabulate categorical_variable

* Scatter plot for two continuous variables
scatter variable1 variable2

* Histogram for a continuous variable 
histogram continuous_variable

* Correlation matrix for selected variables 
correlate var1 var2 var3

* Linear regression
regress dependent_var independent_var

* Logistic regression for binary outcome 
logit binary_outcome independent_var

* Export results to a text file
outreg2 using "regression_results.txt", replace

* Generate a variable
gen new_variable = variable1 + variable2

* Save the updated dataset
save "updated_dataset.dta", replace

* Close the dataset
clear



* Below is an example demonstrating how I can employ various commands to present summary statistics.

merge m:1 id using 
keep if _merge == 3
drop _merge
keep if city == 5 & housesize != .
summarize housesize[aweight=wt_final] 
tabulate numberofedu[aweight=wt_final] if age >= 16
keep if pop != .
tabulate yearofstudy[aweight=wt_final] if s01q04a >= 16
generate newvar = 0
replace newvar = 1 if salary == 1 
replace newvar = 1 if income == 1 
tabulate newvar[aweight=wt_final] if age >= 16
clear
