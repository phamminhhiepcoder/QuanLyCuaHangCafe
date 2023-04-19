CREATE DATABASE QuanLyCoffee
GO

USE QuanLyCoffee
GO

--FOOD
--TABLE
--FOODCategory
--Account
--Bill
--BillInfo

CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'TRỐNG'		--Empty//Alive

)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(10)	PRIMARY KEY ,
	DisplayName NVARCHAR(100)	NOT NULL DEFAULT N'KHÁCH HÀNG', 
	PassWord NVARCHAR(100)	NOT NULL DEFAULT 0,
	Type INT NOT NULL DEFAULT 0 --1: ADMIN OR 0:Staff


)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100)	NOT NULL DEFAULT N'Chưa đặt tên',
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100)	NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,	
	price FLOAT NOT NULL DEFAULT 0

	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckin DATE NOT NULL DEFAULT GETDATE(),
	DateCheckout DATE,
	idTableFood INT NOT NULL,
	status INT NOT NULL	DEFAULT 0, -- Complete pay or not
	
	FOREIGN KEY (idTableFood) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0

	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food(id)
	
)

--Insert dữ liệu Account

INSERT INTO	dbo.Account
	( UserName,
	DisplayName,
	PassWord,
	Type
	)
VALUES	(
		N'Admin1',
		N'Hoang',
		N'1',
		1

		)
INSERT INTO	dbo.Account
	( UserName,
	DisplayName,
	PassWord,
	Type
	)
VALUES	(
		N'Staff1',
		N'HoangStaff',
		N'1',
		0

		)
--Stored Procedure
CREATE PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO

EXEC dbo.USP_GetAccountByUserName @userName = N'Admin1'
GO

--Dùng Stored Procedure cho Login
CREATE PROC USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END
GO

SELECT * FROM dbo.TableFood
--Chạy dữ liệu bàn ăn có 10 bàn( thêm bàn )
DECLARE @i INT = 0

WHILE @i <= 10
BEGIN
	INSERT dbo.TableFood( name) VALUES (N'Bàn' + CAST(@i AS NVARCHAR(100)))
	SET @i = @i + 1
END
GO

--Stored Procedure cho TableFood

CREATE PROC USP_GetTableList
AS SELECT * FROM dbo.TableFood
GO

UPDATE dbo.TableFood SET status = N'Có Người' WHERE id = 9

EXEC dbo.USP_GetTableList
GO

--Thêm Category
INSERT dbo.FoodCategory (name )
VALUES (N'Hải Sản')

INSERT dbo.FoodCategory (name )
VALUES (N'Nông Sản')

INSERT dbo.FoodCategory (name )
VALUES (N'Lâm Sản')

INSERT dbo.FoodCategory (name )
VALUES (N'Nước')

--Thêm Thức Ăn
--1.Hải sản
INSERT dbo.Food(name, idCategory, price)
VALUES (N'Cua Biển Rang Muối',
		N'1',
		200000		
)

INSERT dbo.Food(name, idCategory, price)
VALUES (N'Mực một nắng nướng sa tế',
		N'1',
		120000		
)


INSERT dbo.Food(name, idCategory, price)
VALUES (N'Nghêu Hấp Sả',
		N'1',
		50000		
)

--2.Nông Sản
INSERT dbo.Food(name, idCategory, price)
VALUES (N'Vú Dê Nướng',
		N'2',
		80000		
)

INSERT dbo.Food(name, idCategory, price)
VALUES (N'Cơm Chiên Dương Châu',
		N'2',
		40000		
)

--3.Lâm Sản
INSERT dbo.Food(name, idCategory, price)
VALUES (N'Heo Rừng Nướng Muối Oứt',
		N'3',
		150000		
)

--4.Nước
INSERT dbo.Food(name, idCategory, price)
VALUES (N'Coffee',
		N'4',
		30000	
)
INSERT dbo.Food(name, idCategory, price)
VALUES (N'Trà Tắc',
		N'4',
		20000		
)

--Thêm Bill
--Bill 1
INSERT dbo.Bill(DateCheckin, DateCheckout, idTableFood,status)
VALUES (GETDATE(), NULL, 3, 0)

INSERT dbo.Bill(DateCheckin, DateCheckout, idTableFood,status)
VALUES (GETDATE(), NULL, 9, 0)

--Bill 2:
INSERT dbo.Bill(DateCheckin, DateCheckout, idTableFood,status)
VALUES (GETDATE(), NULL, 4, 0)

--Bill 3:
INSERT dbo.Bill(DateCheckin, DateCheckout, idTableFood,status)
VALUES (GETDATE(), GETDATE(), 5, 1)

--Thêm BillInfo
INSERT dbo.BillInfo(idBill,idFood,count)
values (5 --idBill
		,1--idFood
		,2--count
		)

INSERT dbo.BillInfo(idBill,idFood,count)
values (5 --idBill
		,3--idFood
		,4--count
		)

INSERT dbo.BillInfo(idBill,idFood,count)
values (6 --idBill
		,3--idFood
		,1--count
		)
GO

Select * From dbo.BillInfo where idBill = 5

SELECT * FROM dbo.Bill
SELECT * FROM dbo.BillInfo
SELECT * FROM dbo.Food
 SELECT * FROM dbo.FoodCategory
 SELECT * FROM dbo.TableFood

 


