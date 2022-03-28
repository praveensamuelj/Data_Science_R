
# Telco Churn

## This file contains data from a sample of 7043 subscribers of telephone and/or Internet Services for a large telco. We want to create three separate models to understand the predictors of churn of 
- (i) subscribers of telephone services 
- (ii) subscribers of internet services
- (iii) people who subscribe to both services.


**Variable**|**Effect**|**Rationale**
:-----:|:-----:|:-----:
gender|?|Specific gender cannot influence churn rate, but I want to see if there is any bias.
Senior citizen|-|Senior citizens usually dislike change, thus churn rate should be low.
dependent|-|Usually, dependents also will be in the same plan. Thus, churn rate could be low for moving as a group
tenure|-|Longer the customer is with the telco company, lesser are the chances to move.
MultipleLines|-|Easy for customers to have all lines with one company. Churn rate would be low if he/she has a bunch lo lines to move.
InternetService|-/+|Fiber optic is better alternative when compared to DSL in this high speed era, thus churn for Fiber could be low
OnlineSecurity, OnlineBackup,DeviceProtection, TechSupport, StreamingTV, StreamingMovies|-|Each item of this set is an extra service provided by the company; thus, more are the features less is the churn rate of customers.
Contract|-/+|Longer contracts yield to lesser churn rates as people usually don’t want to break contacts and move. 
PaymentMethod\_auto|-/+|Automatic payment methods, this explains the customer want to have a long tenure with the company, thus low churn rate. 
MonthlyCharges|+|More are the charges more is the chance of customer moving away to cheaper options.
