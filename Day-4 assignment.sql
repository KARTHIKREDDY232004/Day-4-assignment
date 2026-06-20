CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Quantity INT,
    Order_Date DATE
);

insert into Customers(Customer_ID,Customer_Name,City) values
(1,'John','New York'),
(2,'Alice','Chicago'),
(3,'David','Los Angeles'),
(4,'Sophia','Houston'),
(5,'Emma','Phoenix'
);

insert into Products(Product_ID,Product_Name,Category,Price) values
(101,'Laptop','Electronics',50000),
(102,'Mouse','Electronics',500),
(103,'Keyboard','Electronics',1500),
(104,'Chair','Furniture',4000),
(105,'Desk','Furniture',8000);

insert into Orders(Order_ID,Customer_ID,Product_ID,Quantity,Order_Date) values
(1001,1,101,1,'2025-01-10'),
(1002,2,102,2,'2025-01-12'),
(1003,3,103,1,'2025-01-15'),
(1004,1,104,2,'2025-01-18'),
(1005,4,105,1,'2025-01-20'),
(1006,5,101,1,'2025-01-25'),
(1007,2,104,1,'2025-01-28')

SELECT * FROM Customers;

SELECT *
FROM Customers
WHERE City = 'Chicago';

SELECT *
FROM Products
ORDER BY Price DESC;

SELECT Product_ID,
       SUM(Quantity) AS Total_Quantity
FROM Orders
GROUP BY Product_ID;

SELECT AVG(Price) AS Average_Price
FROM Products;

SELECT c.Customer_Name,
       p.Product_Name,
       o.Quantity
FROM Orders o
INNER JOIN Customers c
ON o.Customer_ID = c.Customer_ID
INNER JOIN Products p
ON o.Product_ID = p.Product_ID;

SELECT c.Customer_Name,
       o.Order_ID
FROM Customers c
LEFT JOIN Orders o
ON c.Customer_ID = o.Customer_ID;

SELECT p.Product_Name,
       SUM(o.Quantity * p.Price) AS Revenue
FROM Orders o
INNER JOIN Products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Revenue DESC;

SELECT Customer_Name
FROM Customers
WHERE Customer_ID IN
(
    SELECT Customer_ID
    FROM Orders
    WHERE Product_ID IN
    (
        SELECT Product_ID
        FROM Products
        WHERE Price >
        (SELECT AVG(Price) FROM Products)
    )
);

CREATE VIEW Sales_Summary AS
SELECT p.Product_Name,
       SUM(o.Quantity * p.Price) AS Revenue
FROM Orders o
JOIN Products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Product_Name;

SELECT * FROM Sales_Summary;

CREATE INDEX idx_customer
ON Orders(Customer_ID);