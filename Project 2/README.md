# 📊 Sales Analysis Project – AdventureWorks2025
<img src="assets/SQL.jpg" width="" height="">
## 📌 Project Overview

This project performs an end-to-end Sales Data Analysis using the AdventureWorks2025 database.

The objective is to analyze business performance, identify revenue drivers, evaluate customer behavior, and generate actionable business insights using:

- SQL Server (Data Extraction & Aggregation)
- Python (Data Analysis & Visualization)

---

## 🛠️ Tools & Technologies

- SQL Server 2022
- SQL (JOIN, GROUP BY, Aggregations, Window Functions)
- Python
- Pandas
- Matplotlib

---

## 📂 Database Used

- AdventureWorks2025
- Schemas Used:
  - Sales
  - Production
  - Person

---

# 📈 Analysis Tasks Performed

---

## 1️⃣ Category Contribution Analysis

**Business Question:**  
Which product categories generate the most revenue?

**SQL Approach:**
- JOIN SalesOrderDetail → Product → ProductSubcategory → ProductCategory
- GROUP BY Category
- SUM(LineTotal)

**Insight:**  
Revenue is highly concentrated in major product categories (e.g., Bikes dominate overall sales).

---

## 2️⃣ Best Selling Product per Category

**Business Question:**  
Which product drives maximum revenue in each category?

**SQL Approach:**
- GROUP BY Product
- Used ROW_NUMBER() with PARTITION BY Category

**Insight:**  
Each category has a clear top-performing product contributing majority revenue.

---

## 3️⃣ Monthly Sales Trend

**Business Question:**  
How are sales changing over time?

**SQL Approach:**
- Extract YEAR and MONTH from OrderDate
- SUM(TotalDue)

**Python:**
- Created Date column
- Generated Line Chart

**Insight:**  
Sales show trend behavior with seasonal variations and growth patterns.

---

## 4️⃣ Year-over-Year Growth

**Business Question:**  
Is the business growing year by year?

**SQL:**
- GROUP BY Year
- SUM(TotalDue)

**Python:**
```python
df['YoY_%'] = df['TotalSales'].pct_change() * 100
```

**Insight:**  
Business shows measurable annual growth with positive performance trends.

---

## 5️⃣ Top 10 Customers

**Business Question:**  
Who are the most valuable customers?

**SQL:**
- GROUP BY CustomerID
- ORDER BY TotalSales DESC
- TOP 10

**Insight:**  
Revenue is concentrated among high-value customers.

---

## 6️⃣ Customer Segmentation

**Business Question:**  
How to classify customers based on spending?

**Python:**
```python
df['Segment'] = pd.qcut(df['TotalSales'], q=3, labels=['Low','Medium','High'])
```

**Insight:**  
Customers segmented into Low, Medium, and High spenders for targeted strategy.

---

## 7️⃣ Sales by Territory

**Business Question:**  
Which regions perform best?

**SQL:**
- JOIN SalesOrderHeader → SalesTerritory
- GROUP BY Territory

**Insight:**  
Certain territories significantly outperform others.

---

## 8️⃣ Average Order Value (AOV)

**Formula:**
AOV = Total Revenue / Total Orders

**Insight:**  
Provides understanding of average transaction size and revenue efficiency.

---

## 9️⃣ Product Performance Analysis

**Business Question:**  
Which products are underperforming?

**SQL:**
- Total sales per product
- Identified Bottom 10 products

**Insight:**  
Low-performing products may require discounting, bundling, or discontinuation.

---

## 🔟 Pareto Analysis (80/20 Rule)

**Business Question:**  
Do 20% of products generate 80% of revenue?

**Python:**
```python
df['CumSales%'] = df['Sales'].cumsum() / df['Sales'].sum() * 100
```

**Insight:**  
Revenue concentration observed in a small percentage of products.

---

# 📊 Key Business Insights

- Revenue is heavily driven by specific categories and flagship products.
- Customer spending distribution is uneven.
- Regional performance varies significantly.
- A small percentage of products contribute majority of revenue.
- Business shows positive growth trend over time.

---

# 📌 Project Workflow

1. Data Extraction using SQL Server
2. Data Export to CSV
3. Data Analysis using Pandas
4. Visualization using Matplotlib
5. Business Insight Generation

---

# 🚀 Learning Outcomes

- Advanced SQL JOIN & Aggregation
- Window Functions
- Business KPI Analysis
- Time Series Trend Analysis
- Customer Segmentation
- Pareto Principle Application

---

# 👨‍💻 Author

**Ashwin Ashok Yadav**  
Integrated M.Sc. IT – Data Management, Analytics & Visual Insight

---
