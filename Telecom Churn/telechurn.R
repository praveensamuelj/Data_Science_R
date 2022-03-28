rm(list=ls()) 
tchurn=import("TelcoChurn.xlsx")
str(tchurn)

tchurn$gender=as.factor(tchurn$gender)
tchurn$SeniorCitizen =as.factor(tchurn$SeniorCitizen)
tchurn$Dependents =as.factor(tchurn$Dependents)
tchurn$Contract =as.factor(tchurn$Contract)

tchurn$Churn <- ifelse(tchurn$Churn=='Yes', 1, 0)
tchurn$Churn = as.factor(tchurn$Churn)

tchurn$PaymentMethod_auto <- ifelse(tchurn$PaymentMethod=='Bank transfer (automatic)' | tchurn$PaymentMethod=='Credit card (automatic)', 1, 0)
tchurn$PaymentMethod_auto =as.factor(tchurn$PaymentMethod_auto)

attach(tchurn)
Tab1=table(Churn)
Tab1
Tab2=table(Churn,gender)
Tab2


tchurn_tele <- subset(tchurn, tchurn$InternetService == "No")
str(tchurn_tele)
tchurn_tele$MultipleLines =as.factor(tchurn_tele$MultipleLines)

table(tchurn_tele$Churn)

tchurn_inter <- subset(tchurn, tchurn$PhoneService == "No")
str(tchurn_inter)
tchurn_inter$OnlineSecurity =as.factor(tchurn_inter$OnlineSecurity)
tchurn_inter$OnlineBackup =as.factor(tchurn_inter$OnlineBackup)
tchurn_inter$DeviceProtection =as.factor(tchurn_inter$DeviceProtection)
tchurn_inter$TechSupport =as.factor(tchurn_inter$TechSupport)
tchurn_inter$StreamingTV =as.factor(tchurn_inter$StreamingTV)
tchurn_inter$StreamingMovies =as.factor(tchurn_inter$StreamingMovies)

table(tchurn_inter$Churn)

tchurn_both <- subset(tchurn, tchurn$PhoneService == "Yes" & tchurn$InternetService != "No")
str(tchurn_both)
tchurn_both$InternetService =as.factor(tchurn_both$InternetService)
tchurn_both$MultipleLines =as.factor(tchurn_both$MultipleLines)
tchurn_both$OnlineSecurity =as.factor(tchurn_both$OnlineSecurity)
tchurn_both$OnlineBackup =as.factor(tchurn_both$OnlineBackup)
tchurn_both$DeviceProtection =as.factor(tchurn_both$DeviceProtection)
tchurn_both$TechSupport =as.factor(tchurn_both$TechSupport)
tchurn_both$StreamingTV =as.factor(tchurn_both$StreamingTV)
tchurn_both$StreamingMovies =as.factor(tchurn_both$StreamingMovies)

table(tchurn_both$Churn)

# train and test datasets telephone only

set.seed(1024)
trainIndextele <- sample(1:nrow(tchurn_tele), size=round(0.75*nrow(tchurn_tele)), replace=FALSE)
train_tele <- tchurn_tele[trainIndextele,]
test_tele <- tchurn_tele[-trainIndextele,]
dim(train_tele); dim(test_tele)

attach(tchurn_tele)
tele_logit  <- glm(Churn ~ gender + SeniorCitizen + Dependents + tenure + MultipleLines + Contract +  PaymentMethod_auto + MonthlyCharges, family=binomial (link="logit"), data=train_tele)
summary(tele_logit)

attach(tchurn_tele)
test_tele_x <- test_tele[ , c("gender","SeniorCitizen","Dependents","tenure","MultipleLines","Contract","PaymentMethod_auto","MonthlyCharges")]
pred_tele_logit<-predict(tele_logit, newdata=test_tele_x, type="response")
pred_tele_logit <- ifelse(pred_tele_logit>0.25, 1, 0)

table(test_tele$Churn)
table(pred_tele_logit)
table(test_tele$Churn, pred_tele_logit)   # Confusion matrix
ClassificationError_tele <- mean(pred_tele_logit != test_tele$Churn) # Classification error
print(paste("Accuracy_tele = ", 1-ClassificationError_tele))        # Accuraty rate

library(ROCR)
pr_tele <- prediction(pred_tele_logit, test_tele$Churn)
prf_tele <- performance(pr_tele, measure="tpr", x.measure="fpr")
plot(prf_tele)


library(MLmetrics)
recall_tele = Recall(test_tele$Churn, pred_tele_logit, positive = NULL)
print(recall_tele)

precision_tele = Precision(test_tele$Churn, pred_tele_logit, positive = NULL)
print(precision_tele)

f1_tele = F1_Score(pred_tele_logit,test_tele$Churn)
print(f1_tele)

auc_tele = AUC(pred_tele_logit,test_tele$Churn)
print(auc_tele)

