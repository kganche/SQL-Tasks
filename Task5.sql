/*Task 5:
Create a custom type AddressType (using CREATE TYPE command) with the same columns as Address table (except id, guid and modifieddate since they are generated automatically)
Create a stored procedure that accepts table value parameter @Addresses of type AddressType and insert all addresses from table value parameter (@Adresses) into Address table.*/
CREATE TYPE AddressType AS TABLE
(
    AddressLine1 NVARCHAR(60),
    AddressLine2 NVARCHAR(60),
    City NVARCHAR(30),
    StateProvinceID INT,
    PostalCode NVARCHAR(15),
    SpatialLocation GEOGRAPHY
);

CREATE PROCEDURE InsertAddresses
    @Addresses AddressType READONLY
AS
BEGIN
    INSERT INTO Person.Address (AddressLine1, AddressLine2, City, StateProvinceID, PostalCode, SpatialLocation)
    SELECT AddressLine1, AddressLine2, City, StateProvinceID, PostalCode, SpatialLocation
    FROM @Addresses;
END;

DECLARE @NewAddresses AddressType;

INSERT INTO @NewAddresses (AddressLine1, AddressLine2, City, StateProvinceID, PostalCode, SpatialLocation)
VALUES 
    ('Mordor', 'Barad-Dur', 'Middle Earth', 1, '1000', NULL),
    ('Shire', NULL, 'Middle Earth', 2, '2000', NULL);

EXEC InsertAddresses @Addresses = @NewAddresses;