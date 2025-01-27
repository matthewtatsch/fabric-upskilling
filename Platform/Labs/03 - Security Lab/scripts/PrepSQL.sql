
--Change authentication mode of SQL Server to mixed mode
USE [master]
GO
EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'LoginMode', REG_DWORD, 2
GO

-- Stop the SQL Server service
!! net stop MSSQLSERVER

-- Start the SQL Server service
!! net start MSSQLSERVER

-- Enable port 1433 on the firewall for incoming connections
!! powershell.exe -Command "New-NetFirewallRule -DisplayName 'Allow SQL Server' -Direction Inbound -Protocol TCP -LocalPort 1433 -Action Allow"


-- Check if the database exists and drop it if it does
USE tempdb;
GO

DECLARE @SQL AS NVARCHAR (1000);

IF EXISTS (SELECT 1
           FROM sys.databases
           WHERE [name] = N'Customers')
    BEGIN
        SET @SQL = N'USE [Customers];

                 ALTER DATABASE Customers SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
                 USE [tempdb];

                 DROP DATABASE Customers;';
        EXECUTE (@SQL);
    END

-- Create the new database
CREATE DATABASE Customers;
GO

-- Use the newly created database
USE Customers;
GO

-- Create the table
CREATE TABLE TblCustomers (
    CustomerID INT ,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    PhoneNumber NVARCHAR(15)
);
GO

-- Insert 10 records into the table
INSERT INTO TblCustomers (CustomerID, FirstName, LastName, Email, PhoneNumber) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '234-567-8901'),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', '345-678-9012'),
(4, 'Emily', 'Davis', 'emily.davis@example.com', '456-789-0123'),
(5, 'David', 'Brown', 'david.brown@example.com', '567-890-1234'),
(6, 'Sarah', 'Wilson', 'sarah.wilson@example.com', '678-901-2345'),
(7, 'James', 'Taylor', 'james.taylor@example.com', '789-012-3456'),
(8, 'Linda', 'Anderson', 'linda.anderson@example.com', '890-123-4567'),
(9, 'Robert', 'Thomas', 'robert.thomas@example.com', '901-234-5678'),
(10, 'Patricia', 'Jackson', 'patricia.jackson@example.com', '012-345-6789');
GO

--Create a login
IF NOT EXISTS 
    (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'sqluser')
BEGIN
    CREATE LOGIN sqluser WITH PASSWORD = N''
END

--Grant db reader access to the database

-- Use the Customers database
USE Customers;
GO

-- Create a new user
CREATE USER sqluser FOR LOGIN sqluser;
GO

-- Grant db_datareader access to the user
ALTER ROLE db_datareader ADD MEMBER sqluser;
GO