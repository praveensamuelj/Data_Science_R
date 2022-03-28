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




