CREATE DATABASE IF NOT EXISTS salesDataWalmart;
USE salesDataWalmart;
CREATE TABLE IF NOT EXISTS sales(
		invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
        branch VARCHAR(5) NOT NULL,
        city VARCHAR(30) NOT NULL,
        customer_type VARCHAR(30) NOT NULL,
        gender VARCHAR(10) NOT NULL,
        product_line VARCHAR(100) NOT NULL,
        unit_price DECIMAL(10,2) NOT NULL,
        quantity INT NOT NULL,
        VAT FLOAT(6,4) NOT NULL,
        total DECIMAL(10,2) NOT NULL,
        date DATETIME NOT NULL,
        time TIME NOT NULL,
        payment_method VARCHAR(30) NOT NULL,
        cogs DECIMAL(10,2) NOT NULL,
        gross_margin_percentage FLOAT(11,9) NOT NULL,
        gross_income DECIMAL(10,2) NOT NULL,
        rating FLOAT(2,1) NOT NULL
);

-- --------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------FEATURE ENGINEERING-------------------------------------------------------

-- time of day

SELECT time,
(CASE
	WHEN `time` BETWEEN '00:00:00' AND '12:00:00' THEN "Morning"
    WHEN `time` BETWEEN '12:01:00' AND '16:00:00' THEN "Afternoon"
    ELSE "Evening"
    END) AS time_of_day
FROM sales;

ALTER TABLE sales
ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (CASE
	WHEN `time` BETWEEN '00:00:00' AND '12:00:00' THEN "Morning"
    WHEN `time` BETWEEN '12:01:00' AND '16:00:00' THEN "Afternoon"
    ELSE "Evening"
    END);

-- day_name

SELECT date,
DAYNAME(date) AS day_name
FROM sales;

ALTER TABLE sales
ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- month_name

SELECT date,
MONTHNAME(date)
FROM sales;

ALTER TABLE sales
ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);
-- ------------------------------------------------------------------------------------------------------------------------------------------


-- ------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------GENERIC QUESTIONS------------------------------------------------------

-- 1. How many unique cities does the data have?

SELECT DISTINCT city
FROM sales;

-- 2. In which city is each branch? 

SELECT DISTINCT city, branch
FROM sales;

-- ----------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------PRODUCT--------------------------------------------------------------

-- How many unique product lines does the data have?

SELECT COUNT(DISTINCT product_line) AS product_lines
FROM sales;

-- What is the most common payment method?

SELECT payment_method, COUNT(payment_method) AS cpm
FROM sales
GROUP BY payment_method
ORDER BY cpm DESC
LIMIT 1;

-- What is the most selling product line?

SELECT product_line, COUNT(product_line) AS PL
FROM sales
GROUP BY product_line
ORDER BY PL DESC
LIMIT 1;

-- What is the total revenue by month?

SELECT month_name AS Month, SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- What month had the largest COGS?

SELECT month_name AS Month, SUM(cogs) AS cogs
FROM sales
GROUP BY month_name
ORDER BY cogs DESC
LIMIT 1;

-- What product line had the largest revenue?

SELECT product_line, SUM(total) AS revenue 
FROM sales
GROUP BY product_line
ORDER BY revenue DESC;

-- What is the city with the largest revenue?

SELECT branch, city, SUM(total) AS revenue 
FROM sales
GROUP BY city, branch
ORDER BY revenue DESC;

-- What product line had the largest VAT?

SELECT product_line, AVG(VAT) AS VAT 
FROM sales
GROUP BY product_line
ORDER BY VAT DESC;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

SELECT 
	AVG(quantity) AS avg_qnty
FROM sales;

SELECT
	product_line,
    (CASE
		WHEN AVG(quantity) > 6 THEN "Good"
        ELSE "Bad"
        END) AS remark
FROM sales
GROUP BY product_line;

-- Which branch sold more products than average product sold?

SELECT branch, SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales) ;


-- What is the most common product line by gender?

SELECT gender, product_line, COUNT(product_line) as total_count
FROM sales
GROUP BY gender, product_line
ORDER BY total_count DESC;

-- What is the average rating of each product line?

SELECT product_line, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- -----------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------------------------------------
-- -------------------------- Customers --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday

SELECT time_of_day, COUNT(*) AS sales
FROM sales
WHERE day_name = 'Monday'
GROUP BY time_of_day
ORDER BY sales DESC;

-- Which of the customer types brings the most revenue?

SELECT customer_type, SUM(total) AS revenue 
FROM sales
GROUP BY customer_type
ORDER BY revenue DESC;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?

SELECT city, ROUND(AVG(VAT),2) AS VAT 
FROM sales
GROUP BY city
ORDER BY VAT DESC;

-- Which customer type pays the most in VAT?

SELECT customer_type, ROUND(AVG(VAT),2) AS VAT
FROM sales
GROUP BY customer_type
ORDER BY VAT DESC;

-- -------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------CUSTOMER-----------------------------------------------------------------

-- How many unique customer types does the data have?

SELECT DISTINCT customer_type
FROM sales;

-- How many unique payment methods does the data have?

SELECT DISTINCT payment_method
FROM sales;

-- What is the most common customer type?

SELECT customer_type, COUNT(*) AS cstm_cnt
FROM sales
GROUP BY customer_type
ORDER BY cstm_cnt DESC;

-- Which customer type buys the most?

SELECT customer_type, count(total) AS cstm_buy
FROM sales
GROUP BY customer_type
ORDER BY cstm_buy DESC;

-- What is the gender of most of the customers?

SELECT gender, COUNT(customer_type) AS cstm_gender
FROM sales
GROUP BY gender
ORDER BY cstm_gender DESC;

-- What is the gender distribution per branch?

SELECT branch, gender, COUNT(customer_type) AS cstm_gender
FROM sales
GROUP BY branch, gender;

-- Which time of the day do customers give most ratings?

SELECT time_of_day, COUNT(rating) AS rating_count 
FROM sales
GROUP BY time_of_day
ORDER BY rating_count DESC;

-- Which time of the day do customers give most ratings per branch?

SELECT branch, time_of_day, COUNT(rating) AS rating_count 
FROM sales
WHERE branch = 'B'
GROUP BY time_of_day, branch
ORDER BY rating_count DESC;

-- Which day of the week has the best avg ratings?

SELECT day_name, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings per branch?

SELECT branch, day_name, ROUND(AVG(rating),2) AS avg_rating
FROM sales
WHERE branch = 'A'
GROUP BY day_name, branch
ORDER BY avg_rating DESC;

-- ------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------