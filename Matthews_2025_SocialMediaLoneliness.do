**************** DATA PREPARATION ******************

*** Loneliness (age 26)
{
** UCLA Loneliness Scale
tab1 lonely1sm2e lonely2sm2e lonely3sm2e lonely4sm2e
tab1 lonely1sm2e lonely2sm2e lonely3sm2e lonely4sm2e, nol

* Recode to match age 18 E-Risk variable (drop "don't know", and recode valid answers to 0/1/2 instead of 1/2/3)
recode lonely1sm2e lonely2sm2e lonely3sm2e lonely4sm2e lonely5sm2e (-8=.) (1=0) (2=1) (3=2)
tab1 lonely1sm2e lonely2sm2e lonely3sm2e lonely4sm2e, nol
label define lonelcode 0 "Hardly ever" 1 "Some of the time" 2 "Often"
label values lonely1sm2e lonely2sm2e lonely3sm2e lonely4sm2e lonelcode

* Create sum scale of age-26 loneliness
gen lonelye26 = lonely1sm2e + lonely2sm2e + lonely3sm2e + lonely4sm2e
sum lonelye26

* Did COVID make you more lonely?
tab covyoulnlysm2e
tab1 covyoulnlysm2e lockdownsm2, nol

tab covyoulnlysm2e lockdownsm2
replace covyoulnlysm2e = . if lockdownsm2 == 0
tab covyoulnlysm2e
}

