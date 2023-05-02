CREATE DATABASE KompStore

USE KompStore

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
(4,4500,'TN1',16, 256)

INSERT INTO Notebooks(BrandId,Price,Name,RAM,Storage)
VALUES
(2,2300,'E56',16, 512),
(2,3200,'E57',32, 1024),
(4,5500,'TN2',16, 256)

SELECT BrandId FROM Notebooks
GROUP BY BrandId



SELECT * FROM Notebooks
ORDER BY Id ASC

SELECT * FROM Notebooks
ORDER BY Price DESC

CREATE TABLE Phones
(
	Id INT PRIMARY KEY IDENTITY,
	BrandId INT FOREIGN KEY REFERENCES Brands(Id),
	Name NVARCHAR(50),
	Price MONEY,
	SimCount TINYINT,
	Storage INT
)



INSERT INTO Phones
VALUES
(1,'Iphone 12 PRO',2300,1, 128),
(1,'Iphone 14 PRO',3300,1, 128),
(1,'Iphone 15 PRO',4300,1, 256),
(2,'E55',2300,1, 128),
(3,'Asus Phoe',1300,1, 128),
(7,'6300',5400,1, 8),
(9,'Dell Phone',65,1, 120)

SELECT * FROM (SELECT P.Id,P.Name,B.Name AS 'BrandAdi',P.Price FROM Phones AS P
JOIN Brands AS B ON P.BrandId=B.Id
UNION 
SELECT N.Id,N.Name,B.Name AS 'BrandName',N.Price FROM Notebooks AS N
JOIN Brands AS B ON N.BrandId=B.Id) Products


CREATE VIEW VW_AllProducts
AS
SELECT * FROM (SELECT P.Id,P.Name,B.Name AS BrandName,P.Price FROM Phones AS P
JOIN Brands AS B ON P.BrandId=B.Id
UNION 
SELECT N.Id,N.Name,B.Name AS BrandName,N.Price FROM Notebooks AS N
JOIN Brands AS B ON N.BrandId=B.Id) Products


SELECT * FROM VW_AllProducts
WHERE Price>(Select AVG(Price) FROM VW_AllProducts)

SELECT * FROM VW_AllProducts
WHERE Name LIKE '%a%'

CREATE PROCEDURE USP_FilterProducts 
@MinPrice MONEY,@MaxPrice MONEY
AS
SELECT * FROM VW_AllProducts WHERE Price BETWEEN @MinPrice AND @MaxPrice

EXEC USP_FilterProducts 2000,4600


