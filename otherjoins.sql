CREATE TABLE Students

(
	Id INT PRIMARY KEY IDENTITY,
	Fullname NVARCHAR(20),
	Point TINYINT CHECK(Point>=0 AND Point<=100)
)

CREATE TABLE [Certificates]
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(20),
	[Min] TINYINT,
	[Max] TINYINT
)


SELECT S.*,G.No,C.Name FROM Students AS S
JOIN Groups AS G ON S.GroupId=G.Id
LEFT JOIN Certificates AS C ON S.Point BETWEEN C.Min AND C.Max

SELECT D.*,MD.Name AS Main FROM Departments AS D
LEFT JOIN Departments AS MD ON D.DepartmentId=MD.Id

SELECT * FROM Students
CROSS JOIN Certificates