*** SM use and experiences (age 26)
{
** Time spent on different types of media
tab1 smediasm2e-totonlinesm2e
tab1 smediasm2e-totonlinesm2e, nol
recode smediasm2e-totonlinesm2e (-8=.)          // Drop "don't know"
tab1 smediasm2e-totonlinesm2e

** Social media platforms used (yes/no)
tab1 smdsite1sm2e-smdsite9sm2e 
tab1 smdsite1sm2e-smdsite9sm2e, nol
recode smdsite1sm2e-smdsite9sm2e (-8=.)          // Drop "don't know"
tab1 smdsite1sm2e-smdsite9sm2e 

** Frequency of use
tab1 smdsite1frsm2e-smdsite9frsm2e
tab1 smdsite1frsm2e-smdsite9frsm2e, nol

recode smdsite1frsm2e-smdsite9frsm2e (-8=.) (-11=.)  // Drop "don't know" + N/A

recode smdsite1frsm2e-smdsite9frsm2e (6=1) (5=2) (4=3) (3=4) (2=5) (1=6) // Reverse code items so higher scores = more time
tab1 smdsite1frsm2e-smdsite9frsm2e, nol
sum smdsite1frsm2e-smdsite9frsm2e
label define frequse 1 "Less often" 2 "Once/twice a month" 3 "Once/twice a week" 4 "Once a day" 5 "Up to 5 times a day" 6 "More than 5 times a day"    // Re-label
label values smdsite1frsm2e-smdsite9frsm2e frequse
tab1 smdsite1frsm2e-smdsite9frsm2e

** Impact of SM on loneliness
tab1 smdconfsm2e-smdbrdsm2e
tab1 smdconfsm2e-smdbrdsm2e, nol
recode smdconfsm2e-smdbrdsm2e (-11=.) (-8=.) (-9=.)   // Drop N/A, refusal and don't know
tab1 smdconfsm2e-smdbrdsm2e
sum smdconfsm2e-smdbrdsm2e

** Quality of use - posting, scrolling, advice etc
tab1 smdpostsm2e smdscrlsm2e smdemospsm2e smdcnvexpsm2e smdadvcsm2e
tab1 smdpostsm2e smdscrlsm2e smdemospsm2e smdcnvexpsm2e smdadvcsm2e, nol
recode smdpostsm2e smdscrlsm2e smdemospsm2e smdcnvexpsm2e smdadvcsm2e (-8=.) (-11=.) // drop "don't know" + N/A
sum smdpostsm2e smdscrlsm2e smdemospsm2e smdcnvexpsm2e smdadvcsm2e

tab1  smdpostsm2e smdscrlsm2e					// Reverse code posting/scrolling items
tab1  smdpostsm2e smdscrlsm2e, nol
recode smdpostsm2e smdscrlsm2e (7=1) (6=2) (5=3) (3=5) (2=6) (1=7)
label define postscroll 1 "Never" 2 "Less often" 3 "Once/twice a month" 4 "Once/twice a week" 5 "Once a day" 6 "Up to 5 times a day" 7 "More than 5 times a day"
label values smdpostsm2e smdscrlsm2e postscroll

** Quality of use - problematic and positive
tab1 smdexp1sm2e smdexp2sm2e smdexp3sm2e smdexp4sm2e smdexp5sm2e smdexp6sm2e smdexp7sm2e smdexp8sm2e smdexp9sm2e smdexp10sm2e
tab1 smdexp1sm2e smdexp2sm2e smdexp3sm2e smdexp4sm2e smdexp5sm2e smdexp6sm2e smdexp7sm2e smdexp8sm2e smdexp9sm2e smdexp10sm2e, nol

recode smdexp1sm2e smdexp2sm2e smdexp3sm2e smdexp4sm2e smdexp5sm2e smdexp6sm2e smdexp7sm2e smdexp8sm2e smdexp9sm2e smdexp10sm2e (-8=.) (-9=.)  // Drop "don't know" + refusal
tab1 smdexp1sm2e
sum smdexp1sm2e smdexp2sm2e smdexp3sm2e smdexp4sm2e smdexp5sm2e smdexp6sm2e smdexp7sm2e smdexp8sm2e smdexp9sm2e smdexp10sm2e

* Problematic tech use sum scale - difficult to stop, short of sleep, neglected obligations, restless/frustrated, avoidance, neglect of social life, other people complained - items 1 thru 7
gen probtech = smdexp1sm2e + smdexp2sm2e + smdexp3sm2e + smdexp4sm2e + smdexp5sm2e + smdexp6sm2e + smdexp7sm2e 
tab probtech

* Positive tech use sum scale - improve physical health, improve mental health, , seek support - items 8 thru 10
gen postech = smdexp8sm2e + smdexp9sm2e + smdexp10sm2e
tab postech

** Online experiences
tab1 onabuoffsm2e onabubthsm2e onabuthrsm2e onabuembsm2e onabuasqsm2e onabushspsm2e onabusdspsm2e
tab1 onabuoffsm2e onabubthsm2e onabuthrsm2e onabuembsm2e onabuasqsm2e onabushspsm2e onabusdspsm2e, nol

recode onabuoffsm2e onabubthsm2e onabuthrsm2e onabuembsm2e onabuasqsm2e onabushspsm2e onabusdspsm2e (-8=.) (-9=.) (-11=.)     // Drop "don't know" + refusal
sum onabuoffsm2e onabubthsm2e onabuthrsm2e onabuembsm2e onabuasqsm2e onabushspsm2e onabusdspsm2e 

* Online victimisation variable
gen cybervic = onabuoffsm2e + onabubthsm2e + onabuthrsm2e + onabuembsm2e + onabuasqsm2e + onabushspsm2e + onabusdspsm2e 
tab cybervic
tab onabuoffsm2e

capture drop countmiss 
capture drop countmod
capture drop countsev

gen countmiss = 0
foreach v of var onabuoffsm2e onabubthsm2e onabuthrsm2e onabuembsm2e onabuasqsm2e onabushspsm2e onabusdspsm2e {
	replace countmiss = countmiss + (missing(`v'))
}

gen countmod = 0
foreach v of var onabuoffsm2e onabubthsm2e onabuthrsm2e onabuembsm2e onabuasqsm2e onabushspsm2e onabusdspsm2e {
	replace countmod = countmod + (`v' == 2)
}

gen countsev = 0
foreach v of var onabuoffsm2e onabubthsm2e onabuthrsm2e onabuembsm2e onabuasqsm2e onabushspsm2e onabusdspsm2e {
	replace countsev = countsev + (`v' == 3)
}

tab1 countmiss countmod countsev

* Any victimisation variable
capture drop anymod
capture drop anysev
capture drop polyvic

recode countmod (2/7=1), gen(anymod)
recode countsev (2/7=1), gen(anysev)
recode countsev (1/2=0) (3/7=1), gen(polyvic)
replace anymod = . if countmiss > 0
replace anysev = . if countmiss > 0
replace polyvic = . if countmiss > 0

tab anymod if anysev == 1
replace anymod = 1 if anysev == 1

tab1 anymod anysev polyvic cybervic
}

** Z score all variables (age 18 & 26)
{
egen z_lonelye26 = std(lonelye26)
egen z_smediasm2e = std(smediasm2e)
egen z_tvwatchsm2e = std(tvwatchsm2e)
egen z_gamingsm2e = std(gamingsm2e)
egen z_infonlinesm2e = std(infonlinesm2e)
egen z_totonlinesm2e = std(totonlinesm2e)
egen z_smdsite3sm2e = std(smdsite3sm2e)
egen z_smdsite5sm2e = std(smdsite5sm2e)
egen z_smdsite2sm2e = std(smdsite2sm2e)
egen z_smdsite6sm2e = std(smdsite6sm2e)
egen z_smdsite4sm2e = std(smdsite4sm2e)
egen z_smdsite1sm2e = std(smdsite1sm2e)
egen z_smdsite8sm2e = std(smdsite8sm2e)
egen z_smdsite9sm2e = std(smdsite9sm2e)
egen z_dxmdee18 = std(dxmdee18)
egen z_dxgade18 = std(dxgade18)
}



****************** METHODS ******************

*** Loneliness SM2
{
// "At the item level, 50-42% of participants reported "never" having any of these feelings (0); 35-40% reported them "sometimes" (1), and 9-13% "often" (2)."

tab1 lonely1sm2e lonely2sm2e lonely3sm2e lonely4sm2e 

// "Items were summed to create a scale from 0-8 (M = 2.43, SD = 2.28; Cronbach α = 0.84)." 
gen lonelye26 = lonely1sm2e + lonely2sm2e + lonely3sm2e + lonely4sm2e
sum lonelye26
alpha lonely1sm2e lonely2sm2e lonely3sm2e lonely4sm2e

*** Loneliness P18

// "At the age-18 assessment, loneliness was assessed using the same four-item short version of the UCLA Loneliness Scale (M = 1.57, SD = 1.94, Cronbach α = 0.83)."
sum lonelye18
}

*** Impact of COVID-19 pandemic (Supp. table 1)
{
// "60.1% of surveys had been completed prior to March 23, 2020, the start date of the UK's first national lockdown in response to the COVID-19 pandemic."

tab lockdownsm2, nol

// Supp. table 1

tab sampsex if lockdownsm2 == 0       // Before pandemic
tab seswq35 if lockdownsm2 == 0

tab sampsex if lockdownsm2 == 1       // After after pandemic		
tab seswq35 if lockdownsm2 == 1

tab sampsex if lockdownsm2 !=.       // Overall
tab seswq35 if lockdownsm2 !=.
}



****************** RESULTS ******************

*** SECTION 1: Do young adults perceive social media as contributing to their feelings of loneliness? 
{
{
// " The vast majority (71.4%) of participants reported that using social media made "no difference" to their feelings of loneliness... "less lonely" (12.8%)... "more lonely" (15.9%)."
 
tab smdlnlysm2e


// "Participants who reported social media made "no difference" to their loneliness at age 26 also had the lowest mean scores of loneliness at age 18 (M = 1.34), compared to those who reported that it made them feel "less lonely" (M = 1.92, p = .001) or "more lonely" (M = 2.48, p < .001)."

tabstat lonelye18, stats(mean sd) by(smdlnlysm2e)
regress lonelye18 b2.smdlnlysm2e sampsex i.seswq35, cluster(familyid)
}
}

*** SECTION 2: Is usage of different digital platforms associated with loneliness? (Table 1, 2, S2)
{
** Media type and loneliness - unadjusted (Table 1, model 1)
{
* Unstandardised coefficients
regress lonelye26 smediasm2e sampsex i.seswq35, cluster(familyid)
regress lonelye26 tvwatchsm2e sampsex i.seswq35, cluster(familyid)
regress lonelye26 gamingsm2e sampsex i.seswq35, cluster(familyid)
regress lonelye26 infonlinesm2e sampsex i.seswq35, cluster(familyid)
regress lonelye26 totonlinesm2e sampsex i.seswq35, cluster(familyid)

* Standardised coefficients 
regress z_lonelye26 z_smediasm2e sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_tvwatchsm2e sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_gamingsm2e sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_infonlinesm2e sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_totonlinesm2e sampsex i.seswq35, cluster(familyid)

* Check for sex differences (reported at end of results)
regress lonelye26 c.smediasm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.tvwatchsm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.gamingsm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.infonlinesm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.totonlinesm2e##i.sampsex i.seswq35, cluster(familyid)

* Check for pre-post pandemic differences (reported at end of results)
regress lonelye26 smediasm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smediasm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 tvwatchsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 tvwatchsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 gamingsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 gamingsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 infonlinesm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid) // sig
regress lonelye26 infonlinesm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid) // NS

regress lonelye26 totonlinesm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 totonlinesm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)
}

** Media type and loneliness - adjusting for age 18 MDD & GAD (Table 1, model 1)
{
* Unstandardised coefficients
regress lonelye26 smediasm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 tvwatchsm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 gamingsm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 infonlinesm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 totonlinesm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)

* Standardised coefficients 
regress z_lonelye26 z_smediasm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_tvwatchsm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_gamingsm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_infonlinesm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_totonlinesm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
}

/// "The association between TV watching and loneliness at age 26 was stronger among people who had been lonelier at age 18 (interaction term B = .06, p < .01). No other moderating effects of age-18 loneliness, depression or anxiety were observed."
{
* Test for moderating effect of age 18 loneliness
regress lonelye26 c.tvwatchsm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.gamingsm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.infonlinesm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.totonlinesm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid)

* Strength of association between loneliness and TV by age 18 loneliness 
regress lonelye26 c.tvwatchsm2e sampsex i.seswq35 if lonelye18 < 4, cluster(familyid)
regress lonelye26 c.tvwatchsm2e sampsex i.seswq35 if lonelye18 >= 4, cluster(familyid)

* Test for moderating effect of depression
regress lonelye26 c.tvwatchsm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.gamingsm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.infonlinesm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.totonlinesm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)

* Test for moderating effect of anxiety
regress lonelye26 c.tvwatchsm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.gamingsm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.infonlinesm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.totonlinesm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid)
}

/// "Individuals with a prior history of depression were more likely to report spending more time and were more likely to look for information online (Supp. Table 2)"
{
* Check variable names
tab smdsite3sm2e 
tab smdsite5sm2e 
tab smdsite2sm2e 
tab smdsite6sm2e 
tab smdsite4sm2e 
tab smdsite1sm2e 
tab smdsite8sm2e 
tab smdsite9sm2e

* Depression - unstandardised coefficients 
regress smediasm2e dxmdee18 sampsex i.seswq35, cluster(familyid)
regress tvwatchsm2e dxmdee18 sampsex i.seswq35, cluster(familyid)
regress gamingsm2e dxmdee18 sampsex i.seswq35, cluster(familyid)
regress infonlinesm2e dxmdee18 sampsex i.seswq35, cluster(familyid)
regress totonlinesm2e dxmdee18 sampsex i.seswq35, cluster(familyid)

regress smdsite3sm2e dxmdee18 sampsex i.seswq35, cluster(familyid)
regress smdsite5sm2e dxmdee18 sampsex i.seswq35, cluster(familyid)
regress smdsite2sm2e dxmdee18 sampsex i.seswq35, cluster(familyid)
regress smdsite6sm2e dxmdee18 sampsex i.seswq35, cluster(familyid)
regress smdsite4sm2e dxmdee18 sampsex i.seswq35, cluster(familyid)
regress smdsite1sm2e dxmdee18 sampsex i.seswq35, cluster(familyid)
regress smdsite8sm2e dxmdee18 sampsex i.seswq35, cluster(familyid)
regress smdsite9sm2e dxmdee18 sampsex i.seswq35, cluster(familyid)

* Depression - standardised coeffiecients 
regress z_smediasm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)
regress z_tvwatchsm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)
regress z_gamingsm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)

regress z_infonlinesm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)
regress z_totonlinesm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite3sm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite5sm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite2sm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite6sm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite4sm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite1sm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite8sm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite9sm2e z_dxmdee18 sampsex i.seswq35, cluster(familyid)

* Anxiety - unstandardised coefficients
regress smediasm2e dxgade18 sampsex i.seswq35, cluster(familyid)
regress tvwatchsm2e dxgade18 sampsex i.seswq35, cluster(familyid)
regress gamingsm2e dxgade18 sampsex i.seswq35, cluster(familyid)
regress infonlinesm2e dxgade18 sampsex i.seswq35, cluster(familyid)
regress totonlinesm2e dxgade18 sampsex i.seswq35, cluster(familyid)
regress smdsite3sm2e dxgade18 sampsex i.seswq35, cluster(familyid)
regress smdsite5sm2e dxgade18 sampsex i.seswq35, cluster(familyid)
regress smdsite2sm2e dxgade18 sampsex i.seswq35, cluster(familyid)
regress smdsite6sm2e dxgade18 sampsex i.seswq35, cluster(familyid)
regress smdsite4sm2e dxgade18 sampsex i.seswq35, cluster(familyid)
regress smdsite1sm2e dxgade18 sampsex i.seswq35, cluster(familyid)
regress smdsite8sm2e dxgade18 sampsex i.seswq35, cluster(familyid)
regress smdsite9sm2e dxgade18 sampsex i.seswq35, cluster(familyid)

tab smdsite2sm2e

* Anxiety - standardised coeffiecients
regress z_smediasm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_tvwatchsm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_gamingsm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_infonlinesm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_totonlinesm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite3sm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite5sm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite2sm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite6sm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite4sm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite1sm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite8sm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_smdsite9sm2e z_dxgade18 sampsex i.seswq35, cluster(familyid)
}

** Specific SM platforms (yes/no) and loneliness - unadjusted (Table 2, Model 1)
{
* % Yes (N)
tab smdsite3sm2e
tab smdsite5sm2e
tab smdsite2sm2e
tab smdsite6sm2e
tab smdsite4sm2e
tab smdsite1sm2e
tab smdsite8sm2e 
tab smdsite9sm2e

* Unstandardised coefficients
regress lonelye26 smdsite3sm2e sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite5sm2e sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite2sm2e sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite6sm2e sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite4sm2e sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite1sm2e sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite8sm2e sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite9sm2e sampsex i.seswq35, cluster(familyid)

* Standardised coefficients
regress z_lonelye26 z_smdsite3sm2e sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite5sm2e sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite2sm2e sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite6sm2e sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite4sm2e sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite1sm2e sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite8sm2e sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite9sm2e sampsex i.seswq35, cluster(familyid)
}

** Specific SM platforms (yes/no) and loneliness - adjusted (Table 2, Model 2)
{
* Unstandardised coefficients
regress lonelye26 smdsite3sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite5sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite2sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite6sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite4sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite1sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite8sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdsite9sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)

* Standardised coefficients
regress z_lonelye26 z_smdsite3sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite5sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite2sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite6sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite4sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite1sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite8sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
regress z_lonelye26 z_smdsite9sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)

* Check for sex differences 
regress lonelye26 i.smdsite1sm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite2sm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite3sm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite4sm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite5sm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite6sm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite8sm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite9sm2e##i.sampsex i.seswq35, cluster(familyid)

* Check before and after covid
regress lonelye26 i.smdsite1sm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite2sm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite3sm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite4sm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite5sm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite6sm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite8sm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite9sm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)

regress lonelye26 smdsite1sm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite1sm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdsite2sm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite2sm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdsite3sm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite3sm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdsite4sm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite4sm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdsite5sm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite5sm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdsite6sm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid) // sig
regress lonelye26 smdsite6sm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid) // NS

regress lonelye26 smdsite7sm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite7sm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdsite8sm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid) // sig 
regress lonelye26 smdsite8sm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid) // NS

regress lonelye26 smdsite9sm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite9sm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)
}

/// Specific SM platforms (yes/no) and loneliness - "These associations were robust to controls for both depression and anxiety. No moderating effects of age-18 loneliness or mental health symptoms were detected."
{
** WhatsApp - adjusting for age 18 depression, anxiety, loneliness + moderating effects
* Adjusting for anxiety only
regress lonelye26 smdsite5sm2e dxgade18 sampsex i.seswq35, cluster(familyid)

* Adjusting for depression only
regress lonelye26 smdsite5sm2e dxmdee18 sampsex i.seswq35, cluster(familyid)

* Adjusting for loneliness only
regress lonelye26 smdsite5sm2e lonelye18 sampsex i.seswq35, cluster(familyid)

* Adjusting for depression + anxiety (Table 2, Model 2)
regress lonelye26 smdsite5sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)

* Adjusting for depression, anxiety + loneliness 
regress lonelye26 smdsite5sm2e dxmdee18 dxgade18 lonelye18 sampsex i.seswq35, cluster(familyid)

* Moderating effects
regress lonelye26 i.smdsite5sm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite5sm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite5sm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid)

** Youtube
* Adjusting for anxiety only
regress lonelye26 smdsite6sm2e dxgade18 sampsex i.seswq35, cluster(familyid)
* Adjusting for depression only
regress lonelye26 smdsite6sm2e dxmdee18 sampsex i.seswq35, cluster(familyid)

* Adjusting for loneliness only
regress lonelye26 smdsite6sm2e lonelye18 sampsex i.seswq35, cluster(familyid)

* Adjusting for depression + anxiety (Table 2, Model 2)
regress lonelye26 smdsite6sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid) 

* Adjusting for depression, anxiety + loneliness 
regress lonelye26 smdsite6sm2e dxmdee18 dxgade18 lonelye18 sampsex i.seswq35, cluster(familyid) 

* Moderating effects
regress lonelye26 i.smdsite6sm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite6sm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite6sm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid)

** Reddit
* Adjusting for anxiety only
regress lonelye26 smdsite8sm2e dxgade18 sampsex i.seswq35, cluster(familyid)

* Adjusting for depression only
regress lonelye26 smdsite8sm2e dxmdee18 sampsex i.seswq35, cluster(familyid)

* Adjusting for loneliness only
regress lonelye26 smdsite8sm2e lonelye18 sampsex i.seswq35, cluster(familyid)

* Adjusting for depression + anxiety (Table 2, Model 2)
regress lonelye26 smdsite8sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid) 

* Adjusting for depression, anxiety + loneliness 
regress lonelye26 smdsite8sm2e dxmdee18 dxgade18 lonelye18 sampsex i.seswq35, cluster(familyid) 

* Moderating effects
regress lonelye26 i.smdsite8sm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite8sm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite8sm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid)

** Dating apps
* Adjusting for anxiety only
regress lonelye26 smdsite9sm2e dxgade18 sampsex i.seswq35, cluster(familyid)

* Adjusting for depression only
regress lonelye26 smdsite9sm2e dxmdee18 sampsex i.seswq35, cluster(familyid)

* Adjusting for loneliness only
regress lonelye26 smdsite9sm2e lonelye18 sampsex i.seswq35, cluster(familyid)

* Adjusting for depression + anxiety (Table 2, Model 2)
regress lonelye26 smdsite9sm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid) 

* Adjusting for depression, anxiety + loneliness 
regress lonelye26 smdsite9sm2e dxmdee18 dxgade18 lonelye18 sampsex i.seswq35, cluster(familyid) 

* Moderating effects
regress lonelye26 i.smdsite9sm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite9sm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.smdsite9sm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid)
}

/// Frequency of usage and loneliness - "with regard to frequency of usage, among the specific 8 types of online platforms that were tested, only YouTube showed an association with loneliness..."
{
regress lonelye26 smdsite1frsm2e sampsex i.seswq35, cluster(familyid) // Twitter
regress lonelye26 smdsite2frsm2e sampsex i.seswq35, cluster(familyid) // Instagram (marg NS)
regress lonelye26 smdsite3frsm2e sampsex i.seswq35, cluster(familyid) // Facebook
regress lonelye26 smdsite4frsm2e sampsex i.seswq35, cluster(familyid) // Snapchat
regress lonelye26 smdsite5frsm2e sampsex i.seswq35, cluster(familyid) // WhatsApp (sig)
regress lonelye26 smdsite6frsm2e sampsex i.seswq35, cluster(familyid) // YouTube (sig)
regress lonelye26 smdsite8frsm2e sampsex i.seswq35, cluster(familyid) // Reddit
regress lonelye26 smdsite9frsm2e sampsex i.seswq35, cluster(familyid) // Dating apps

* Check for sex differences
regress lonelye26 c.smdsite1frsm2e##i.sampsex i.seswq35, cluster(familyid) //sig
regress lonelye26 c.smdsite2frsm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite3frsm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite4frsm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite5frsm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite6frsm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite8frsm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite9frsm2e##i.sampsex i.seswq35, cluster(familyid)

regress lonelye26 c.smdsite1frsm2e i.seswq35 if sampsex == 1, cluster(familyid) // males (sig)
regress lonelye26 c.smdsite1frsm2e i.seswq35 if sampsex == 2, cluster(familyid) // females (NS)

* Compare before and after COVID
regress lonelye26 c.smdsite1frsm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite2frsm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite3frsm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite4frsm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite5frsm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite6frsm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite8frsm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite9frsm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)

regress lonelye26 smdsite1frsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite1frsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdsite2frsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid) // sig 
regress lonelye26 smdsite2frsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid) // NS

regress lonelye26 smdsite3frsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite3frsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdsite4frsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite4frsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdsite5frsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite5frsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdsite6frsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite6frsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdsite8frsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite8frsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdsite9frsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdsite9frsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)


}

/// Frequency of usage and loneliness - "Individuals with a prior history of depression and anxiety at age 18 were also more likely to report spending more time on YouTube (Supplementary Table 2)"

** Frequency of usage and loneliness - adjust for age 18 depression and anxiety
{
// Youtube - "prior internalising problems did not explain the association with loneliness"
regress lonelye26 smdsite6frsm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)

// Whatsapp - "This association also survived controls for depression and anxiety."
regress lonelye26 smdsite5frsm2e dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid)
}

** Frequency of usage and loneliness - moderators "one moderator effect... greater frequency of Instagram use was associated with lower loneliness among participants who met diagnostic criteria for anxiety at age 18"
{
* Youtube
regress lonelye26 c.smdsite6frsm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite6frsm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite6frsm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid)

* WhatsApp
regress lonelye26 c.smdsite5frsm2e##i.dxmdee18  sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite5frsm2e##i.dxgade18  sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite5frsm2e##c.lonelye18  sampsex i.seswq35, cluster(familyid)

* Instagram
regress lonelye26 c.smdsite2frsm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdsite2frsm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid) // sig
regress lonelye26 c.smdsite2frsm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid)

regress lonelye26 smdsite2frsm2e sampsex i.seswq35 if dxgade18 == 0, cluster(familyid)
regress lonelye26 smdsite2frsm2e sampsex i.seswq35 if dxgade18 == 1, cluster(familyid)
}
}

*** SECTION 3: Are online behaviours and experiences associated with loneliness?
{
/// Posting vs. scrolling - "..neither actively posting nor passive scrolling were associated with loneliness"
{
tab1 smdpostsm2e-smdadvcsm2e
tab1 smdpostsm2e smdscrlsm2e 

regress lonelye26 smdpostsm2e sampsex i.seswq35, cluster(familyid)
regress lonelye26 smdscrlsm2e sampsex i.seswq35, cluster(familyid)

* Check for sex differences
regress lonelye26 c.smdpostsm2e##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdscrlsm2e##i.sampsex i.seswq35, cluster(familyid)

* Compare before and after COVID
regress lonelye26 c.smdpostsm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdscrlsm2e##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)

regress lonelye26 smdpostsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdpostsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 smdscrlsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 smdscrlsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)
}

/// Problematic vs. positive use - "... compulsive or problematic technology use was associated with increased loneliness... individuals who reported using social media to improve their mental or physical health reported greater feelings of loneliness"
{
regress lonelye26 probtech sampsex i.seswq35, cluster(familyid)
regress lonelye26 postech sampsex i.seswq35, cluster(familyid)

* Problematic use - adjust for age 18 depression, anxiety, loneliness  
regress lonelye26 probtech dxmdee18 sampsex i.seswq35, cluster(familyid)  // depr only
regress lonelye26 probtech dxgade18 sampsex i.seswq35, cluster(familyid)  // anx only
regress lonelye26 probtech dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid) // depr + anx
regress lonelye26 probtech lonelye18 sampsex i.seswq35, cluster(familyid) // lonel only
regress lonelye26 probtech dxmdee18 dxgade18 lonelye18 sampsex i.seswq35, cluster(familyid) // depression, anxiety, loneliness

* Positive use - adjust for age 18 depression, anxiety, loneliness  
regress lonelye26 postech dxmdee18 sampsex i.seswq35, cluster(familyid) // depr only
regress lonelye26 postech dxgade18 sampsex i.seswq35, cluster(familyid) // anx only
regress lonelye26 postech dxmdee18 dxgade18 sampsex i.seswq35, cluster(familyid) // depr + anx 
regress lonelye26 postech lonelye18 sampsex i.seswq35, cluster(familyid) // lonel only
regress lonelye26 postech dxmdee18 dxgade18 lonelye18 sampsex i.seswq35, cluster(familyid) // depression, anxiety, loneliness 

* Problematic use - moderating effects
regress lonelye26 c.probtech##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.probtech##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.probtech##c.lonelye18 sampsex i.seswq35, cluster(familyid)

* Positive use - moderating effects
regress lonelye26 c.postech##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.postech##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.postech##c.lonelye18 sampsex i.seswq35, cluster(familyid)

* Check for sex differences
regress lonelye26 c.probtech##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.postech##i.sampsex i.seswq35, cluster(familyid)

* Compare before and after COVID
regress lonelye26 c.probtech##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.postech##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)

regress lonelye26 probtech sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 probtech sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 postech sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 postech sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)
}

/// Supportive interactions - "Participants who reported feeling emotionally supported by others online did not deviate from average in their feelings of loneliness"
{
tab1 smdemospsm2e smdcnvexpsm2e smdadvcsm2e

regress lonelye26 smdemospsm2e sampsex i.seswq35, cluster(familyid)  // Emot support (NS)
regress lonelye26 smdcnvexpsm2e sampsex i.seswq35, cluster(familyid) // Conversation (sig)
regress lonelye26 smdadvcsm2e sampsex i.seswq35, cluster(familyid)   // Advice (sig) 

* Moderators - emotionally supported // "among those who met diagnostic criteria for anxiety at age 18, feeling emotionally supported was associated with lower loneliness at age 26 (B = -.51, p < .05)."
regress lonelye26 c.smdemospsm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdemospsm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid) // sig
regress lonelye26 c.smdemospsm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid) // sig

regress lonelye26 c.smdemospsm2e sampsex i.seswq35 if dxgade18==0, cluster(familyid)
regress lonelye26 c.smdemospsm2e sampsex i.seswq35 if dxgade18==1, cluster(familyid)

regress lonelye26 c.smdemospsm2e sampsex i.seswq35 if lonelye18 < 4, cluster(familyid)
regress lonelye26 c.smdemospsm2e sampsex i.seswq35 if lonelye18  >= 4, cluster(familyid)

* Moderators - good conversations
regress lonelye26 c.smdcnvexpsm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdcnvexpsm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdcnvexpsm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid)

* Moderators - receive advice 
regress lonelye26 c.smdadvcsm2e##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdadvcsm2e##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.smdadvcsm2e##c.lonelye18 sampsex i.seswq35, cluster(familyid)
}

/// Victimisation - experienced online victimisation also reported greater loneliness 
{
regress lonelye26 anymod sampsex i.seswq35, cluster(familyid)
regress lonelye26 anysev sampsex i.seswq35, cluster(familyid)
regress lonelye26 polyvic sampsex i.seswq35, cluster(familyid) 

* Check for sex differences
regress lonelye26 i.anymod##i.sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.anysev##i.sampsex i.seswq35, cluster(familyid) // sig
regress lonelye26 i.polyvic##i.sampsex i.seswq35, cluster(familyid)

regress lonelye26 anysev i.seswq35 if sampsex == 1, cluster(familyid)
regress lonelye26 anysev i.seswq35 if sampsex == 2, cluster(familyid)

* Compare before and after COVID
regress lonelye26 i.anymod##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.anysev##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.polyvic##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)
regress lonelye26 c.cybervic##i.lockdownsm2 sampsex i.seswq35, cluster(familyid)

regress lonelye26 anymod sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 anymod sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 anysev sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 anysev sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

regress lonelye26 polyvic sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid)
regress lonelye26 polyvic sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid)

// Adjust for MH and loneliness - "these associations were robust to controls for age-18 loneliness, depression and anxiety
regress lonelye26 anymod dxmdee18 dxgade18 lonelye18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 anysev dxmdee18  dxgade18 lonelye18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 polyvic dxmdee18  dxgade18 lonelye18 sampsex i.seswq35, cluster(familyid)

// Moderators - "no moderating effects of these factors were observed."

* Depression
regress lonelye26 i.anymod##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.anysev##i.dxmdee18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.polyvic##i.dxmdee18 sampsex i.seswq35, cluster(familyid)

* Anxiety
regress lonelye26 i.anymod##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.anysev##i.dxgade18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.polyvic##i.dxgade18 sampsex i.seswq35, cluster(familyid)

* Prior loneliness
regress lonelye26 i.anymod##c.lonelye18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.anysev##c.lonelye18 sampsex i.seswq35, cluster(familyid)
regress lonelye26 i.polyvic##c.lonelye18 sampsex i.seswq35, cluster(familyid)
}
}

*** SECTION 4: Do associations between technology use and loneliness differ by sex? 
{
// Females reported higher mean levels of loneliness than males (t(1,591) = 2.06, p = 0.04)

ttest lonelye26, by(sampsex) // doesn't match 
regress lonelye26 sampsex, cluster(familyid)
regress lonelye26 sampsex i.seswq35, cluster(familyid) // check p value when adjusting for SES

// "When stratifying analyses by sex, an association was observed in males between increased time spent on Twitter and lower feelings of loneliness, whereas no association was observed in females."
regress lonelye26 c.smdsite1frsm2e##i.sampsex i.seswq35, cluster(familyid) //sig

regress lonelye26 c.smdsite1frsm2e i.seswq35 if sampsex == 1, cluster(familyid) // males (sig)
regress lonelye26 c.smdsite1frsm2e i.seswq35 if sampsex == 2, cluster(familyid) // females (NS)

// "...experiencing repeated online victimisation was more strongly associated with loneliness among females than males, though effects were significant for both sexes"
regress lonelye26 i.anysev##i.sampsex i.seswq35, cluster(familyid) // sig

regress lonelye26 anysev i.seswq35 if sampsex == 1, cluster(familyid)  // males
regress lonelye26 anysev i.seswq35 if sampsex == 2, cluster(familyid)  // females
}

*** SECTION 5: Did associations between technology use and loneliness differ during the COVID-19 Pandemic?
{
// Figure 1 - Time spent using digital media before and after the onset of COVID-19 restrictions in the UK. Error bars reflect +/- 1 SD about the mean.
{
tab1 smediasm2e tvwatchsm2e  gamingsm2e  infonlinesm2e totonlinesm2e
tab1 smediasm2e tvwatchsm2e  gamingsm2e  infonlinesm2e totonlinesm2e, nol
tab1 sampsex
tab1 sampsex, nol

bysort lockdownsm2:sum smediasm2e tvwatchsm2e  gamingsm2e  infonlinesm2e totonlinesm2e if sampsex == 2 // females
bysort lockdownsm2:sum smediasm2e tvwatchsm2e  gamingsm2e  infonlinesm2e totonlinesm2e if sampsex == 1 // males
}

// Figure 2 - Frequency of use of social media platforms before and after the onset of COVID-19 restrictions in the UK. Error bars reflect +/- 1 SD about the mean.
{
tab1 smdsite3frsm2e smdsite5frsm2e smdsite2frsm2e smdsite6frsm2e smdsite4frsm2e smdsite1frsm2e smdsite8frsm2e smdsite9frsm2e
tab1 smdsite3frsm2e smdsite5frsm2e smdsite2frsm2e smdsite6frsm2e smdsite4frsm2e smdsite1frsm2e smdsite8frsm2e smdsite9frsm2e, nol

bysort lockdownsm2:sum smdsite3frsm2e smdsite5frsm2e smdsite2frsm2e smdsite6frsm2e smdsite4frsm2e smdsite1frsm2e smdsite8frsm2e smdsite9frsm2e if sampsex == 2 // females
bysort lockdownsm2:sum smdsite3frsm2e smdsite5frsm2e smdsite2frsm2e smdsite6frsm2e smdsite4frsm2e smdsite1frsm2e smdsite8frsm2e smdsite9frsm2e if sampsex == 1 // males
} 

* Loneliness (UCLA) and COVID
{
// Loneliness (UCLA) and COVID - "...mean levels of loneliness did not differ between these groups (before pandemic: M = 2.46, SD = 2.29; during pandemic: M = 2.39, SD = 2.24; p = 0.55)."
ttest lonelye26, by(lockdownsm2)
regress lonelye26 lockdownsm2, cluster(familyid)  

// Loneliness (UCLA) and COVID - "This was the case for both male and female participants, and for low, middle and high SES groups."
regress lonelye26 lockdownsm2 if sampsex == 1, cluster(familyid)
regress lonelye26 lockdownsm2 if sampsex == 2, cluster(familyid)

regress lonelye26 lockdownsm2 if seswq35 == 1, cluster(familyid)
regress lonelye26 lockdownsm2 if seswq35 == 2, cluster(familyid)
regress lonelye26 lockdownsm2 if seswq35 == 3, cluster(familyid)
}

* Self-report change in loneliness COVID 
{
// "When asked directly if they had felt more lonely since the onset of the pandemic, 13.4% of participants responded "yes", 29.2% "somewhat", and 48.7% "no", with the remaining 8.7% responding "not applicable" or "don't know""
tab covyoulnlysm2e
}

// Self-report SM + loneliness and COVID "The proportion of people reporting that social media made them feel lonelier was slightly higher before the pandemic (18.1%), whereas during the pandemic, more people reported that it made them feel less lonely (14.3%)."
{
tab smdlnlysm2e
tab smdlnlysm2e if lockdownsm2 == 0 // before lockdown 
tab smdlnlysm2e if lockdownsm2 == 1 // after lockdown
}

* Types of media/SM before and during COVID 
{ 
// TV, loneliness and COVID - "Time spent watching TV was associated with greater loneliness prior to the pandemic (B = .13, p < .01), but not during it (B = .05, p = .46)." 
regress lonelye26 tvwatchsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid) // sig
regress lonelye26 tvwatchsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid) // NS

// Info seeking, loneliness and COVID - "This was also the case for time spent seeking information online (before pandemic: B = .10, p < .05; during pandemic: B = .08, p = .14). "
regress lonelye26 infonlinesm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid) // sig
regress lonelye26 infonlinesm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid) // NS

// YouTube, loneliness and COVID - "YouTube was also associated with greater loneliness before, but not during, the pandemic (before: B = .43, p = .01; during: B = .05, p = .82), as was use of Reddit (before: B = .92, p < .001; during: B = .44, p = .11). "
tab1 smdsite6sm2e smdsite8sm2e

* Instagram
regress lonelye26 smdsite6sm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid) // sig
regress lonelye26 smdsite6sm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid) // NS

* Reddit 
regress lonelye26 smdsite8sm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid) // sig 
regress lonelye26 smdsite8sm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid) // NS

// Instagram (freq), loneliness and COVID - "increased frequency of Instagram use was associated with lower loneliness before the pandemic (B = -.18, p < .05), but not during it (B = -.03, p = .74)."
regress lonelye26 smdsite2frsm2e sampsex i.seswq35 if lockdownsm2 == 0, cluster(familyid) // sig 
regress lonelye26 smdsite2frsm2e sampsex i.seswq35 if lockdownsm2 == 1, cluster(familyid) // NS
}
}




