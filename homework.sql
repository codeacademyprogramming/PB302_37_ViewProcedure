CREATE TABLE Orders
(
	Id INT PRIMARY KEY IDENTITY,
	MealId INT FOREIGN KEY REFERENCES Meals(Id),
	TableId INT FOREIGN KEY REFERENCES Tables(Id),
	Date DATETIME2
)

--Bütün masadatalarını yanında o masaya edilmiş sifariş sayı ilə birlikdə select edən query
SELECT 
T.*,
(SELECT COUNT(*) FROM Orders AS O WHERE O.TableId=T.Id) AS OrdersCount  
FROM [Tables] AS T

-- Bütün yeməkləri o yeməyin sifariş sayı ilə select edən query
SELECT 
M.*,
(SELECT COUNT(*) FROM Orders AS O WHERE O.MealId=M.Id) AS OrdersCount  
FROM Meals AS M

--Bütün sirafiş datalarını yanında yeməyin adı ilə select edən query
SELECT O.*,M.Name AS MealName FROM Orders AS O
JOIN Meals AS M ON O.MealId=M.Id

--Bütün sirafiş datalarını yanında yeməyin adı və masanın nömrəsi  ilə select edən query
SELECT O.*,M.Name AS MealName, T.No AS TableNo,B.Name AS Branch FROM Orders AS O
JOIN Meals AS M ON O.MealId=M.Id
JOIN Tables AS T ON O.TableId=T.Id
JOIN Branches AS B ON T.BranchId=B.Id

--Bütün masa datalarını yanında o masının sifarişlərinin ümumi məbləği ilə select edən query 
SELECT SUM(Meals.Price) FROM Orders 
JOIN Meals ON Orders.MealId=Meals.Id
WHERE TableId=1

SELECT 
T.*,
(SELECT COUNT(*) FROM Orders WHERE Orders.TableId=T.Id) AS OrdersCount,
(SELECT SUM(Meals.Price) FROM Orders 
JOIN Meals ON Orders.MealId=Meals.Id
WHERE TableId=T.Id) AS TotalPrice
FROM Tables AS T


SELECT TOP(1) * FROM Orders
ORDER BY Date DESC

SELECT * FROM Meals
ORDER BY Price DESC

SELECT DATEDIFF(HOUR, MIN(Date),MAX(Date))FROM Orders

--ən son 30-dəqədən əvvəl verilmiş sifarişləri select edən query
SELECT * FROM Orders
WHERE Date<DATEADD(MINUTE,-30,GETDATE())


--heç sifariş verməmiş masaları select edən query
SELECT * FROM Tables
WHERE NOT EXISTS (SELECT Id FROM Orders WHERE TableId=Tables.Id)

--Son 60 dəqiqədə heç sifariş verməmiş masaları select edən query
SELECT * FROM Tables
WHERE NOT EXISTS (SELECT Id FROM Orders WHERE TableId=Tables.Id AND DATEDIFF(MINUTE,Date,GETDATE())<60)
