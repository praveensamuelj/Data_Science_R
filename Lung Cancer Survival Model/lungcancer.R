rm(list=ls()) 
library(rio)
library(moments)

lcan=import("LungCancer.xlsx")
colnames(lcan)=tolower(make.names(colnames(lcan)))
colnames(lcan)
str(lcan)

lcan$prior.chemotherapy <- ifelse(lcan$prior.chemotherapy==10, 1, 0)
lcan$treatment=as.factor(lcan$treatment)
lcan$cell.type=as.factor(lcan$cell.type)
lcan$prior.chemotherapy=as.factor(lcan$prior.chemotherapy)
str(lcan)


# Status 1=dead, 0=censored 
Tab1=table(treatment, status)
colnames(Tab1) = c("Alive During observation period", "Dead")
rownames(Tab1) = c("Standard chemotherapy tratment", "Chemotherapy combined with test drug")
Tab1

library(survival)

attach(lcan)
y <- Surv(survival.days, status) 

lcan.model1 <- survfit(y ~ 1)      
summary(lcan.model1)
plot(lcan.model1, xlab="Survival days", ylab="Survival Probability")

attach(lcan)
lcan.model2 <- survfit(y ~ treatment)
summary(lcan.model2)
ggsurvplot(lcan.model2, data = lcan, legend.title = "Treatment",
           legend.labs = c("Standard chemotherapy treatment", "Chemotherapy combined with test drug"),xlab="Survival days", ylab="Survival Probability")


# Cox proportional hazard model - coefficients and hazard rates
attach(lcan)
lcan.cox <- coxph(y ~ treatment + cell.type + months.from.diagnosis + age + prior.chemotherapy)
summary(lcan.cox)

# Exponential, Weibull, and log-logistic parametric model coefficients
attach(lcan)
lcan.exp <- survreg(y ~ treatment + cell.type + months.from.diagnosis + age + prior.chemotherapy, dist="exponential")
summary(lcan.exp)

attach(lcan)
lcan.weibull <- survreg(y ~ treatment + cell.type + months.from.diagnosis + age + prior.chemotherapy, dist="weibull")
summary(lcan.weibull)

attach(lcan)
lcan.loglogistic <- survreg(y ~ treatment + cell.type + months.from.diagnosis + age + prior.chemotherapy, dist="loglogistic")
summary(lcan.loglogistic)


library(stargazer)
stargazer(lcan.cox, lcan.exp, lcan.weibull, type="text", single.row=TRUE)

lcan.cox2 <- coxph(y ~ treatment + cell.type + months.from.diagnosis + age + treatment*age + treatment*months.from.diagnosis + prior.chemotherapy)
summary(lcan.cox2 )




# Cox proportional hazard model - coefficients and hazard rates
attach(lcan)
lcan.cox2 <- coxph(y ~ treatment + cell.type + months.from.diagnosis + age + treatment*age + treatment*months.from.diagnosis + prior.chemotherapy)
summary(lcan.cox2)

# Exponential, Weibull, and log-logistic parametric model coefficients
attach(lcan)
lcan.exp2 <- survreg(y ~ treatment + cell.type + months.from.diagnosis + age + treatment*age + treatment*months.from.diagnosis + prior.chemotherapy, dist="exponential")
summary(lcan.exp2)

attach(lcan)
lcan.weibull2 <- survreg(y ~ treatment + cell.type + months.from.diagnosis + age + treatment*age + treatment*months.from.diagnosis + prior.chemotherapy, dist="weibull")
summary(lcan.weibull2)

attach(lcan)
lcan.loglogistic2 <- survreg(y ~ treatment + cell.type + months.from.diagnosis + age + treatment*age + treatment*months.from.diagnosis + prior.chemotherapy, dist="loglogistic")
summary(lcan.loglogistic)


library(stargazer)
stargazer(lcan.cox2, lcan.exp2, lcan.weibull2, type="text", single.row=TRUE)

