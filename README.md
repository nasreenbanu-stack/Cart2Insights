# Cart2Insights — E-Commerce Data Analysis

## 📌 Project Overview

Cart2Insights is an end-to-end e-commerce data analysis project focused on understanding orders, customers, products, sellers, payments, reviews, delivery performance, and geographic information.

The project uses **Python and Pandas for data loading, cleaning, validation, feature engineering, and exploratory data analysis**, **MySQL and SQL for relational data analysis**, and **Streamlit for interactive dashboard visualization**.

## 🎯 Project Objectives

* Understand the structure and quality of the datasets
* Identify missing values and duplicate records
* Validate primary and composite keys
* Check relationships between tables
* Clean the datasets while preserving the original raw files
* Load cleaned datasets into MySQL
* Perform feature engineering
* Perform exploratory data analysis
* Perform statistical analysis
* Perform SQL-based business analysis
* Build an interactive Streamlit dashboard
* Generate business insights from the data

## 🗂️ Dataset Tables

The project contains the following tables:

1. `customers`
2. `orders`
3. `products`
4. `sellers`
5. `order_reviews`
6. `order_items`
7. `order_payments`
8. `geolocation`
9. `category_translation`

## 🛠️ Tools & Technologies

* Python
* Pandas
* Jupyter Notebook
* VS Code
* MySQL
* SQL
* Streamlit
* Matplotlib
* SciPy
* Git / GitHub

## 🧹 Data Cleaning & Validation

The datasets were checked for:

* Missing values
* Duplicate records
* Duplicate IDs
* Primary-key uniqueness
* Composite-key uniqueness
* Invalid dates
* Invalid numeric values
* Invalid foreign-key relationships
* Blank and whitespace values
* Data-type consistency

The original raw datasets were preserved, and cleaned copies were created separately.

## 🗄️ MySQL Database

The cleaned datasets were loaded into the MySQL database:

`olist_project`

Important relationships include:

* `orders.customer_id → customers.customer_id`
* `order_items.order_id → orders.order_id`
* `order_items.product_id → products.product_id`
* `order_items.seller_id → sellers.seller_id`
* `order_reviews.order_id → orders.order_id`
* `order_payments.order_id → orders.order_id`

Composite keys were validated for:

* `order_items`
* `order_payments`

## ⚙️ Feature Engineering

Feature engineering was performed using the cleaned datasets.

Important features include:

* `total_order_value`
* `delivery_days`
* `delivery_delay_days`
* `delivery_status`
* `customer_order_count`
* `customer_total_spending`
* `average_order_value`
* `repeat_customer`
* `customer_unique_order_count`
* `seller_order_count`
* `seller_revenue`

The feature-engineered datasets were saved under `data/processed/`.

Orders without matching order-item records resulted in missing `total_order_value`; these values were retained as missing rather than incorrectly replacing them with zero.

## 📊 Exploratory Data Analysis

EDA was performed to understand:

* Order-status distribution
* Monthly order trends
* Monthly sales trends
* Customer repeat behavior
* Customer spending
* Delivery performance
* Delivery delays
* Seller performance
* Customer frequency
* Delivery status by order status

## 📐 Statistical Analysis

Three statistical tests were performed:

### T-Test — Delivery Status vs Review Score

On-time and delayed deliveries were compared using review scores.

* On-time mean review score: **4.29**
* Delayed mean review score: **2.57**
* Welch's t-statistic: **89.55**
* P-value: **< 0.001**

The result provides strong statistical evidence that the mean review scores differed between on-time and delayed deliveries in this dataset. This analysis shows association between the variables and does not establish causation.

### ANOVA — Product Category vs Item Price

Item prices were compared across product categories.

* F-statistic: **192.01**
* P-value: **< 0.001**

The result provides strong statistical evidence that mean item prices differed across product categories.

### Chi-Square — Payment Type vs Order Status

Payment type and order status were analyzed using a chi-square test.

* Chi-square statistic: **939.51**
* Degrees of freedom: **28**
* P-value: **< 0.001**

The result provides strong statistical evidence of an association between payment type and order status.

## 📊 SQL Analysis

The SQL analysis covers:

* Order-status distribution
* Monthly order volume
* Monthly revenue
* Average order value
* Product-category revenue
* Top products by items sold
* Seller performance
* Payment methods
* Review scores
* Average delivery time
* Delivery performance
* Freight costs
* Customer-state order distribution
* Payment installments
* Freight versus product price
* Product-category sales volume
* Review score versus delivery time
* Top sellers by revenue
* Product categories by average price
* Product categories by number of orders
* Overall business metrics

