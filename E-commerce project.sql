CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(255),
    password VARCHAR(255) NOT NULL
);
CREATE TABLE category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) UNIQUE NOT NULL
);
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id)
        REFERENCES category(category_id)
);
CREATE TABLE cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    cart_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    cart_status VARCHAR(30) DEFAULT 'ACTIVE',
    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
);
CREATE TABLE cart_item (
    cart_id INT,
    product_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id)
        REFERENCES cart(cart_id),
    FOREIGN KEY (product_id)
        REFERENCES product(product_id)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(30) DEFAULT 'PLACED',
    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
);
CREATE TABLE order_item (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES product(product_id)
);
CREATE TABLE payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT UNIQUE NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(30) DEFAULT 'PENDING',
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);
CREATE TABLE delivery (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT UNIQUE NOT NULL,
    tracking_id VARCHAR(100) UNIQUE,
    delivery_address VARCHAR(255) NOT NULL,
    courier_name VARCHAR(100),
    dispatch_date DATETIME,
    delivery_date DATETIME,
    delivery_status VARCHAR(30) DEFAULT 'PROCESSING',
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);
CREATE TABLE review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    comment VARCHAR(500),
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),
    FOREIGN KEY (product_id)
        REFERENCES product(product_id),
    UNIQUE (customer_id, product_id),
    CHECK (rating BETWEEN 1 AND 5)
);
INSERT INTO category (category_name) VALUES
('Electronics'),
('Clothing'),
('Footwear'),
('Books'),
('Home Appliances');
INSERT INTO customer (name, email, phone, address, password) VALUES
('Sathya', 'sathya@gmail.com', '9876543210', 'Eluru, Andhra Pradesh', 'sathya123'),
('Rahul', 'rahul@gmail.com', '9876543211', 'Vijayawada, Andhra Pradesh', 'rahul123'),
('Priya', 'priya@gmail.com', '9876543212', 'Hyderabad, Telangana', 'priya123'),
('Anil', 'anil@gmail.com', '9876543213', 'Guntur, Andhra Pradesh', 'anil123'),
('Sneha', 'sneha@gmail.com', '9876543214', 'Visakhapatnam, Andhra Pradesh', 'sneha123');
INSERT INTO product (product_name, price, stock, category_id) VALUES
('Laptop', 55000.00, 20, 1),
('Smartphone', 25000.00, 30, 1),
('Wireless Headphones', 2500.00, 50, 1),
('T-Shirt', 799.00, 40, 2),
('Jeans', 1499.00, 25, 2),
('Running Shoes', 2999.00, 20, 3),
('Casual Shoes', 1999.00, 30, 3),
('Python Programming Book', 650.00, 15, 4),
('Data Science Book', 850.00, 10, 4),
('Electric Mixer', 3500.00, 12, 5);
INSERT INTO cart (customer_id, cart_status) VALUES
(1, 'ACTIVE'),
(2, 'ACTIVE'),
(3, 'ACTIVE'),
(4, 'ACTIVE'),
(5, 'ACTIVE');
INSERT INTO cart_item (cart_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(2, 5, 1),
(3, 4, 2),
(4, 6, 1),
(4, 8, 1),
(5, 10, 1);
INSERT INTO orders (customer_id, total_amount, order_status) VALUES
(1, 60000.00, 'PLACED'),
(2, 26499.00, 'CONFIRMED'),
(3, 1598.00, 'SHIPPED'),
(4, 3649.00, 'DELIVERED'),
(5, 3500.00, 'DELIVERED');
INSERT INTO order_item (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 55000.00),
(1, 3, 2, 2500.00),
(2, 2, 1, 25000.00),
(2, 5, 1, 1499.00),
(3, 4, 2, 799.00),
(4, 6, 1, 2999.00),
(4, 8, 1, 650.00),
(5, 10, 1, 3500.00);
INSERT INTO payment(order_id, amount, payment_method, payment_status)VALUES
(1, 60000.00, 'UPI', 'PAID'),
(2, 26499.00, 'CARD', 'PAID'),
(3, 1598.00, 'UPI', 'PAID'),
(4, 3649.00, 'CASH', 'PAID'),
(5, 3500.00, 'CARD', 'PAID');
INSERT INTO delivery (order_id, tracking_id, delivery_address, courier_name, dispatch_date, delivery_date, delivery_status)VALUES
(1, 'TRK1001', 'Eluru, Andhra Pradesh', 'Ravi', NOW(), NULL, 'PROCESSING'),
(2, 'TRK1002', 'Vijayawada, Andhra Pradesh', 'Kiran', NOW(), NULL, 'SHIPPED'),
(3, 'TRK1003', 'Hyderabad, Telangana', 'Arun', NOW(), NULL, 'OUT_FOR_DELIVERY'),
(4, 'TRK1004', 'Guntur, Andhra Pradesh', 'Ramesh', NOW(), NOW(), 'DELIVERED'),
(5, 'TRK1005', 'Visakhapatnam, Andhra Pradesh', 'Suresh', NOW(), NOW(), 'DELIVERED');
INSERT INTO review (customer_id, product_id, rating, comment)VALUES
(1, 1, 5, 'Excellent laptop'),
(2, 2, 4, 'Good smartphone'),
(3, 4, 5, 'Very good quality'),
(4, 6, 4, 'Comfortable shoes'),
(5, 10, 5, 'Very useful product');
SELECT * FROM customer;
SELECT * FROM category;
SELECT * FROM product;
SELECT * FROM cart;
SELECT * FROM cart_item;
SELECT * FROM orders;
SELECT * FROM order_item;
SELECT * FROM payment;
SELECT * FROM delivery;
SELECT * FROM review;
INSERT INTO cart_item (cart_id, product_id, quantity)
VALUES (1, 2, 1);
INSERT INTO cart_item (cart_id, product_id, quantity)
VALUES (2, 3, 2);
UPDATE cart_item
SET quantity = 3
WHERE cart_id = 1
AND product_id = 2;
DELETE FROM cart_item
WHERE cart_id = 2
AND product_id = 3;
SELECT
    c.name AS customer_name,
    ca.cart_id,
    p.product_name,
    p.price,
    ci.quantity,
    (p.price * ci.quantity) AS item_total
FROM customer c
JOIN cart ca
ON c.customer_id = ca.customer_id
JOIN cart_item ci
ON ca.cart_id = ci.cart_id
JOIN product p
ON ci.product_id = p.product_id;
SELECT
    p.product_name,
    p.price,
    ci.quantity,
    (p.price * ci.quantity) AS item_total
FROM cart ca
JOIN cart_item ci
ON ca.cart_id = ci.cart_id
JOIN product p
ON ci.product_id = p.product_id
WHERE ca.customer_id = 1;
SELECT
    ca.customer_id,
    SUM(p.price * ci.quantity) AS cart_total
FROM cart ca
JOIN cart_item ci
ON ca.cart_id = ci.cart_id
JOIN product p
ON ci.product_id = p.product_id
WHERE ca.customer_id = 1
GROUP BY ca.customer_id;
INSERT INTO orders(customer_id, total_amount, order_status)VALUES(1, 11000.00, 'PLACED');
UPDATE orders
SET total_amount = 25000.00
WHERE order_id = 6;
UPDATE product
SET stock = stock - 1
WHERE product_id = 2;
UPDATE orders
SET order_status = 'CONFIRMED'
WHERE order_id = 6;
INSERT INTO payment(order_id, amount, payment_method, payment_status)VALUES(6, 25000.00, 'UPI', 'PAID');
INSERT INTO delivery(order_id, tracking_id, delivery_address, courier_name, dispatch_date, delivery_status)VALUES(6, 'TRK1006', 'Eluru, Andhra Pradesh', 'Ravi', NOW(), 'PROCESSING');
UPDATE delivery
SET delivery_status = 'SHIPPED'
WHERE order_id = 6;
UPDATE orders
SET order_status = 'SHIPPED'
WHERE order_id = 6;
UPDATE delivery
SET delivery_status = 'OUT_FOR_DELIVERY'
WHERE order_id = 6;
UPDATE delivery
SET delivery_status = 'DELIVERED',
    delivery_date = NOW()
WHERE order_id = 6;
UPDATE orders
SET order_status = 'DELIVERED'
WHERE order_id = 6;
INSERT INTO review
(customer_id, product_id, rating, comment)
VALUES
(1, 2, 5, 'Excellent product');
SELECT
    p.product_name,
    c.name AS customer_name,
    r.rating,
    r.comment,
    r.review_date
FROM review r
JOIN product p
ON r.product_id = p.product_id
JOIN customer c
ON r.customer_id = c.customer_id;
SELECT
    p.product_name,
    AVG(r.rating) AS average_rating
FROM product p
JOIN review r
ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name;
SELECT
    c.name AS customer_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.order_status
FROM customer c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.customer_id = 1;
SELECT
    c.name AS customer_name,
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.price,
    o.total_amount,
    o.order_status,
    pay.payment_method,
    pay.payment_status,
    d.tracking_id,
    d.delivery_status
FROM customer c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_item oi
ON o.order_id = oi.order_id
JOIN product p
ON oi.product_id = p.product_id
JOIN payment pay
ON o.order_id = pay.order_id
JOIN delivery d
ON o.order_id = d.order_id;
SELECT
    product_id,
    product_name,
    stock
FROM product
WHERE stock < 20;
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM product p
JOIN order_item oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC;
SELECT
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent
FROM customer c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC;
SELECT
    c.category_name,
    SUM(oi.quantity * oi.price) AS category_sales
FROM category c
JOIN product p
ON c.category_id = p.category_id
JOIN order_item oi
ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
ORDER BY category_sales DESC;
CREATE VIEW customer_order_details AS
SELECT
    c.name AS customer_name,
    o.order_id,
    o.order_date,
    p.product_name,
    oi.quantity,
    oi.price,
    o.total_amount,
    o.order_status
FROM customer c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_item oi
ON o.order_id = oi.order_id
JOIN product p
ON oi.product_id = p.product_id;
SELECT *FROM customer_order_details;
START TRANSACTION;
UPDATE product
SET stock = stock - 1
WHERE product_id = 3;
INSERT INTO orders(customer_id, total_amount, order_status)VALUES(2, 2500.00, 'PLACED');
COMMIT;
