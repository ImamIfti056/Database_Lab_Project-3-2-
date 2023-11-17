set pagesize 100
set linesize 500

drop table OrderItems;
drop table Products;
drop table Orders;
drop table Customers;

drop sequence seq_cust;
drop sequence seq_product;
drop sequence seq_order;
drop sequence seq_orderItem;

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(50),
    Phone VARCHAR2(20)
);

CREATE SEQUENCE seq_cust
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE TABLE Products (
    ProductID NUMBER PRIMARY KEY,
    Category VARCHAR2(20),
    Title VARCHAR2(50),
    Description VARCHAR2(100),
    Brand VARCHAR(20),
    Price NUMBER,
    Stock NUMBER
);

CREATE SEQUENCE seq_product
MINVALUE 101
START WITH 101
INCREMENT BY 1
CACHE 10;

CREATE TABLE Orders (
    OrderID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    Status VARCHAR2(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE SEQUENCE seq_order
MINVALUE 1001
START WITH 1001
INCREMENT BY 1
CACHE 10;

CREATE TABLE OrderItems (
    OrderItemID NUMBER PRIMARY KEY,
    OrderID NUMBER,
    ProductID NUMBER,
    Quantity NUMBER,
    Subtotal NUMBER,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE SEQUENCE seq_orderItem
MINVALUE 1501
START WITH 1501
INCREMENT BY 1
CACHE 10;

-- Insert sample customers
INSERT INTO Customers (CustomerID, Name, Phone)
VALUES (seq_cust.nextval, 'ABUL', '1234567890');
INSERT INTO Customers (CustomerID, Name, Phone)
VALUES (seq_cust.nextval, 'BABUL', '9876543210');
INSERT INTO Customers (CustomerID, Name, Phone)
VALUES (seq_cust.nextval, 'KABUL', '3456543210');
INSERT INTO Customers (CustomerID, Name, Phone)
VALUES (seq_cust.nextval, 'SHIHABUL', '34353243210');
SELECT * FROM Customers;


-- Insert sample products
INSERT INTO Products (ProductID, Category, Title, Description, Brand, Price, Stock)
VALUES (seq_product.nextval, 'CPU', 'Intel Core i7', 'Quad-core CPU', 'INTEL', 30000, 20);
INSERT INTO Products (ProductID, Category, Title, Description, Brand, Price, Stock)
VALUES (seq_product.nextval, 'CPU', 'Ryzen 5 5600g', 'VEGA 7 GRAPHICS', 'AMD', 12000, 40);
INSERT INTO Products (ProductID, Category, Title, Description, Brand, Price,  Stock)
VALUES (seq_product.nextval, 'MOTHERBOARD', 'ASUS B450 Motherboard', 'ATX motherboard','ASUS', 12000, 30);
INSERT INTO Products (ProductID, Category, Title, Description, Brand, Price,  Stock)
VALUES (seq_product.nextval, 'MOTHERBOARD', 'GIGABYE B660', 'ATX motherboard', 'GIGABYTE', 15500, 20);
INSERT INTO Products (ProductID, Category, Title, Description, Brand, Price,  Stock)
VALUES (seq_product.nextval, 'RAM', 'PNY XLR8 8GB', '3200 MHZ NON-RGB', 'PNY', 2200, 60);
INSERT INTO Products (ProductID, Category, Title, Description, Brand, Price,  Stock)
VALUES (seq_product.nextval, 'RAM', 'CORSAIR VENGENCE 8GB', '3200 MHZ NON-RGB', 'CORSAIR', 2500, 40);
INSERT INTO Products (ProductID, Category, Title, Description, Brand, Price,  Stock)
VALUES (seq_product.nextval, 'SSD', 'HP 250GB', 'EX900 M.2 NVME', 'HP', 2000, 50);
INSERT INTO Products (ProductID, Category, Title, Description, Brand, Price,  Stock)
VALUES (seq_product.nextval, 'SSD', 'SAMSUNG 500GB', 'EVO PLUS', 'SAMSUNG', 8000, 30);

SELECT * FROM Products;


-- Insert sample orders
INSERT INTO Orders (OrderID, CustomerID, Status)
VALUES (seq_order.nextval, 1, 'Shipped');
INSERT INTO Orders (OrderID, CustomerID, Status)
VALUES (seq_order.nextval, 2, 'Processing');

SELECT * FROM Orders;

-- -- Insert sample order items
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal)
VALUES (seq_orderItem.nextval, 1001, 101, 2, 599.98);
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Subtotal)
VALUES (seq_orderItem.nextval, 1001, 102, 1, 129.99);

SELECT * FROM OrderItems;


SELECT O.OrderID, O.Status, P.Title AS ProductName, OI.Quantity, OI.Subtotal
FROM Orders O
JOIN OrderItems OI ON O.OrderID = OI.OrderID
JOIN Products P ON OI.ProductID = P.ProductID
WHERE O.CustomerID = 1;

UPDATE Products
SET Stock = Stock - 2
WHERE ProductID = 101;
