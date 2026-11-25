create database orders;
use orders;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO customers VALUES
(1, 'Amit Sharma', 'amit@gmail.com', 'Mumbai'),
(2, 'Neha Verma', 'neha@gmail.com', 'Pune'),
(3, 'Rahul Mehta', 'rahul@gmail.com', 'Delhi'),
(4, 'Priya Singh', 'priya@gmail.com', 'Bangalore');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000.00),
(102, 'Mobile Phone', 'Electronics', 25000.00),
(103, 'Headphones', 'Accessories', 3000.00),
(104, 'Office Chair', 'Furniture', 12000.00);

INSERT INTO orders VALUES
(1001, 1, '2025-01-05', 'Delivered'),
(1002, 2, '2025-01-06', 'Pending'),
(1003, 1, '2025-01-08', 'Cancelled'),
(1004, 3, '2025-01-09', 'Delivered');

INSERT INTO order_details VALUES
(1, 1001, 101, 1),
(2, 1001, 103, 2),
(3, 1002, 102, 1),
(4, 1003, 104, 1),
(5, 1004, 101, 1),
(6, 1004, 103, 1);

select * from customers; 
select * from order_details;
select * from orders; 
select * from products; 



-- 1. Find the names of customer’s who have placed at least one order.
select customer_name from customers c 
inner join orders o
on c.customer_id = o.customer_id 
inner join order_details od
on o.order_id = od.order_id ;


-- 2. Find the product name that have been ordered at least once
select product_name from products p
left join order_details od
on p.product_id = od.product_id 
limit 1;

-- 3. Find the order Id where  the product ordered was laptop

select order_id from order_details od
right join products p
on od.product_id = p.product_id
where product_name = "laptop";

-- 4. Find the name of customers who have not placed any order
select* from customers c 
left join orders o
on c.customer_id = o.customer_id
where o.order_id is null;

-- 5. Find the product with the highest price
select* from products p
order by price desc
limit 1;

-- 6. Find the names of product that were never orders.
select product_name from products p 
left join order_details od
on p.product_id =od.product_id
where p.product_id is null;


-- 7. Find product that cost more than the average product price 
select * from products
where price >=(
select avg(price) from products);

-- 8. Find order Id that contain a product price below 5000  
-- joints 
select* from products p 
left join order_details os 
on p.product_id = os.product_id
where price <5000 ;

-- subquery 
select*from  order_details
where product_id =
(select product_id from products 
where price <=5000);

-- 9. List all orders placed after the first order placed in the database
select*from orders 
where order_date>(
select min(order_date) from orders);


-- 10. Find the product with the lowest price
select * from products 
order by price asc
limit 1;

-- subquery
select*from products 
where price =(select min(price) from products);





