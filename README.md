# Walmart-Sales-Data-Analysis
SQL-based sales data analysis for Walmart dataset, including feature engineering and revenue insights.
# 📊 Walmart Sales Data Analysis using SQL  

## 📌 Project Overview  
This project analyzes **Walmart sales data** using **SQL** to extract insights into **customer behavior, revenue trends, and product performance**. It includes **feature engineering, revenue analysis, and business insights** to optimize decision-making.  

## 🚀 Key Features  
✅ **Feature Engineering:** Created new columns (`time_of_day`, `day_name`, `month_name`) for better analysis.  
✅ **Revenue Analysis:** Identified the **highest revenue-generating products and branches**.  
✅ **Customer Insights:** Analyzed **customer type preferences and purchase patterns**.  
✅ **Product Performance:** Determined **top-selling product lines and seasonal trends**.  
✅ **SQL Optimization:** Used **aggregations, indexing, and efficient query structures** for faster results.  

## 🛠️ Technologies Used  
- **SQL (MySQL)** – For querying and analyzing sales data.  
- **Database Management** – Used indexing and feature engineering for performance optimization.  

## 📂 Project Structure  
```
📂 Walmart-Sales-Data-Analysis  
│-- 📜 README.md                 # Project documentation  
│-- 📜 walmart_sales_analysis.sql # SQL queries used for analysis  
```

## 📊 Sample SQL Queries Used  
🔹 **Find the total revenue by month:**  
```sql
SELECT month_name AS Month, SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;
```
🔹 **Identify the most common payment method:**  
```sql
SELECT payment_method, COUNT(payment_method) AS count
FROM sales
GROUP BY payment_method
ORDER BY count DESC
LIMIT 1;
```
🔹 **Determine the best-selling product line:**  
```sql
SELECT product_line, COUNT(*) AS total_sales
FROM sales
GROUP BY product_line
ORDER BY total_sales DESC
LIMIT 1;
```

## 📥 How to Run the Project  
1️⃣ Clone the repository:  
```sh
git clone https://github.com/<your-username>/Walmart-Sales-Data-Analysis.git
```
2️⃣ Import `walmart_sales_analysis.sql` into your MySQL database.  
3️⃣ Run queries in a MySQL environment to analyze the dataset.  

---

## **🔗 Connect with Me**  
👤 **Ayush Pandey**  
📧 **work.ayushpandey@gmail.com**  
🔗 **[LinkedIn Profile](https://linkedin.com/in/ayush-pandey-30462a331)**  

