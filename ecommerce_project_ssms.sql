IF DB_ID(N'ecommerce_db') IS NULL
BEGIN
    CREATE DATABASE ecommerce_db;
END;
GO
USE ecommerce_db;
GO

DROP TABLE IF EXISTS dbo.payments;
DROP TABLE IF EXISTS dbo.order_items;
DROP TABLE IF EXISTS dbo.orders;
DROP TABLE IF EXISTS dbo.products;
DROP TABLE IF EXISTS dbo.customers;
GO

CREATE TABLE dbo.customers (
    Customer_Id INT NOT NULL PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    RegistrationDate DATE NOT NULL
);
GO

CREATE TABLE dbo.products (
    Product_Id INT NOT NULL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL
);
GO

CREATE TABLE dbo.orders (
    Order_Id INT NOT NULL PRIMARY KEY,
    Customer_Id INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(30) NOT NULL,
    CONSTRAINT FK_orders_customers
        FOREIGN KEY (Customer_Id) REFERENCES dbo.customers(Customer_Id)
);
GO

CREATE TABLE dbo.order_items (
    OrderItem_Id INT NOT NULL PRIMARY KEY,
    Order_Id INT NOT NULL,
    Product_Id INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_order_items_orders
        FOREIGN KEY (Order_Id) REFERENCES dbo.orders(Order_Id),
    CONSTRAINT FK_order_items_products
        FOREIGN KEY (Product_Id) REFERENCES dbo.products(Product_Id)
);
GO

CREATE TABLE dbo.payments (
    Payment_Id INT NOT NULL PRIMARY KEY,
    Order_Id INT NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(30) NOT NULL,
    PaymentStatus VARCHAR(30) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_payments_orders
        FOREIGN KEY (Order_Id) REFERENCES dbo.orders(Order_Id)
);
GO

INSERT INTO dbo.customers
    (Customer_Id, CustomerName, Email, City, RegistrationDate)
VALUES
(1, 'Arun Kumar', 'arun@gmail.com', 'Chennai', '2025-01-10'),
(2, 'Priya Sharma', 'priya@gmail.com', 'Bangalore', '2025-01-15'),
(3, 'Rahul Raj', 'rahul@gmail.com', 'Coimbatore', '2025-02-01'),
(4, 'Sneha Nair', 'sneha@gmail.com', 'Kochi', '2025-02-10'),
(5, 'Vijay Kumar', 'vijay@gmail.com', 'Madurai', '2025-02-15'),
(6, 'Anjali Das', 'anjali@gmail.com', 'Trivandrum', '2025-03-01'),
(7, 'Karthik S', 'karthik@gmail.com', 'Chennai', '2025-03-05'),
(8, 'Meena Joseph', 'meena@gmail.com', 'Salem', '2025-03-10');
GO

INSERT INTO dbo.products
    (Product_Id, ProductName, Category, Price, StockQuantity)
VALUES
(101, 'Laptop', 'Electronics', 45000.00, 10),
(102, 'Smartphone', 'Electronics', 20000.00, 25),
(103, 'Headphones', 'Electronics', 1500.00, 50),
(104, 'Office Chair', 'Furniture', 5500.00, 15),
(105, 'Mouse', 'Accessories', 500.00, 100),
(106, 'Keyboard', 'Accessories', 1200.00, 60),
(107, 'T-Shirt', 'Fashion', 800.00, 75),
(108, 'Shoes', 'Fashion', 2500.00, 30),
(109, 'Water Bottle', 'Lifestyle', 300.00, 80),
(110, 'Backpack', 'Lifestyle', 1200.00, 40);
GO

INSERT INTO dbo.orders
    (Order_Id, Customer_Id, OrderDate, OrderStatus)
VALUES
(1001, 1, '2025-01-05', 'Completed'),
(1002, 2, '2025-01-07', 'Completed'),
(1003, 1, '2025-02-10', 'Completed'),
(1004, 3, '2025-02-15', 'Cancelled'),
(1005, 4, '2025-03-02', 'Completed'),
(1006, 5, '2025-03-05', 'Pending'),
(1007, 2, '2025-03-18', 'Completed'),
(1008, 6, '2025-04-01', 'Completed'),
(1009, 7, '2025-04-12', 'Cancelled'),
(1010, 3, '2025-04-20', 'Completed'),
(1011, 4, '2025-05-03', 'Completed'),
(1012, 1, '2025-05-10', 'Completed');
GO

INSERT INTO dbo.order_items
    (OrderItem_Id, Order_Id, Product_Id, Quantity, UnitPrice)
VALUES
(1, 1001, 101, 1, 45000.00),
(2, 1001, 105, 2, 500.00),
(3, 1002, 102, 1, 20000.00),
(4, 1002, 109, 1, 300.00),
(5, 1003, 103, 2, 1500.00),
(6, 1004, 104, 1, 5500.00),
(7, 1005, 106, 1, 1200.00),
(8, 1005, 110, 2, 1200.00),
(9, 1006, 107, 1, 800.00),
(10, 1007, 101, 1, 45000.00),
(11, 1007, 108, 1, 2500.00),
(12, 1008, 105, 3, 500.00),
(13, 1008, 109, 2, 300.00),
(14, 1009, 102, 1, 20000.00),
(15, 1010, 104, 1, 5500.00),
(16, 1010, 110, 1, 1200.00),
(17, 1011, 103, 1, 1500.00),
(18, 1011, 106, 1, 1200.00),
(19, 1012, 101, 1, 45000.00),
(20, 1012, 107, 2, 800.00);
GO

INSERT INTO dbo.payments
    (Payment_Id, Order_Id, PaymentDate, PaymentMethod, PaymentStatus, Amount)
VALUES
(1, 1001, '2025-01-05', 'UPI', 'Paid', 46000.00),
(2, 1002, '2025-01-07', 'Card', 'Paid', 20300.00),
(3, 1003, '2025-02-10', 'UPI', 'Paid', 3000.00),
(4, 1004, '2025-02-15', 'Card', 'Failed', 5500.00),
(5, 1005, '2025-03-02', 'UPI', 'Paid', 3600.00),
(6, 1006, '2025-03-05', 'COD', 'Pending', 800.00),
(7, 1007, '2025-03-18', 'Card', 'Paid', 47500.00),
(8, 1008, '2025-04-01', 'UPI', 'Paid', 2100.00),
(9, 1009, '2025-04-12', 'COD', 'Failed', 20000.00),
(10, 1010, '2025-04-20', 'Card', 'Paid', 6700.00),
(11, 1011, '2025-05-03', 'UPI', 'Paid', 2700.00),
(12, 1012, '2025-05-10', 'Card', 'Paid', 46600.00);
GO

SELECT 'customers' AS TableName, COUNT(*) AS TotalRecords FROM dbo.customers
UNION ALL
SELECT 'products', COUNT(*) FROM dbo.products
UNION ALL
SELECT 'orders', COUNT(*) FROM dbo.orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM dbo.order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM dbo.payments;
GO