# train and test datasets Internet only

set.seed(1024)
trainIndexinter <- sample(1:nrow(tchurn_inter), size=round(0.75*nrow(tchurn_inter)), replace=FALSE)
train_inter <- tchurn_inter[trainIndexinter,]
test_inter <- tchurn_inter[-trainIndexinter,]
dim(train_inter); dim(test_inter)

attach(tchurn_inter)
inter_logit  <- glm(Churn ~ gender + Dependents + tenure + OnlineSecurity + OnlineBackup + DeviceProtection + TechSupport + StreamingTV + StreamingMovies + Contract +  PaymentMethod_auto + MonthlyCharges, family=binomial (link="logit"), data=train_inter)
summary(inter_logit)

attach(tchurn_inter)
test_inter_x <- test_inter[ , c("gender","Dependents","tenure","OnlineSecurity","OnlineBackup","DeviceProtection","TechSupport","StreamingTV","StreamingMovies","Contract","PaymentMethod_auto","MonthlyCharges")]
pred_inter_logit<-predict(inter_logit, newdata=test_inter_x, type="response")
pred_inter_logit <- ifelse(pred_inter_logit>0.5, 1, 0)

table(test_inter$Churn, pred_inter_logit)   # Confusion matrix
ClassificationError_inter <- mean(pred_inter_logit != test_inter$Churn) # Classification error
print(paste("Accuracy_inter = ", 1-ClassificationError_inter))        # Accuraty rate

library(ROCR)
pr_inter <- prediction(pred_inter_logit, test_inter$Churn)
prf_inter <- performance(pr_inter, measure="tpr", x.measure="fpr")
plot(prf_inter)


library(MLmetrics)
recall_inter = Recall(test_inter$Churn, pred_inter_logit, positive = NULL)
print(recall_inter)

precision_inter = Precision(test_inter$Churn, pred_inter_logit, positive = NULL)
print(precision_inter)

f1_inter = F1_Score(pred_inter_logit,test_inter$Churn)
print(f1_inter)

auc_inter = AUC(pred_inter_logit,test_inter$Churn)
print(auc_inter)


# train and test datasets Both internet and telephone only

set.seed(1024)
trainIndexboth <- sample(1:nrow(tchurn_both), size=round(0.75*nrow(tchurn_both)), replace=FALSE)
train_both <- tchurn_both[trainIndexboth,]
test_both <- tchurn_both[-trainIndexboth,]
dim(train_both); dim(test_both)

attach(tchurn_both)
both_logit  <- glm(Churn ~ gender + Dependents + MultipleLines + InternetService + tenure + OnlineSecurity + OnlineBackup + DeviceProtection + TechSupport + StreamingTV + StreamingMovies + Contract +  PaymentMethod_auto + MonthlyCharges, family=binomial (link="logit"), data=train_both)
summary(both_logit)

attach(tchurn_both)
test_both_x <- test_both[ , c("gender","Dependents","MultipleLines","InternetService","tenure","OnlineSecurity","OnlineBackup","DeviceProtection","TechSupport","StreamingTV","StreamingMovies","Contract","PaymentMethod_auto","MonthlyCharges")]
pred_both_logit<-predict(both_logit, newdata=test_both_x, type="response")
pred_both_logit <- ifelse(pred_both_logit>0.5, 1, 0)

table(test_both$Churn, pred_both_logit)   # Confusion matrix
ClassificationError_both <- mean(pred_both_logit != test_both$Churn) # Classification error
print(paste("Accuracy_inter = ", 1-ClassificationError_both))        # Accuraty rate

library(ROCR)
pr_both <- prediction(pred_both_logit, test_both$Churn)
prf_both <- performance(pr_both, measure="tpr", x.measure="fpr")
plot(prf_both)


library(MLmetrics)
recall_both = Recall(test_both$Churn, pred_both_logit, positive = NULL)
print(recall_both)

precision_both = Precision(test_both$Churn, pred_both_logit, positive = NULL)
print(precision_both)

f1_both = F1_Score(pred_both_logit,test_both$Churn)
print(f1_both)

auc_both = AUC(pred_both_logit,test_both$Churn)
print(auc_both)

library(stargazer)
stargazer(tele_logit, inter_logit, both_logit, type="text", single.row=TRUE)





pred_both_logit<-predict(both_logit, newdata=test_both_x, type="response")
pred_both_logit <- ifelse(pred_both_logit>0.5, 1, 0)

pred_both_logit<-predict(both_logit, newdata=test_both_x, type="response")
pred_both_logit <- ifelse(pred_both_logit>0.5, 1, 0)
cm <-confusionMatrix(as.factor(pred_both_logit), reference=test_both$Churn)
cm$byClass['Recall']
cm$byClass['F1']
cm$byClass['Precision']





