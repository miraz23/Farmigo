CREATE DATABASE Farmigo;

-- Create necessary tables
CREATE TABLE Farmer (
    FarmerID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),
    Contact VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE Landlord (
    LandlordID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),
    Contact VARCHAR(15)
);

CREATE TABLE Land (
    LandID INT PRIMARY KEY IDENTITY(1,1),
    LandlordID INT FOREIGN KEY REFERENCES Landlord(LandlordID),
    FarmerID INT FOREIGN KEY REFERENCES Farmer(FarmerID),
    Location VARCHAR(200),
    Size DECIMAL(10, 2),
    IsLeased BIT DEFAULT 0,
    LeaseAmount DECIMAL(10, 2),
    StartDate DATE,
    EndDate DATE,
);


CREATE TABLE Crop (
    CropID INT PRIMARY KEY IDENTITY(1,1),
    FarmerID INT FOREIGN KEY REFERENCES Farmer(FarmerID),
    LandID INT FOREIGN KEY REFERENCES Land(LandID),
    CropName NVARCHAR(100),
    Quantity INT, -- Quantity in kilograms
    ProductionCost DECIMAL(10, 2)
);

CREATE TABLE Resource (
    ResourceID INT PRIMARY KEY IDENTITY(1,1),
    FarmerID INT FOREIGN KEY REFERENCES Farmer(FarmerID),
    ResourceName VARCHAR(100),
    Quantity INT,
    Cost DECIMAL(10, 2)
);

CREATE TABLE Buyer (
    BuyerID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),
    Contact VARCHAR(15)
);

CREATE TABLE Sale (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    BuyerID INT FOREIGN KEY REFERENCES Buyer(BuyerID),
    CropID INT FOREIGN KEY REFERENCES Crop(CropID),
    QuantitySold INT,
    SaleAmount DECIMAL(10, 2),
    SaleDate DATE
);

-- Weather Data Table
CREATE TABLE WeatherData (
    WeatherID INT PRIMARY KEY IDENTITY(1,1),
    LandID INT FOREIGN KEY REFERENCES Land(LandID),
    Date DATE,
    Temperature DECIMAL(5, 2), -- in Celsius
    Rainfall DECIMAL(5, 2), -- in mm
    Humidity DECIMAL(5, 2) -- in percentage
);

-- Crop Health Table
CREATE TABLE CropHealth (
    HealthID INT PRIMARY KEY IDENTITY(1,1),
    CropID INT FOREIGN KEY REFERENCES Crop(CropID),
    HealthStatus VARCHAR(50),
    InspectionDate DATE,
    Notes VARCHAR(255)
);

-- Loan Table
CREATE TABLE Loan (
    LoanID INT PRIMARY KEY IDENTITY(1,1),
    FarmerID INT FOREIGN KEY REFERENCES Farmer(FarmerID),
    LoanAmount DECIMAL(10, 2),
    InterestRate DECIMAL(5, 2), -- in percentage
    LoanDate DATE,
    RepaymentDueDate DATE,
    IsRepaid BIT DEFAULT 0
);




-- Insert Data into Farmer Table
INSERT INTO Farmer (Name, Contact, Email)
VALUES
    ('Rafiq Ahmed', '01745678901', 'rafiq.ahmed@example.com'),
    ('Sabrina Khatun', '01756789012', 'sabrina.khatun@example.com'),
    ('Kamal Hossain', '01767890123', 'kamal.hossain@example.com'),
    ('Lima Begum', '01778901234', 'lima.begum@example.com'),
    ('Shafiul Islam', '01789012345', 'shafiul.islam@example.com');

-- Insert Data into Landlord Table
INSERT INTO Landlord (Name, Contact)
VALUES
    ('Fatema Bibi', '01867890123'),
    ('Jamal Uddin', '01878901234'),
    ('Khadija Khan', '01889012345'),
    ('Mokbul Hossain', '01890123456'),
    ('Nasima Akter', '01801234567');

