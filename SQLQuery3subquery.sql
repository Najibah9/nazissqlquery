


USE ProductDB;
GO

SELECT DB_NAME() AS CurrentDatabase;

SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES;

SELECT DB_NAME() AS CurrentDatabase;

SELECT OBJECT_ID('dbo.product') AS ObjectID;

SELECT DB_NAME() AS CurrentDatabase;

SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '%product%';

SELECT OBJECT_ID('product') AS ObjectID;

SELECT OBJECT_ID('dbo.product') AS ObjectID;SELECT OBJECT_ID('dbo.product') AS ObjectID;

USE ProductDB;
GO

CREATE TABLE Product
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    City VARCHAR(50),
    Quantity INT,
    SalesUnit INT
);
GO

SELECT * FROM Product;

INSERT INTO Product VALUES
(1, 'Laptop', 'Mumbai', 20, 50),
(2, 'Smartphone', 'Vadodara', 15, 30),
(3, 'Tablet', 'Ahmedabad', 10, 25),
(4, 'Keyboard', 'Surat', 5, 15),
(5, 'Mouse', 'Pune', 8, 20),
(6, 'Monitor', 'Mumbai', 25, 40),
(7, 'Printer', 'Vadodara', 12, 35),
(8, 'Headphones', 'Ahmedabad', 18, 45),
(9, 'Camera', 'Surat', 0, 60),
(10, 'Speaker', 'Pune', 30, 55);
GO
SELECT * FROM Product;

SELECT *
FROM Product
WHERE Quantity >
(
    SELECT AVG(Quantity)
    FROM Product
);

SELECT ProductName
FROM Product
WHERE City =
(
    SELECT City
    FROM Product
    WHERE ProductName = 'Laptop'
);

SELECT *
FROM Product
WHERE Quantity =
(
    SELECT MAX(Quantity)
    FROM Product
);

SELECT *
FROM Product
WHERE SalesUnit >
(
    SELECT SalesUnit
    FROM Product
    WHERE ProductID = 5
);

SELECT *
FROM Product
WHERE Quantity <
(
    SELECT MIN(Quantity)
    FROM Product
    WHERE City = 'Vadodara'
);

SELECT *
FROM Product
WHERE SalesUnit >
(
    SELECT AVG(SalesUnit)
    FROM Product
    WHERE City = 'Mumbai'
);

SELECT ProductName
FROM Product
WHERE SalesUnit =
(
    SELECT MIN(SalesUnit)
    FROM Product
);

SELECT *
FROM Product
WHERE City IN
(
    SELECT City
    FROM Product
    GROUP BY City
    HAVING SUM(Quantity) > 50
);

SELECT *
FROM Product
WHERE Quantity =
(
    SELECT SalesUnit
    FROM Product
    WHERE ProductName = 'Smartphone'
);

SELECT City
FROM Product
WHERE SalesUnit =
(
    SELECT MAX(SalesUnit)
    FROM Product
);

SELECT *
FROM Product
WHERE City IN
(
    SELECT City
    FROM Product
    WHERE Quantity = 0
);

SELECT *
FROM Product
WHERE SalesUnit > ALL
(
    SELECT SalesUnit
    FROM Product
    WHERE City = 'Surat'
);

SELECT *
FROM Product
WHERE City IN
(
    SELECT City
    FROM Product
    GROUP BY City
    HAVING AVG(SalesUnit) > 10
);

SELECT *
FROM Product
WHERE Quantity > ANY
(
    SELECT Quantity
    FROM Product
    WHERE City = 'Pune'
);

SELECT *
FROM Product
WHERE ProductName IN
(
    SELECT ProductName
    FROM Product
    WHERE City = 'Ahmedabad'
);

SELECT *
FROM Product P1
WHERE Quantity >
(
    SELECT AVG(Quantity)
    FROM Product P2
    WHERE P1.City = P2.City
);

SELECT City
FROM Product
GROUP BY City
HAVING SUM(SalesUnit) >
(
    SELECT SUM(SalesUnit)
    FROM Product
    WHERE City = 'Vadodara'
);

SELECT *
FROM Product
WHERE City =
(
    SELECT TOP 1 City
    FROM Product
    GROUP BY City
    ORDER BY COUNT(ProductID) DESC
);

SELECT MAX(Quantity) AS SecondHighestQuantity
FROM Product
WHERE Quantity <
(
    SELECT MAX(Quantity)
    FROM Product
);

SELECT 
    ProductName,
    Quantity -
    (
        SELECT AVG(Quantity)
        FROM Product
    ) AS Difference
FROM Product;