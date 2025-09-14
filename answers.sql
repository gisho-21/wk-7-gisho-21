-- =========================================================
-- SQL Assignment: Normalization (1NF and 2NF)
-- =========================================================


-- =========================================================
-- Question 1: Achieving 1NF (First Normal Form) 🛠️
-- =========================================================
-- The table ProductDetail violates 1NF because "Products"
-- contains multiple values in one cell.
-- To achieve 1NF, we split Products into separate rows,
-- ensuring each row has only one product per order.

-- Original Table: ProductDetail
-- OrderID | CustomerName | Products
-- 101     | John Doe     | Laptop, Mouse
-- 102     | Jane Smith   | Tablet, Keyboard, Mouse
-- 103     | Emily Clark  | Phone

-- Step 1: Create normalized ProductDetail_1NF table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Step 2: Insert transformed rows (splitting Products)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- ✅ Now each row represents a single product per order


-- =========================================================
-- Question 2: Achieving 2NF (Second Normal Form) 🧩
-- =========================================================
-- The table OrderDetails (in 1NF) violates 2NF due to 
-- partial dependency: CustomerName depends only on OrderID.
-- To achieve 2NF, we split the table into:
--   (a) Orders table: stores OrderID and CustomerName
--   (b) OrderItems table: stores OrderID, Product, Quantity

-- Original Table: OrderDetails
-- OrderID | CustomerName | Product   | Quantity
-- 101     | John Doe     | Laptop    | 2
-- 101     | John Doe     | Mouse     | 1
-- 102     | Jane Smith   | Tablet    | 3
-- 102     | Jane Smith   | Keyboard  | 1
-- 102     | Jane Smith   | Mouse     | 2
-- 103     | Emily Clark  | Phone     | 1

-- Step 1: Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create OrderItems table
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert data into Orders (removing redundancy)
INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 4: Insert data into OrderItems
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- ✅ Now, CustomerName depends only on OrderID in Orders,
-- and Product/Quantity depend on the composite key in OrderItems.
-- Partial dependency is removed → Table is in 2NF.