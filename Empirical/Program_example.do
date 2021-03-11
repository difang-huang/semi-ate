
* ===========================
* DATA PROCESSING/DEFINITIONS
* ===========================
cd "/Users/difang/Nutstore Files/Treatment Effects/ATE/Replication Code/Code/"
set scheme plotplain
* ===========================
* TABLE 1 
* ===========================

* (1) Summary Statistics
use http://www.stata-press.com/data/r16/cattaneo2

eststo clear
estpost tabstat bweight mmarried alcohol deadkids mage medu fedu nprenatal monthslb mrace fbaby, by(mbsmoke) statistics(mean sd min max count) columns(statistics) listwise
esttab, cells("mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") noobs nomtitle nonumber label
 
eststo clear 
estpost ttest bweight mmarried alcohol deadkids mage medu fedu nprenatal monthslb mrace fbaby, by(mbsmoke)
esttab, wide nonumber mtitle("diff.") label

* (2) ATE
teffects aipw (bweight mmarried alcohol deadkids mage medu fedu nprenatal monthslb mrace fbaby) (mbsmoke mmarried alcohol deadkids mage medu fedu nprenatal monthslb mrace fbaby, probit)
teffects ipw (bweight) (mbsmoke mmarried alcohol deadkids mage medu fedu nprenatal monthslb mrace fbaby, probit)
teffects ipwra (bweight mmarried alcohol deadkids mage medu fedu nprenatal monthslb mrace fbaby) (mbsmoke mmarried alcohol deadkids mage medu fedu nprenatal monthslb mrace fbaby, probit)
teffects nnmatch (bweight mmarried alcohol deadkids mage medu fedu nprenatal monthslb mrace fbaby) (mbsmoke)
teffects psmatch (bweight) (mbsmoke mmarried alcohol deadkids mage medu fedu nprenatal monthslb mrace fbaby)
teffects ra (bweight mmarried alcohol deadkids mage medu fedu nprenatal monthslb mrace fbaby) (mbsmoke)



* ===========================
* TABLE 2
* ===========================

* (1) Summary Statistics

use nsw_dw.dta, clear

eststo clear
estpost tabstat age education black hispanic married nodegree re74 re75 re78, by(treat) statistics(mean sd min max count) columns(statistics) listwise
esttab, cells("mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") noobs nomtitle nonumber label
 
eststo clear 
estpost ttest age education black hispanic married nodegree re74 re75 re78, by(treat)
esttab, wide nonumber mtitle("diff.") label


use cps_controls.dta, clear

eststo clear
estpost tabstat age education black hispanic married nodegree re74 re75 re78, by(treat) statistics(mean sd min max count) columns(statistics) listwise
esttab, cells("mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") noobs nomtitle nonumber label
 
eststo clear 
estpost ttest age education black hispanic married nodegree re74 re75 re78, by(treat)
esttab, wide nonumber mtitle("diff.") label


use nsw_dw.dta, clear
drop if treat == 0
append using cps_controls.dta

* (2) ATE

teffects aipw (re78 age education black hispanic married nodegree re74 re75 ) (treat age education black hispanic married nodegree re74 re75 , probit)
teffects ipw (re78) (treat age education black hispanic married nodegree re74 re75, probit)
teffects ipwra (re78 age education black hispanic married nodegree re74 re75 ) (treat age education black hispanic married nodegree re74 re75 , probit)
teffects nnmatch (re78 age education black hispanic married nodegree re74 re75 ) (treat)
teffects psmatch (re78) (treat age education black hispanic married nodegree re74 re75)
teffects ra (re78 age education black hispanic married nodegree re74 re75 ) (treat)
 

* (3) BS
use nsw_dw.dta, clear
ttest re78, by(treat) unequal

scalar A=r(mu_1)
scalar B=r(mu_2)

bootstrap (r(mu_1)-r(mu_2)), reps(1000) strata(treat) bca ties nodots: ttest re78, by(treat) unequal

estat bootstrap, all

