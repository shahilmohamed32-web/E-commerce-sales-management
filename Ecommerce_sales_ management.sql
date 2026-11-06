create database ecommerce_db;
use ecommerce_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50),
    phone VARCHAR(15)
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category_id INT,
    price DECIMAL(10,2),
    stock INT,
    FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),
    amount DECIMAL(10,2),
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);

show tables;

INSERT INTO customers VALUES
(1, 'Arun', 22, 'Male', 'Chennai', '9876543210'),
(2, 'Priya', 25, 'Female', 'Madurai', '9876543211'),
(3, 'Kumar', 30, 'Male', 'Coimbatore', '9876543212'),
(4, 'Divya', 21, 'Female', 'Trichy', '9876543213')

INSERT INTO categories VALUES
(101, 'Electronics'),
(102, 'Clothing'),
(103, 'Footwear'),
(104, 'Home Appliances')

INSERT INTO products VALUES
(201, 'Laptop', 101, 50000, 20),
(202, 'Mobile Phone', 101, 20000, 30),
(203, 'T Shirt', 102, 800, 100),
(204, 'Shoes', 103, 2500, 50)

INSERT INTO orders VALUES
(301, 1, '2026-11-01', 'Delivered'),
(302, 2, '2026-11-02', 'Delivered'),
(303, 3, '2026-11-03', 'Pending'),
(304, 4, '2026-11-04', 'Delivered')

INSERT INTO payments VALUES
(501, 301, 'UPI', 'Success', 50000),
(502, 302, 'Card', 'Success', 1600),
(503, 303, 'UPI', 'Pending', 20000),
(504, 304, 'Cash', 'Success', 5000)


SELECT * FROM customers;
SELECT * FROM categories;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM payments;

inner join customer and order details

SELECT c.customer_name, o.order_id
FROM customers c INNER JOIN orders o
ON c.customer_id = o.customer_id;

left join all customer and order details

SELECT c.customer_name, o.order_id
FROM customers c LEFT JOIN orders o
ON c.customer_id = o.customer_id;

right join all customer and order details

SELECT o.order_id, o.customer_id, c.customer_name
FROM orders o RIGHT JOIN customers c
ON o.customer_id = c.customer_id;

multiple join customer order and payment details

select c.customer_name,o.order_id,o.order_date,o.order_status,p.payment_method,p.payment_status,
p.amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN payments p 
ON o.order_id = p.order_id;

select * from orders;

sum total payment by customer

SELECT c.customer_name,SUM(p.amount) AS total_amount
FROM customers c INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_name;

avg average product price by category

SELECT c.category_name,AVG(p.price) AS average_price
FROM categories c INNER JOIN products p
ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING AVG(p.price) > 3000;

max highest product price by category

SELECT c.category_name, MAX(p.price) AS highest_price
FROM categories c INNER JOIN products p
ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY highest_price DESC;

count total order by customer

SELECT c.customer_name,COUNT(o.order_id) AS total_orders
FROM customers c INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

find products above category average price using join and subquery

SELECT c.category_name,p.product_name,p.price
FROM products p INNER JOIN categories c
ON p.category_id = c.category_id
WHERE p.price > (SELECT AVG(p2.price)
FROM products p2
WHERE p2.category_id = p.category_id
);


























