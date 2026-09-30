USE olist_project;

-- ==========================================
-- ANALYSIS 1: ORDER STATUS DISTRIBUTION
-- ==========================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- ==========================================
-- ANALYSIS 2: MONTHLY ORDERS
-- ==========================================

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;


-- ==========================================
-- ANALYSIS 3: MONTHLY REVENUE
-- ==========================================

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;


-- ==========================================
-- ANALYSIS 4: AVERAGE ORDER VALUE
-- ==========================================

SELECT
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id;

    -- ==========================================
-- ANALYSIS 5: TOP PRODUCT CATEGORIES BY REVENUE
-- ==========================================

SELECT
    COALESCE(p.product_category_name, 'Unknown') AS product_category,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY COALESCE(p.product_category_name, 'Unknown')
ORDER BY total_revenue DESC
LIMIT 10;


-- ==========================================
-- ANALYSIS 6: TOP PRODUCTS BY ITEMS SOLD
-- ==========================================

SELECT
    oi.product_id,
    COUNT(*) AS total_items_sold
FROM order_items oi
GROUP BY oi.product_id
ORDER BY total_items_sold DESC
LIMIT 10;


-- ==========================================
-- ANALYSIS 7: SELLER PERFORMANCE
-- ==========================================

SELECT
    oi.seller_id,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY total_items_sold DESC
LIMIT 10;


-- ==========================================
-- ANALYSIS 8: PAYMENT METHOD ANALYSIS
-- ==========================================

SELECT
    payment_type,
    COUNT(*) AS total_payments,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- ==========================================
-- ANALYSIS 9: REVIEW SCORE DISTRIBUTION
-- ==========================================

SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score DESC;


-- ==========================================
-- ANALYSIS 10: AVERAGE DELIVERY TIME
-- ==========================================

SELECT
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) AS average_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- ==========================================
-- ANALYSIS 11: DELIVERY PERFORMANCE
-- ==========================================

SELECT
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date
            THEN 'On Time'
        WHEN order_delivered_customer_date > order_estimated_delivery_date
            THEN 'Delayed'
    END AS delivery_status,
    COUNT(*) AS total_orders
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status;


-- ==========================================
-- ANALYSIS 12: AVERAGE FREIGHT COST
-- ==========================================

SELECT
    ROUND(AVG(freight_value), 2) AS average_freight_value
FROM order_items;


-- ==========================================
-- ANALYSIS 13: ORDERS BY CUSTOMER STATE
-- ==========================================

SELECT
    c.customer_state,
    COUNT(*) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;


-- ==========================================
-- ANALYSIS 14: AVERAGE REVIEW SCORE BY PAYMENT TYPE
-- ==========================================

SELECT
    p.payment_type,
    ROUND(AVG(r.review_score), 2) AS average_review_score,
    COUNT(*) AS total_reviews
FROM order_payments p
JOIN order_reviews r
    ON p.order_id = r.order_id
GROUP BY p.payment_type
ORDER BY average_review_score DESC;


-- ==========================================
-- ANALYSIS 15: ORDER VALUE BY PAYMENT TYPE
-- ==========================================

SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    ROUND(AVG(payment_value), 2) AS average_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- ==========================================
-- ANALYSIS 16: AVERAGE ORDER VALUE BY CUSTOMER STATE
-- ==========================================

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY average_order_value DESC;


-- ==========================================
-- ANALYSIS 17: TOP PRODUCT CATEGORIES BY SALES VOLUME
-- ==========================================

SELECT
    COALESCE(p.product_category_name, 'Unknown') AS product_category,
    COUNT(*) AS total_items_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY COALESCE(p.product_category_name, 'Unknown')
ORDER BY total_items_sold DESC
LIMIT 10;


-- ==========================================
-- ANALYSIS 18: REVIEW SCORE VS DELIVERY TIME
-- ==========================================

SELECT
    r.review_score,
    COUNT(*) AS total_reviews,
    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ),
        2
    ) AS average_delivery_days
FROM order_reviews r
JOIN orders o
    ON r.order_id = o.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY r.review_score
ORDER BY r.review_score DESC;


-- ==========================================
-- ANALYSIS 19: TOP SELLERS BY REVENUE
-- ==========================================

SELECT
    oi.seller_id,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    COUNT(*) AS total_items_sold
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;


-- ==========================================
-- ANALYSIS 20: TOP CATEGORIES BY AVERAGE PRICE
-- ==========================================

SELECT
    COALESCE(p.product_category_name, 'Unknown') AS product_category,
    COUNT(*) AS total_items,
    ROUND(AVG(oi.price), 2) AS average_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY COALESCE(p.product_category_name, 'Unknown')
ORDER BY average_price DESC
LIMIT 10;


-- ==========================================
-- ANALYSIS 21: PAYMENT INSTALLMENTS
-- ==========================================

SELECT
    payment_installments,
    COUNT(*) AS total_payment_records,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM order_payments
GROUP BY payment_installments
ORDER BY payment_installments;


-- ==========================================
-- ANALYSIS 22: FREIGHT VS PRODUCT PRICE
-- ==========================================

SELECT
    ROUND(AVG(price), 2) AS average_product_price,
    ROUND(AVG(freight_value), 2) AS average_freight_value,
    ROUND(
        (AVG(freight_value) / AVG(price)) * 100,
        2
    ) AS freight_percentage_of_price
FROM order_items;


-- ==========================================
-- ANALYSIS 23: TOP CATEGORIES BY NUMBER OF ORDERS
-- ==========================================

SELECT
    COALESCE(p.product_category_name, 'Unknown') AS product_category,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY COALESCE(p.product_category_name, 'Unknown')
ORDER BY total_orders DESC
LIMIT 10;


-- ==========================================
-- ANALYSIS 24: ORDERS BY PAYMENT METHOD
-- ==========================================

SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT order_id) * 100.0 /
        (SELECT COUNT(DISTINCT order_id) FROM order_payments),
        2
    ) AS order_percentage
FROM order_payments
GROUP BY payment_type
ORDER BY total_orders DESC;


-- ==========================================
-- ANALYSIS 25: MONTHLY ORDER REVENUE TREND
-- ==========================================

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;


-- ==========================================
-- ANALYSIS 26: OVERALL BUSINESS SUMMARY
-- ==========================================

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT oi.product_id) AS unique_products_sold,
    COUNT(DISTINCT oi.seller_id) AS active_sellers,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS average_item_price,
    ROUND(AVG(oi.freight_value), 2) AS average_freight_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id;