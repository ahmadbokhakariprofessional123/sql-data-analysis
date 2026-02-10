-- ======================================
-- SQL Queries for Data Analysis
-- ======================================


-- 1. Retrieve all customers and basic details
SELECT
    customer_id,
    first_name,
    last_name,
    country,
    signup_date
FROM customers;


-- 2. Total number of customers by country
SELECT
    country,
    COUNT(*) AS total_customers
FROM customers
GROUP BY country
ORDER BY total_customers DESC;


-- 3. Total revenue generated from all orders
SELECT
    SUM(total_amount) AS total_revenue
FROM orders;


-- 4. Monthly revenue trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY month
ORDER BY month;


-- 5. Top 5 customers by total spending
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 5;


-- 6. Revenue by product category
SELECT
    p.category,
    SUM(oi.quantity * oi.item_price) AS category_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;


-- 7. Average order value per customer
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    AVG(o.total_amount) AS avg_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY avg_order_value DESC;


-- 8. Number of orders per customer
SELECT
    customer_id,
    COUNT(order_id) AS number_of_orders
FROM orders
GROUP BY customer_id
ORDER BY number_of_orders DESC;


-- 9. Customers with more than 5 orders
SELECT
    customer_id,
    COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 5;


-- 10. Best-selling products by quantity
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;


-- 11. Revenue contribution per product
SELECT
    p.product_name,
    SUM(oi.quantity * oi.item_price) AS product_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY product_revenue DESC;


-- 12. Identify inactive customers (no orders)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
