USE AdventureWorks2025;

SELECT name 
FROM sys.tables;

SELECT TOP 5 * FROM Production.Product;
SELECT TOP 5 * FROM Sales.SalesOrderHeader;

---------------------------------------
SELECT 
    p.FirstName + ' ' + p.LastName AS FullName,
    e.EmailAddress,
    ph.PhoneNumber
FROM Person.Person p
LEFT JOIN Person.EmailAddress e
ON p.BusinessEntityID = e.BusinessEntityID
LEFT JOIN Person.PersonPhone ph
ON p.BusinessEntityID = ph.BusinessEntityID;

------------------------------------

SELECT TOP 20
    p.FirstName + ' ' + p.LastName AS FullName,
    e.EmailAddress,
    ph.PhoneNumber,
    a.City,
    sp.Name AS State
FROM Person.Person p

LEFT JOIN Person.EmailAddress e
ON p.BusinessEntityID = e.BusinessEntityID

LEFT JOIN Person.PersonPhone ph
ON p.BusinessEntityID = ph.BusinessEntityID

LEFT JOIN Person.BusinessEntityAddress bea
ON p.BusinessEntityID = bea.BusinessEntityID

LEFT JOIN Person.Address a
ON bea.AddressID = a.AddressID

LEFT JOIN Person.StateProvince sp
ON a.StateProvinceID = sp.StateProvinceID;

------------------------------------------
-- Person.Person
--    ↓
-- BusinessEntityAddress
--    ↓
-- Address
--    ↓
-- StateProvince
--    ↓
-- CountryRegion


SELECT TOP 20
    p.FirstName + ' ' + p.LastName AS FullName,
    e.EmailAddress,
    ph.PhoneNumber,
    a.City,
    sp.Name AS State,
    cr.Name AS Country
FROM Person.Person p

LEFT JOIN Person.EmailAddress e
ON p.BusinessEntityID = e.BusinessEntityID

LEFT JOIN Person.PersonPhone ph
ON p.BusinessEntityID = ph.BusinessEntityID

LEFT JOIN Person.BusinessEntityAddress bea
ON p.BusinessEntityID = bea.BusinessEntityID

LEFT JOIN Person.Address a
ON bea.AddressID = a.AddressID

LEFT JOIN Person.StateProvince sp
ON a.StateProvinceID = sp.StateProvinceID

LEFT JOIN Person.CountryRegion cr
ON sp.CountryRegionCode = cr.CountryRegionCode;