-- Insert Data into Land Table
INSERT INTO Land (LandlordID, FarmerID, Location, Size, IsLeased, LeaseAmount, StartDate, EndDate)
VALUES
    (3, 4, 'Rajshahi', 12.0, 1, 15000.00, '2024-01-01', '2024-12-31'),
    (4, 5, 'Khulna', 18.5, 0, NULL, NULL, NULL),
    (5, 1, 'Rangpur', 22.0, 1, 20000.00, '2024-02-01', '2024-11-30'),
    (2, 3, 'Mymensingh', 14.0, 1, 13000.00, '2024-03-01', '2024-12-31'),
    (3, 2, 'Jessore', 16.5, 0, NULL, NULL, NULL);

-- Insert Data into Crop Table
INSERT INTO Crop (FarmerID, LandID, CropName, Quantity, ProductionCost)
VALUES
    (4, 4, 'Potatoes', 1200, 4500.00),
    (5, 5, 'Onions', 900, 3000.00),
    (1, 3, 'Wheat', 1100, 5500.00),
    (2, 4, 'Sugarcane', 1500, 7000.00),
    (3, 2, 'Chili', 600, 3200.00),
	(3, 2, 'Garlic', 800, 4200);

-- Insert Data into Resource Table
INSERT INTO Resource (FarmerID, ResourceName, Quantity, Cost)
VALUES
    (4, 'Irrigation Water', 5000, 1200.00),
    (5, 'Compost Fertilizer', 300, 1800.00),
    (1, 'Tractor Rental', 2, 7000.00),
    (2, 'Harvesting Tools', 15, 1500.00),
    (3, 'Organic Pesticide', 250, 900.00);

-- Insert Data into Buyer Table
INSERT INTO Buyer (Name, Contact)
VALUES
    ('Rahima Khatun', '01890123456'),
    ('Harun Rashid', '01801234567'),
    ('Sonia Begum', '01812345678'),
    ('Kabir Hossain', '01823456789'),
    ('Shamim Reza', '01834567890');

-- Insert Data into Sale Table
INSERT INTO Sale (BuyerID, CropID, QuantitySold, SaleAmount, SaleDate)
VALUES
    (3, 3, 200, 1000.00, '2024-12-03'),
    (4, 4, 400, 2200.00, '2024-12-04'),
    (5, 5, 500, 2750.00, '2024-12-05'),
    (1, 1, 250, 1250.00, '2024-12-06'),
    (2, 2, 300, 1800.00, '2024-12-07');


-- Insert Data into WeatherData Table
INSERT INTO WeatherData (LandID, Date, Temperature, Rainfall, Humidity)
VALUES
    (3, '2024-12-03', 25.0, 8.0, 70.0),
    (4, '2024-12-04', 27.5, 0.0, 55.0),
    (5, '2024-12-05', 30.0, 3.0, 60.0),
    (2, '2024-12-06', 28.0, 7.0, 68.0),
    (1, '2024-12-07', 24.5, 4.0, 72.0);

-- Insert Data into CropHealth Table
INSERT INTO CropHealth (CropID, HealthStatus, InspectionDate, Notes)
VALUES
    (3, 'Healthy', '2024-12-03', 'No issues detected'),
    (4, 'Moderate', '2024-12-04', 'Minor yellowing of leaves'),
    (5, 'Diseased', '2024-12-05', 'Fungal infection found'),
    (1, 'Healthy', '2024-12-06', 'Optimal growth'),
    (2, 'Stressed', '2024-12-07', 'Water shortage observed');

-- Insert Data into Loan Table
INSERT INTO Loan (FarmerID, LoanAmount, InterestRate, LoanDate, RepaymentDueDate, IsRepaid)
VALUES
    (3, 6000.00, 5.5, '2024-03-01', '2025-03-01', 0),
    (4, 7000.00, 4.8, '2024-04-01', '2025-04-01', 0),
    (5, 9000.00, 5.2, '2024-05-01', '2025-05-01', 0),
    (1, 4000.00, 4.0, '2024-06-01', '2025-06-01', 0),
    (2, 10000.00, 5.0, '2024-07-01', '2025-07-01', 0);




