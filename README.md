# Cart2Insights — E-Commerce Data Analysis

## 📌 Project Overview

Cart2Insights is an e-commerce data analysis project focused on understanding orders, customers, products, sellers, payments, reviews, delivery performance, and geographic information.

The project uses **Python for data cleaning and validation** and **MySQL for relational data analysis and business insights**.

## 🎯 Project Objectives

* Understand the structure and quality of the datasets
* Identify missing values and duplicate records
* Validate primary and composite keys
* Check relationships between tables
* Clean the datasets while preserving the original raw files
* Load cleaned datasets into MySQL
* Perform SQL-based business analysis
* Generate business insights from the data

## 🗂️ Dataset Tables

The project contains:

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

The cleaned datasets were loaded into:

`olist_project`

Important relationships include:

* `orders.customer_id → customers.customer_id`
* `order_items.order_id → orders.order_id`
* `order_items.product_id → products.product_id`
* `order_items.seller_id → sellers.seller_id`
* `order_reviews.order_id → orders.order_id`
* `order_payments.order_id → orders.order_id`

Composite keys were used for:

* `order_items`
* `order_payments`

## 📊 SQL Analysis

The project analyzes:

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
* Seller revenue
* Overall business metrics

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

## 🔍 Key Observations

### Order Volume

Order volume increased substantially during 2017 and 2018 compared with the early months of the dataset.

### Order Status

`delivered` was the largest order-status category, with **96,478 orders**.

### Delivery

The average delivery time for orders with a recorded customer delivery date was **12.50 days**.

The data also contains orders where the actual delivery date was later than the estimated delivery date.

### Products & Sellers

The dataset contains **32,951 unique products** and **3,095 sellers** represented in the order-item data.

### Payments

Payment methods, payment values, and installment patterns were analyzed to understand customer payment behavior.

### Reviews

Review scores from 1 to 5 were analyzed along with delivery time to examine customer feedback and delivery experience.

## 📁 Project Structure

```text
Cart2Insights/
│
├── data/
│   ├── raw/
│   └── cleaned/
│
├── notebooks/
│   └── 02_data_cleaning.ipynb
│
├── sql/
│   └── analysis.sql
│
└── README.md
```

## 🚀 Project Workflow

```text
Raw Data
   ↓
Data Understanding
   ↓
Data Quality Checks
   ↓
Data Cleaning
   ↓
Cleaned CSV Files
   ↓
MySQL Database
   ↓
Relationship Validation
   ↓
SQL Analysis
   ↓
Business Insights
```

## 💡 Conclusion

This project demonstrates an end-to-end e-commerce data-analysis workflow, from raw CSV files through data cleaning, validation, MySQL database creation, SQL analysis, and business insights.

It demonstrates practical experience with **Python, Pandas, SQL, MySQL, relational data modeling, data quality validation, and business analysis**.
