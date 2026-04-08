-- 1. إنشاء قاعدة البيانات الجديدة
CREATE DATABASE SalesDashboardDB;
GO

-- 2. الانتقال للعمل داخل القاعدة الجديدة
USE SalesDashboardDB;
GO

-- 3. إنشاء الـ View التي تجمع البيانات من AdventureWorks2025
CREATE VIEW v_MainSalesDashboard AS
SELECT 
    -- بيانات الطلبية
    SOH.SalesOrderID,
    SOH.OrderDate,
    SOH.Status,
    
    -- بيانات العميل (من سكيما Sales و Person)
    P.FirstName + ' ' + P.LastName AS CustomerName,
    
    -- بيانات المنتج (من سكيما Production)
    Prd.Name AS ProductName,
    Cat.Name AS CategoryName,
    
    -- بيانات المبيعات المالية
    SOD.OrderQty,
    SOD.UnitPrice,
    SOD.LineTotal,
    
    -- بيانات المنطقة (من سكيما Sales)
    ST.Name AS TerritoryName,
    ST.[Group] AS RegionGroup

FROM AdventureWorks2025.Sales.SalesOrderHeader AS SOH
INNER JOIN AdventureWorks2025.Sales.SalesOrderDetail AS SOD 
    ON SOH.SalesOrderID = SOD.SalesOrderID
INNER JOIN AdventureWorks2025.Sales.Customer AS Cust 
    ON SOH.CustomerID = Cust.CustomerID
LEFT JOIN AdventureWorks2025.Person.Person AS P 
    ON Cust.PersonID = P.BusinessEntityID
INNER JOIN AdventureWorks2025.Production.Product AS Prd 
    ON SOD.ProductID = Prd.ProductID
LEFT JOIN AdventureWorks2025.Production.ProductSubcategory AS Sub 
    ON Prd.ProductSubcategoryID = Sub.ProductSubcategoryID
LEFT JOIN AdventureWorks2025.Production.ProductCategory AS Cat 
    ON Sub.ProductCategoryID = Cat.ProductCategoryID
INNER JOIN AdventureWorks2025.Sales.SalesTerritory AS ST 
    ON SOH.TerritoryID = ST.TerritoryID;
GO

select * from v_MainSalesDashboard;