-- **Select Query**
SELECT * FROM Farmer;
SELECT * FROM Landlord;
SELECT * FROM Land;
SELECT * FROM Crop;
SELECT * FROM Resource;
SELECT * FROM Buyer;
SELECT * FROM Sale;
SELECT * FROM WeatherData;
SELECT * FROM CropHealth;
SELECT * FROM Loan;



--Leased Land Details with Farmers, Landlords, and Crop Information
SELECT 
    Farmer.Name AS FarmerName, 
    Farmer.Contact AS FarmerContact, 
    Land.Location AS LandLocation, 
    Land.Size AS LandSize,
    Land.IsLeased, 
    Landlord.Name AS LandlordName, 
    Landlord.Contact AS LandlordContact, 
    Crop.CropName AS CropName,
    Crop.Quantity AS CropQuantity, 
    Crop.ProductionCost AS CropProductionCost 
FROM Land 
INNER JOIN Farmer ON Land.FarmerID = Farmer.FarmerID
INNER JOIN Landlord ON Land.LandlordID = Landlord.LandlordID 
INNER JOIN Crop ON Land.LandID = Crop.LandID 
WHERE Land.IsLeased = 1;



--Land and Crop Details: Locations, Crop Names, Quantities, and Production Costs
SELECT 
    Land.Location AS LandLocation,
    Crop.CropName AS CropName,
    Crop.Quantity AS CropQuantity,
    Crop.ProductionCost AS CropProductionCost
FROM Land
INNER JOIN Crop ON Land.LandID = Crop.LandID;



--Crop Yield Classification: High Yield vs Low Yield Categories
SELECT CropName,
       CASE -- **CASE Statement**
           WHEN Quantity > 10 THEN 'High Yield'
           ELSE 'Low Yield'
       END AS YieldCategory
FROM Crop;


--Aggregated Farm Data: Costs, Sales, Farmers, and Quantities Overview


SELECT 
    MIN(Crop.ProductionCost) AS MinCost,
    MAX(Sale.SaleAmount) AS MaxSale,
    COUNT(DISTINCT Farmer.FarmerID) AS TotalFarmers,
    SUM(Sale.QuantitySold) AS TotalQuantity,
    AVG(Sale.SaleAmount) AS AverageSale
FROM Farmer
JOIN Crop ON Farmer.FarmerID = Crop.FarmerID
JOIN Sale ON Crop.CropID = Sale.CropID;





--Update and Delete Query
UPDATE Crop SET Quantity = 20, ProductionCost = 70  WHERE CropID = 1;
UPDATE Crop SET Quantity = 25, ProductionCost = 105 WHERE CropID = 2;
UPDATE Crop SET Quantity = 10, ProductionCost = 40 WHERE CropID = 3;
UPDATE Crop SET Quantity = 22, ProductionCost = 55 WHERE CropID = 4;
UPDATE Crop SET Quantity = 8, ProductionCost = 90 WHERE CropID = 5;

DELETE FROM Crop WHERE CropID = 6;

UPDATE Sale SET QuantitySold = 7, SaleAmount = 50  WHERE SaleID = 1;
UPDATE Sale SET QuantitySold = 20, SaleAmount = 80  WHERE SaleID = 2;
UPDATE Sale SET QuantitySold = 8, SaleAmount = 100  WHERE SaleID = 3;
UPDATE Sale SET QuantitySold = 17, SaleAmount = 75  WHERE SaleID = 4;
UPDATE Sale SET QuantitySold = 24, SaleAmount = 120  WHERE SaleID = 5;



--Farmer Crop Production, Sales, and Profit Analysis
SELECT 
    Crop.FarmerID, 
    Crop.CropName,
	SUM(Crop.Quantity) AS ProducedKg,
    SUM(Sale.QuantitySold) AS SoldKg,
	SUM(Crop.Quantity - Sale.QuantitySold) AS RemainingKg,
    SUM(Sale.QuantitySold * Crop.ProductionCost) AS TotalCost,
    SUM(Sale.QuantitySold * Sale.SaleAmount) AS TotalSale,
    SUM((Sale.QuantitySold * Sale.SaleAmount) - 
	(Sale.QuantitySold * Crop.ProductionCost)) AS Profit