The SQL queries are available in:

`sql/analysis.sql`

## 📈 Key Results

| Metric                            |        Result |
| --------------------------------- | ------------: |
| Orders in orders table            |        99,441 |
| Orders represented in order_items |        98,666 |
| Unique products sold              |        32,951 |
| Sellers represented               |         3,095 |
| Product revenue                   | 13,591,643.70 |
| Average item price                |        120.65 |
| Average freight value             |         19.99 |
| Average delivery time             |    12.50 days |
| Delivered orders                  |        96,478 |
| Delayed orders                    |         7,827 |
| Repeat customer orders            |         6,342 |

## 🔍 Key Observations

### Order Volume

Order volume increased substantially during 2017 and 2018 compared with the early months of the dataset.

### Order Status

`delivered` was the largest order-status category, with **96,478 orders**.

### Delivery

The average delivery time for orders with a recorded customer delivery date was **12.50 days**.

The analysis also identified orders where the actual delivery date was later than the estimated delivery date.

### Customers

The feature-engineering analysis identified **6,342 orders associated with repeat customers**, based on `customer_unique_id`.

### Products & Sellers

The dataset contains **32,951 unique products** and **3,095 sellers** represented in the order-item data.

### Payments

Payment methods, payment values, and installment patterns were analyzed to understand customer payment behavior.

### Reviews

Review scores from 1 to 5 were analyzed along with delivery performance and delivery time to examine customer feedback and delivery experience.

## 💼 Business Insights & Recommendations

### Delivery Performance
**Observation:** Some orders were delivered later than the estimated delivery date.

**Interpretation:** Delivery delays are present in the order data and can affect the overall customer experience.

**Business Impact:** Monitoring delayed orders can help identify delivery-performance issues and areas for operational improvement.

**Recommendation:** Track delayed deliveries regularly and investigate recurring delays by seller, location, and time period.

### Customer Retention
**Observation:** 6,342 orders were associated with repeat customers based on `customer_unique_id`.

**Interpretation:** A portion of customers placed multiple orders during the observed period.

**Business Impact:** Repeat purchasing provides an opportunity to understand and support customer retention.

**Recommendation:** Analyze repeat-customer purchasing patterns and develop suitable retention strategies based on customer behavior.

### Customer Experience
**Observation:** Review scores were analyzed together with delivery performance.

**Interpretation:** The statistical analysis found a significant difference in average review scores between on-time and delayed orders.

**Business Impact:** Delivery performance is an important area to monitor when evaluating customer experience.

**Recommendation:** Monitor delivery delays alongside review scores and use the results to identify opportunities for improving the delivery experience.

## 📊 Streamlit Dashboard

An interactive Streamlit dashboard was developed with the following sections:

* **Overview**
* **Sales**
* **Customers**
* **Delivery**
* **Customer Experience**
* **Sellers**

The dashboard provides interactive views of key e-commerce performance metrics and analysis results.

The application is available in:

`app.py`

## 📁 Project Structure

```text
Cart2Insights/
│
├── data/
│   ├── raw/
│   ├── cleaned/
│   └── processed/
│
├── notebooks/
│   ├── 02_data_cleaning.ipynb
│   ├── 03_feature_engineering.ipynb
│   └── 04_eda.ipynb
│
├── sql/
│   └── analysis.sql
│
├── app.py
├── README.md
└── .gitignore
```

The raw, cleaned, and processed CSV files are kept locally and excluded from Git tracking using `.gitignore`.

## 🚀 Project Workflow

```text
Raw Data
   ↓
Data Understanding
   ↓
Data Quality Checks
   ↓
Data Cleaning & Validation
   ↓
Cleaned CSV Files
   ↓
MySQL Database
   ↓
Relationship Validation
   ↓
Feature Engineering
   ↓
Exploratory Data Analysis
   ↓
Statistical Analysis
   ↓
SQL Business Analysis
   ↓
Streamlit Dashboard
   ↓
Business Insights
```

## 💡 Conclusion

This project demonstrates an end-to-end e-commerce data-analysis workflow, from raw CSV files through data cleaning, validation, MySQL database integration, feature engineering, exploratory and statistical analysis, SQL business analysis, and interactive dashboard development.

It demonstrates practical experience with **Python, Pandas, SQL, MySQL, Streamlit, relational data modeling, data quality validation, feature engineering, exploratory data analysis, statistical testing, and business analysis**.
