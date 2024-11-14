/*Task 4:
Create a stored procedure.
Start a transaction.
Create an @EmployeeId int variable
Using data from tables Employee, BusinessEntity and EmployeePayHistory get the Employee with the smallest monthly salary and insert their salary into @EmployeeId
Use PRINT to output their salary
Update their salary to 5000000 and after that print it again
ROLLBACK the transaction and print the salary one last time*/
CREATE PROCEDURE UpdateEmployeeWithSmallestSalary
AS
BEGIN
    SET XACT_ABORT ON;

    DECLARE @EmployeeId INT;
    DECLARE @OriginalSalary MONEY;

    BEGIN TRANSACTION;

    BEGIN TRY
        SELECT TOP 1 
            @EmployeeId = e.BusinessEntityID,
            @OriginalSalary = eph.Rate
        FROM 
            HumanResources.Employee AS e
        INNER JOIN 
            HumanResources.EmployeePayHistory AS eph ON e.BusinessEntityID = eph.BusinessEntityID
        ORDER BY 
            eph.Rate ASC;

        PRINT 'Original Salary: ' + CAST(@OriginalSalary AS VARCHAR(20));

        UPDATE HumanResources.EmployeePayHistory
        SET Rate = 500000000
        WHERE BusinessEntityID = @EmployeeId;

        PRINT 'Updated Salary: 5000000';

        ROLLBACK;

        SELECT @OriginalSalary = Rate
        FROM HumanResources.EmployeePayHistory
        WHERE BusinessEntityID = @EmployeeId;

        PRINT 'Salary After Rollback: ' + CAST(@OriginalSalary AS VARCHAR(20));
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK;
            PRINT 'Transaction rolled back due to an error.';
        END

        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH;
END;

EXEC UpdateEmployeeWithSmallestSalary
