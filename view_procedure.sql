CREATE TABLE Brands
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(20)
)

CREATE TABLE Notebooks
(
	Id INT PRIMARY KEY IDENTITY,
	BrandId INT FOREIGN KEY REFERENCES Brands(Id),
	Name NVARCHAR(50),
	Price MONEY,
	RAM TINYINT,
	Storage INT
)

CREATE TABLE Phones
(
	Id INT PRIMARY KEY IDENTITY,
	BrandId INT FOREIGN KEY REFERENCES Brands(Id),
	Name NVARCHAR(50),
	Price MONEY,
	SimCount INT,
	Storage INT
)

INSERT INTO Brands
VALUES
('Apple'),
('Acer'),
('Asus'),
('Toshiba'),
('Samsung'),
('Kur'),
('Nokia'),
('Lenova'),
('Dell')

INSERT INTO Notebooks(BrandId,Price,Name,RAM,Storage)
VALUES
(1,2500,'Macbook Air 13',8, 256),
(1,3500,'Macbook Air 15',16, 256),
(1,4500,'Macbook Pro 14',32, 512),
(2,2300,'E55',8, 256),
(3,3200,'ROG',32, 1024),
(4,4500,'TN1',16, 256),
(2,2300,'E56',16, 512),
(2,3200,'E57',32, 1024),
(4,5500,'TN2',16, 256)


INSERT INTO Phones(BrandId,Price,Name,SimCount,Storage)
VALUES
(1,1500,'Iphone 12',2, 256),
(1,5500,'Iphone 15Pro',16, 256),
(1,500,'Iphone 2',2, 120),
(2,2300,'E55',8, 256),
(3,2200,'ROB P',16, 1024),
(4,4500,'TN1',2, 256),
(2,2300,'E56',1, 512),
(2,2200,'E57',2, 1024),
(4,1500,'TN2',1, 256)

SELECT B.Name,AVG(Price) AS AVG,Min(Price) AS MIN,Max(Price) AS MAX FROM Notebooks
JOIN Brands AS B ON B.Id=BrandId
GROUP BY B.Name
HAVING Avg(Price)>3000

SELECT T.* FROM (SELECT N.Id,N.BrandId,N.Name,B.Name AS BrandName, N.Price FROM Notebooks AS N
JOIN Brands AS B ON B.Id=N.BrandId
UNION ALL
SELECT P.Id,P.BrandId, P.Name,B.Name AS BrandName, P.Price FROM Phones AS P
JOIN Brands AS B ON B.Id=P.BrandId) AS T
WHERE T.BrandId=1 AND Price<4000

CREATE VIEW VW_ALL_PRODUCTS
AS
SELECT N.Id,N.BrandId,N.Name,B.Name AS BrandName, N.Price FROM Notebooks AS N
JOIN Brands AS B ON B.Id=N.BrandId
UNION ALL
SELECT P.Id,P.BrandId, P.Name,B.Name AS BrandName, P.Price FROM Phones AS P
JOIN Brands AS B ON B.Id=P.BrandId

SELECT * FROM VW_ALL_PRODUCTS
WHERE Name LIKE '%A%'

CREATE PROCEDURE USP_Search_Products
AS
SELECT * FROM VW_ALL_PRODUCTS 

EXEC USP_Search_Products

ALTER PROCEDURE USP_Search_Products
@SEARCH NVARCHAR(20)
AS
SELECT * FROM VW_ALL_PRODUCTS WHERE Name LIKE CONCAT('%',@SEARCH,'%')

CREATE PROCEDURE USP_PRODUCTS_BY_PRICE
@MIN MONEY,
@MAX MONEY
AS
SELECT * FROM VW_ALL_PRODUCTS WHERE Price BETWEEN @MIN AND @MAX

EXEC USP_Search_Products 'Pro'

EXEC USP_PRODUCTS_BY_PRICE 2500,3500
