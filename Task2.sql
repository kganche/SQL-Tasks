/*Task 2:
Create a stored proc that would accept @PersonId int parameter and a @StoreId int parameter. 
•	If @PersonId is not null, then load customer records that are referencing that person and select all SalesOrderHeader records associated with that customer
•	If @PersonId is null and @StoreId is not null, then load all sale order headers for that store’s customer record
•	Otherwise Throw exception*/
CREATE PROCEDURE LoadCustomerSalesOrders
    @PersonId INT = NULL,
    @StoreId INT = NULL
AS
BEGIN
    IF @PersonId IS NOT NULL
    BEGIN
        SELECT 
            *
        FROM 
            Sales.Customer AS c
        INNER JOIN 
            Sales.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
        WHERE 
            c.PersonID = @PersonId;
    END
    ELSE IF @StoreId IS NOT NULL
    BEGIN
        SELECT 
            *
        FROM 
            Sales.Customer AS c
        INNER JOIN 
            Sales.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
        WHERE 
            c.StoreID = @StoreId;
    END
    ELSE
    BEGIN
        RAISERROR ('@PersonId or @StoreId must be provided.', 16, 1);
    END
END;

EXEC LoadCustomerSalesOrders @PersonId = 9002, @StoreId = NULL
EXEC LoadCustomerSalesOrders @PersonId = NULL, @StoreId = 934
EXEC LoadCustomerSalesOrders @PersonId = NULL, @StoreId = NULL