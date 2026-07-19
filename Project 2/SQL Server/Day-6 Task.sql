USE Data_Analytics;

-- Q1: Total Suppliers
SELECT COUNT(*) AS Total_Suppliers
FROM dbo.suppliers;


-- Q2: Total Products
SELECT COUNT(*) AS Total_Products
FROM dbo.products;


-- Q3: Total Categories Dealing
SELECT COUNT(DISTINCT category) AS Total_Categories
FROM dbo.products;


-- Q4: Total Sales Value (Last 3 Months)
SELECT SUM(ABS(se.change_quantity) * p.price) AS Total_Sales_Value
FROM dbo.stock_entries se
JOIN dbo.products p
ON se.product_id = p.product_id
WHERE se.change_type = 'Sale';


-- Q5: Total Restock Value (Last 3 Months)
SELECT SUM(p.price * s.quantity_received) AS Total_Restock_Value
FROM dbo.shipments s
JOIN dbo.products p 
ON s.product_id = p.product_id;


-- Q7: Suppliers and Their Contact Details
SELECT supplier_name, contact_name, email, phone, address
FROM dbo.suppliers;


-- Q8: Products with Their Suppliers and Current Stock
SELECT 
    p.product_name,
    p.category,
    p.price,
    p.stock_quantity,
    s.supplier_name
FROM dbo.products p
JOIN dbo.suppliers s
ON p.supplier_id = s.supplier_id;


-- Q9: Products Needing Reorder
SELECT product_name, stock_quantity, reorder_level
FROM dbo.products
WHERE stock_quantity < reorder_level;


-- Q10: Add a New Product
INSERT INTO dbo.products
(product_id, product_name, category, price, stock_quantity, reorder_level, supplier_id)
VALUES(1001, 'Gaming Keyboard', 'Electronics', 2499.00, 50, 20, 1);

SELECT * FROM dbo.products WHERE product_id = 10;

