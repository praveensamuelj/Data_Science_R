# Multi Level Model - Big Mart Sales

This data contains sales information on different items at multiple outlets of a major retail chain.
Below are the variables and their effect in the target variable

| Variable           | Effect | Rationale                                                                                 |
|--------------------|--------|-------------------------------------------------------------------------------------------|
| Item_Fat_Content   | +/-    | Customers (Health conscious) have specific preferences for (low fat) fat levels products. |
| Item_Visibility    | +      | The more the product is visible, the probability of getting sold is more.                 |
| Item_Type          | +/-    | Few types of products are fast moving when compared to other.                             |
| Item_MRP           | -      | People usually prefer lower prized product within same category.                          |
| Outlet_ID          | ?      | Few Outlets have better sales depending upon its accessibility or some other popularity   |
| Outlet_Year        | +      | Older the outlet more is the regular customer base thus more sales.                       |
| Outlet_type        | +/-    | Bigger the store more are the available products                                          |
| City_Type          | +      | Larger the city more is the population, thus we can expect more sales.                    |
| Excluded Variables |        |                                                                                           |
| Item_ID            | 0      | No effect on sales                                                                        |
| Item_Weight        | 0      | No much effect, depends in type of product and price (1463 missing values)                |
| Outlet_size        | 0      | Already considered in Outlet type variables (2410missing values)                          |

## Excluded Variables
| Variable           | Effect | Rationale                                                                                 |
|--------------------|--------|-------------------------------------------------------------------------------------------|
| Item_ID     | 0 | No effect on sales                                                         |
| Item_Weight | 0 | No much effect, depends in type of product and price (1463 missing values) |
| Outlet_size | 0 | Already considered in Outlet type variables (2410missing values)           |

<img width="300" alt="image" src="https://user-images.githubusercontent.com/97752847/160479772-8ca77879-d9f3-4c03-8213-9df0529a6746.png">

- The dependent variable “Item_sales” is highly skewed, thus will be considering log. 
- We have multi-level data: Item level, Outlet level, and city level.
- I will be adding all the main effects that I have discussed in the predictor table and build multilevel models, Fixed effect, and Random effect.

<img width="549" alt="image" src="https://user-images.githubusercontent.com/97752847/160479887-4fc2e4ee-a90e-4c5f-95d1-8689b8a5dc9d.png">

-	Tier 2 city has slightly higher median sales than Tier3 and Tier 1 has lowest.
-	Supermarket model 3, 1 ,2 and Grocery stores, in this decreasing order the sales vary.
-	Seafood has the highest median sales and baking goods have the lowest median sales in the data

### Models:
## sales.model2= lm(log(Item_Sales) ~Item_Fat_Content+Item_Visibility+Item_Type+Item_MRP+Outlet_Year+Outlet_Type+City_Type+Outlet_ID)
## sales.model3= lmer(log(Item_Sales) ~Item_Fat_Content+Item_Visibility+Item_Type+Item_MRP+Outlet_Year+Outlet_Type+City_Type+(1|Outlet_ID), data=sales_data, REML=FALSE)
### sales.model4= lmer(log(Item_Sales) ~Item_Fat_Content+Item_Visibility+Item_Type+Item_MRP+Outlet_Year+Outlet_Type+(1|City_Type/Outlet_ID), data=sales_data, REML=FALSE)

![image](https://user-images.githubusercontent.com/97752847/160480125-1297ac0c-1ffd-4208-9608-e99bda183e81.jpeg)

- sales.model2 and sales.model3 are 2 level ,fixed and random effects models respectively and sales.model4 is another random effects models with 3 levels explaining all the factors required. I will be considering the random effects sales.model3 with better AIC to provide my interpretations.

## Conclusion:
- Supermarket Type 3 has the best sales compared all other types, with 250% more sales than Grocery store, 57.5% more sales than Supermarket Type 1 and 75.3% more than Supermarket Type2.
- Tier 1 City has better sales than Tier2 and Tier3 cities by 1.6% and 3.3% respectively.
- The top 3 performing stores are OUT35(+0.019%), OUT049 (+0.007%), OUT017 (+0.005%).
The bottom 3 performing stores are OUT045 (-0.025%), OUT046 (-0.011%), OUT010 (-0.003%)
### Some actionable recommendations:
-	Opening a Supermarket Type 3 in a Tier 1 city would be the best decision given a huge increase in overall sales compared to others.
-	Items under Bread, Canned and Meat categories can yield in better sales, so the supermarket can focus on those items.






