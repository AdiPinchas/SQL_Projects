create database SALES_DWH
go 

use SALES_DWH
go

create table Dim_Customer (
CustomerSK int identity(100,1) PRIMARY KEY ,
CustomerID int not null,
CustomerName nvarchar(150),
LocationSK nvarchar(50),
PriceListID int)

create table Dim_Product (
PartSK int identity(100,1) PRIMARY KEY ,
PartID nvarchar(50) not null,
PartName nvarchar(50),
BrandDes nvarchar(50),
Category nvarchar(50),
SubCategory nvarchar(50))

create table Dim_Location (
LocationSK int identity(100,1) PRIMARY KEY ,
LocationID nvarchar(50),
CityName nvarchar(50),
Latitude nvarchar(50),
Longitude nvarchar(50),
Coordinate nvarchar(50),
RegionName nvarchar(50))

create table Fact_Sales (
SalesSK int identity(100,1) PRIMARY KEY not null,
SaleID nvarchar(50),
[Date] date,
PartSK nvarchar(50),
CustomerSK nvarchar(50),
Quantity_Carton nvarchar(50),
PriceListSK int,
ProductPrice Decimal(14,2),
ProductCost Decimal(14,2), 
UnitsInCarton int)