FROM Crop
INNER JOIN Sale ON Crop.CropID = Sale.CropID
GROUP BY Crop.FarmerID, Crop.CropName
ORDER BY FarmerID


--Retrieve All Buyers with Names Starting with 'Shamim' 
SELECT * FROM Buyer WHERE Name LIKE 'Shamim%';-- **LIKE Operator**


--Retrieve Crop Details with Health Status and Associated Weather Data
SELECT Crop.CropName, CropHealth.HealthStatus, 
WeatherData.Temperature, WeatherData.Rainfall, WeatherData.Humidity
FROM Crop
INNER JOIN CropHealth ON Crop.CropID = CropHealth.CropID
INNER JOIN Land ON Crop.LandID = Land.LandID
INNER JOIN WeatherData ON Land.LandID = WeatherData.LandID


-- Weather Conditions That May Affect Crops
SELECT Land.Location, WeatherData.Date, WeatherData.Temperature, 
WeatherData.Rainfall, WeatherData.Humidity FROM Land
INNER JOIN WeatherData ON Land.LandID = WeatherData.LandID
WHERE WeatherData.Rainfall < 10.0 OR WeatherData.Humidity < 50.0;


--Crops by Quantity and Available Large Lands 
SELECT * FROM Crop ORDER BY Quantity DESC;-- **ORDER BY Query**
SELECT * FROM Land WHERE Size > 1.5 AND IsLeased = 0;-- **Conditional Query**


--Unique Land Locations and Farmers with Land 
SELECT DISTINCT Location FROM Land;-- **DISTINCT**
SELECT FarmerID FROM Farmer WHERE EXISTS -- **EXISTS Query**
(SELECT * FROM Land WHERE Farmer.FarmerID = Land.LandlordID);


-- Outstanding Loans for Farmers
SELECT Farmer.Name AS FarmerName, Loan.LoanAmount, 
Loan.InterestRate, Loan.RepaymentDueDate FROM Farmer
INNER JOIN Loan ON Farmer.FarmerID = Loan.FarmerID
WHERE Loan.IsRepaid = 0;


--Farmers and Buyers Contact Information 
SELECT Name, Contact,
'Farmer' AS Role FROM Farmer
UNION SELECT Name, Contact, --Union 
'Buyer' AS Role FROM Buyer;


--Farmers with Loan
SELECT Farmer.Name AS FarmerName, -- Count function
Farmer.Contact As FarmerContact,
COUNT(Loan.LoanID) AS LoanCount
FROM Farmer
INNER JOIN Loan ON Farmer.FarmerID = Loan.FarmerID
GROUP BY Farmer.Name, Farmer.Contact
HAVING COUNT(Loan.LoanID) > 0;


--Land Locations and Associated Crop Names 
SELECT Land.Location,
Crop.CropName FROM Land 
LEFT JOIN Crop ON  -- **LEFT JOIN**
Land.LandID = Crop.LandID;


--Buyer Names and Associated Sale Amounts
SELECT Sale.SaleAmount, 
Buyer.Name AS BuyerName FROM 
Sale RIGHT JOIN Buyer ON -- **RIGHT JOIN**
Sale.BuyerID = Buyer.BuyerID; 


--Farmers with Total Production Cost Greater Than 40 
SELECT FarmerID, SUM(ProductionCost)
AS TotalCost FROM Crop GROUP BY FarmerID 
HAVING SUM(ProductionCost) > 40; -- **HAVING Clause**

-- Health Status of Crops for a Farmer

SELECT Farmer.Name AS FarmerName, Crop.CropName, 
CropHealth.HealthStatus, CropHealth.Notes FROM Farmer
INNER JOIN Crop ON Farmer.FarmerID = Crop.FarmerID
INNER JOIN CropHealth ON Crop.CropID = CropHealth.CropID;