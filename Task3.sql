/*Task 3:
Create a stored proc that accepts @StartDate and @EndDate parameters (datetime type). Load all records from SalesOrderHeader for which OrderDate is between @StartDate and @EndDate INTO a temp table #TOrders. 
#TOrders temp table should have the following columns: SalesOrderId, OrderDate, CreditCardId, CreditCardNumber.
After inserting that data, update the temp table with credit card number from the CreditCard table.*/
CREATE PROCEDURE LoadSalesOrdersWithCreditCardInfo
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    CREATE TABLE #TOrders (
        SalesOrderID INT,
        OrderDate DATETIME,
        CreditCardID INT,
        CreditCardNumber NVARCHAR(25)
    );

    INSERT INTO #TOrders (SalesOrderID, OrderDate, CreditCardID)
    SELECT 
        SalesOrderID,
        OrderDate,
        CreditCardID
    FROM 
        Sales.SalesOrderHeader
    WHERE 
        OrderDate BETWEEN @StartDate AND @EndDate;

    UPDATE T
    SET T.CreditCardNumber = CC.CardNumber
    FROM 
        #TOrders AS T
    INNER JOIN 
        Sales.CreditCard AS CC ON T.CreditCardID = CC.CreditCardID;

    SELECT * FROM #TOrders;
END;

EXEC LoadSalesOrdersWithCreditCardInfo @StartDate = '2000-01-01', @EndDate = '2025-01-01'