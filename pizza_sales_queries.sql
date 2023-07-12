USE pizza_sales_db;

SELECT * FROM pizza_sales;

/* The sum of the total price of all pizza orders */
SELECT SUM(total_price) as total_revenue
FROM pizza_sales;

/* The average amount spent per order */
SELECT ROUND(SUM(total_price)/COUNT(DISTINCT order_id), 2) AS average_order_value
FROM pizza_sales;

/* Total pizzas sold for each pizza type and percentage to total sales.*/
SELECT pizza_name_id, SUM(quantity) AS total_quantity, 
	   CONCAT(ROUND(SUM(quantity) / (SELECT SUM(quantity) FROM pizza_sales) * 100, 3), " %") AS percentage_total_sales
FROM pizza_sales
GROUP BY pizza_name_id;

/* The total number of orders placed. */ 
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;

/* The average number of pizzas sold per order */
SELECT COUNT(quantity) / COUNT(DISTINCT order_id) AS average_pizzas_per_order
FROM pizza_sales;

/* Monthly Trend for total_order */
SELECT 
    MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_month,
    COUNT(DISTINCT order_id) AS total_orders,
    CONCAT('$ ', ROUND(SUM(total_price), 3)) AS revenue
FROM pizza_sales
GROUP BY order_month
ORDER BY order_month;

/* Weekly Trend for total orders */
SELECT 
    WEEK(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_week,
    COUNT(DISTINCT order_id) AS total_orders,
    CONCAT('$ ', ROUND(SUM(total_price), 3)) AS revenue
FROM pizza_sales
GROUP BY order_week
ORDER BY order_week;

/* Daily Trend for total orders */
SELECT 
	DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders,
    CONCAT('$ ', ROUND(SUM(total_price), 3)) AS revenue
FROM pizza_sales
GROUP BY order_day;

/* Hourly Trend for total orders */
SELECT 
	SUBSTRING(order_time, 1, 2) AS hour,
	COUNT(DISTINCT order_id) AS total_orders,
    CONCAT('$ ', ROUND(SUM(total_price), 3)) AS revenue
FROM pizza_sales
GROUP BY hour
ORDER BY hour;

/* Percentage of Sales by Pizza Category */
SELECT 
	pizza_category, 
    SUM(quantity) AS total_pizza_sales_category,
    CONCAT(SUM(quantity) / (SELECT SUM(quantity) FROM pizza_sales) * 100, ' %') AS sales_percentage,
    CONCAT(ROUND(SUM(total_price), 3), '%') AS revenue,
    CONCAT(ROUND(SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales) * 100, 3), ' %') AS revenue_percentage
FROM pizza_sales
GROUP BY pizza_category
ORDER BY revenue desc;

/* Percentage of Sales by Pizza size */
SELECT 
	pizza_size, 
    SUM(quantity) AS total_pizza_sales,
    CONCAT(SUM(quantity) / (SELECT SUM(quantity) FROM pizza_sales) * 100, ' %') AS sales_percentage,
    CONCAT(ROUND(SUM(total_price), 3), '%') AS revenue,
    CONCAT(ROUND(SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales) * 100, 3), ' %') AS revenue_percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY revenue desc;

/* Top 5 Best Sellers Total Pizzas Sold */
SELECT
	pizza_name,
    SUM(quantity) AS sales_number
FROM pizza_sales
GROUP BY pizza_name
ORDER BY sales_number desc
LIMIT 5;

/* Top 5 Worst Sellers Total Pizzas Sold */
SELECT
	pizza_name,
    SUM(quantity) AS sales_number
FROM pizza_sales
GROUP BY pizza_name
ORDER BY sales_number asc
LIMIT 5;