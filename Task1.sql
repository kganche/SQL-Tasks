/*Task 1:
Create a stored procedure that would load data from [Sales].[Customer]  table joined with Person and Store*/

CREATE PROCEDURE LoadCustomersData
AS
BEGIN
    SELECT 
        *
    FROM 
        Sales.Customer AS c
    LEFT JOIN 
        Person.Person AS p ON c.PersonID = p.BusinessEntityID
    LEFT JOIN 
        Sales.Store AS s ON c.StoreID = s.BusinessEntityID
END;

EXEC LoadCustomersData