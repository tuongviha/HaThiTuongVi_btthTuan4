CREATE DATABASE Movies
GO
(
    NAME = Movies_data,  
    FILENAME = 'C:\\Users\\Haaviee\\Desktop\\CSDL\\tuan 4\\Movies_data.mdf',
    SIZE = 25MB,
    MAXSIZE = 40MB,
    FILEGROWTH = 1MB
)
LOG ON 
(
    NAME = Movies_log,
    FILENAME = 'C:\\Users\\Haaviee\\Desktop\\CSDL\\tuan 4\\BTTHs2\\Movies_log.ldf',
    SIZE = 6MB,
    MAXSIZE = 8MB,
    FILEGROWTH = 1MB
);

ALTER DATABASE Movies 
ADD FILE 
(
    NAME = Movies_data2,
    FILENAME = 'C:\\Users\\Haaviee\\Desktop\\CSDL\\tuan 4\\BTTHs2\Movies_data2.ndf',
    SIZE = 10MB
);
ALTER DATABASE Movies SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

ALTER DATABASE Movies SET RESTRICTED_USER;

ALTER DATABASE Movies SET MULTI_USER;

ALTER DATABASE Movies
MODIFY FILE 
(
    NAME = Movies_data2,
    SIZE = 15 MB,
);

ALTER DATABASE Movies 
SET AUTO_SHRINK ON;

DROP DATABASE Movies;


ALTER DATABASE Movies
MODIFY FILE
(
    NAME = Movies_log,
    MAXSIZE = 10MB
);

ALTER DATABASE Movies 
MODIFY FILE 
(
    NAME = Movies_data2,
    SIZE = 10MB
);

ALTER DATABASE Movies 
MODIFY FILE 
(
    NAME = Movies_data2,
    SIZE = 10MB
);

ALTER DATABASE Movies 
MODIFY FILE 
(
    NAME = Movies_data2,
    FILEGROUP = Data
);




USE Movies;

CREATE TABLE Movie (
    MovieID INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(255) NOT NULL,
    ReleaseYear INT,
    Genre NVARCHAR(100)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) UNIQUE,
    Phone NVARCHAR(20)
);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY,
    CategoryName NVARCHAR(255) NOT NULL
);

USE Movies;

-- Tạo CSDL
CREATE DATABASE Movies;
GO
USE Movies;
GO

-- Định nghĩa User-Defined Data Types
CREATE TYPE Movie_num FROM INT NOT NULL;
CREATE TYPE Category_num FROM INT NOT NULL;
CREATE TYPE Cust_num FROM INT NOT NULL;
CREATE TYPE Invoice_num FROM INT NOT NULL;
GO

-- Tạo bảng Customer
CREATE TABLE Customer (
    Cust_num Cust_num IDENTITY(300,1) PRIMARY KEY,
    Lname VARCHAR(20) NOT NULL,
    Fname VARCHAR(20) NOT NULL,
    Address1 VARCHAR(30) NULL,
    Address2 VARCHAR(20) NULL,
    City VARCHAR(20) NULL,
    State CHAR(2) NULL,
    Zip CHAR(10) NULL,
    Phone VARCHAR(10) NOT NULL,
    Join_date SMALLDATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- Tạo bảng Category
CREATE TABLE Category (
    Category_num Category_num IDENTITY(1,1) PRIMARY KEY,
    Description VARCHAR(20) NOT NULL
);
GO

-- Tạo bảng Movie
CREATE TABLE Movie (
    Movie_num Movie_num PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Category_Num Category_num NOT NULL,
    Date_purch SMALLDATETIME NULL DEFAULT GETDATE(),
    Rental_price INT NULL,
    Rating CHAR(5) NULL,
    CONSTRAINT FK_movie FOREIGN KEY (Category_Num) REFERENCES Category(Category_num)
);
GO

-- Tạo bảng Rental
CREATE TABLE Rental (
    Invoice_num Invoice_num PRIMARY KEY,
    Cust_num Cust_num NOT NULL,
    Rental_date SMALLDATETIME NOT NULL DEFAULT GETDATE(),
    Due_date SMALLDATETIME NOT NULL DEFAULT DATEADD(DAY, 2, GETDATE()),
    CONSTRAINT FK_rental FOREIGN KEY (Cust_num) REFERENCES Customer(Cust_num)
);
GO

-- Tạo bảng Rental_Detail
CREATE TABLE Rental_Detail (
    Invoice_num Invoice_num NOT NULL,
    Line_num INT NOT NULL,
    Movie_num Movie_num NOT NULL,
    Rental_price SMALLMONEY NULL,
    PRIMARY KEY (Invoice_num, Line_num),
    CONSTRAINT FK_detail_invoice FOREIGN KEY (Invoice_num) REFERENCES Rental(Invoice_num) ON DELETE CASCADE,
    CONSTRAINT FK_detail_movie FOREIGN KEY (Movie_num) REFERENCES Movie(Movie_num)
);
GO

-- Ràng buộc CHECK
ALTER TABLE Movie ADD CONSTRAINT CK_movie CHECK (Rating IN ('G', 'PG', 'R', 'NC17', 'NR'));
ALTER TABLE Rental ADD CONSTRAINT CK_Due_date CHECK (Due_date >= Rental_date);
GO

