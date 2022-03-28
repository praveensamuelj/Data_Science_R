rm(list=ls()) 
sales_data=import("BigMartSales.xlsx")
str(sales_data)

#visulaiztions
par(mfrow=c(1,2)) 
hist(sales_data$Item_Sales,main="Distribution of Sales in the data",xlab="Sales")
hist(log(sales_data$Item_Sales),main="Distribution of Log(Sales)",xlab="Log of Sales")
par(mfrow=c(1,1)) 

par(mfrow=c(3,1)) 
boxplot(sales_data$Item_Sales~sales_data$City_Type)
boxplot(sales_data$Item_Sales~sales_data$Outlet_Type)
boxplot(sales_data$Item_Sales~sales_data$Item_Type)
par(mfrow=c(1,1)) 

#converting into factors
sales_data$Item_Fat_Content=as.factor(sales_data$Item_Fat_Content)
sales_data$Item_Type=as.factor(sales_data$Item_Type)
sales_data$Outlet_Type=as.factor(sales_data$Outlet_Type)
sales_data$City_Type=as.factor(sales_data$City_Type)
sales_data$Outlet_ID=as.factor(sales_data$Outlet_ID)

str(sales_data)

#Models 
attach(sales_data)
sales.model1= lm(log(Item_Sales)~Item_Fat_Content+Item_Visibility+Item_Type+Item_MRP+Outlet_Year+Outlet_Type)
summary(sales.model1)

attach(sales_data)
sales.model2= lm(log(Item_Sales)~Item_Fat_Content+Item_Visibility+Item_Type+Item_MRP+Outlet_Year+Outlet_Type+City_Type+Outlet_ID)
summary(sales.model2)

library(lme4)
attach(sales_data)
sales.model3= lmer(log(Item_Sales) ~Item_Fat_Content+Item_Visibility+Item_Type+Item_MRP+Outlet_Year+Outlet_Type+City_Type+(1|Outlet_ID), data=sales_data, REML=FALSE)
summary(sales.model3)

attach(sales_data)
sales.model4= lmer(log(Item_Sales) ~Item_Fat_Content+Item_Visibility+Item_Type+Item_MRP+Outlet_Year+Outlet_Type+(1|City_Type/Outlet_ID), data=sales_data, REML=FALSE)
summary(sales.model4)

#Analyzing outputs
fixef(sales.model3) 
ranef(sales.model3)  

fixef(sales.model4) 
ranef(sales.model4) 

library(stargazer)
stargazer(sales.model2, sales.model3, sales.model4, type="text", single.row=TRUE)

#Assumption tests.
library(lmtest)
dwtest(sales.model4)   

vif(sales.model3)


sales.model5= lmer(log(Item_Sales) ~Item_Fat_Content+Item_Visibility+Item_Type+Item_MRP+Outlet_Year+Outlet_Type+(1|Outlet_ID)+(1|City_Type), data=sales_data, REML=FALSE)
ranef(sales.model5) 

