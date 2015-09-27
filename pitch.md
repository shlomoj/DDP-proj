Neonatal Sepsis Calculator
========================================================
author: Solomon Javitt
date: 9/2015

What is Neonatal Sepsis?
========================================================
incremental:TRUE

Blood stream infection in neonates (=newborn babies). There are both early forms (start less than 3 days) and late.  Here we will discuss early.

This is a rare but very serious disease that often can lead to death or lifelong disability.

Problem: Diagnosing neonate with sepsis can be tough. The babies when they are born often seem fine.

Doctors have to decide which neonates have a high enough risk of sepsis that it's important enough to take a blood test or even start antibiotics.


What do we know?
========================================================
- We know of some risk factors but no single risk factor makes a very good prediction.
- Humans (including doctors) are very bad at rationally evaluating low-risk events especially with multiple risk-factors
- Researchers at Harvard and Kaiser Permanente came up with a prediction model that uses the risk factors to calculate the overall risk (see [here](http://www.dor.kaiser.org/external/DORExternal/research/infectionprobabilitycalculator.aspx))
- This project is an implementation of the risk model using Shiny in R which provides a more user friendly interface.

Example
========================================================
Input risk factors

```r
ga.w <- 35             ## Gestational Age (weeks)
mat.fev <- 101         ## Highest Maternal Temp in F
GBS.stat <- "Positive" ## GBS Status
abx <- "None"          ## Antibiotic treatment during labor
ROM.Time <- 60         ## Rupture of Membranes time
```

Output

```
[1] "Calculated risk: 0.030 or 30 per 1000 live births"
```

Summary
=================

The Shiny app looks **much** nicer!

Check it out here:  
https://shlomoj.shinyapps.io/DDP-proj
