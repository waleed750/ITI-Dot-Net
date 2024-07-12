--2.	create function that return top (Number) products in orders

Create Function Products_Orders(@Number int )
returns table
as 
return
   Select top (@Number) SalesLT.Product.*
   from SalesLT.Product inner join SalesLT.SalesOrderDetail on SalesLT.Product.ProductID = SalesLT.SalesOrderDetail.ProductID; 

select * from Products_Orders(10);

create Function Products_Orders2(@Number int )
returns table 
as 
return 
	Select top (@Number) SalesLT.Product.Name , SUM(SalesLT.SalesOrderDetail.OrderQty) as "Sum Quantity"
	from SalesLT.Product inner join SalesLT.SalesOrderDetail on SalesOrderDetail.ProductID = Product.ProductID
	group by SalesLT.Product.Name

select * from Products_Orders2(10);

--3.	create function that return customer orders by customer ID

create Function Customer_Orders ()
Returns table
as 
return (
	
	
	select top (select COUNT(SalesLT.Customer.CustomerID) from SalesLT.Customer )  Customer.CompanyName , SalesLT.Product.Name as "Product Name" , sum(SalesLT.SalesOrderDetail.OrderQty) as "Quantity"
	from SalesLT.Customer inner join SalesLT.SalesOrderHeader on SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID
	inner join SalesLT.SalesOrderDetail on SalesLT.SalesOrderDetail.SalesOrderID = SalesLT.SalesOrderHeader.SalesOrderID
	inner join SalesLT.Product on SalesLT.Product.ProductID = SalesLT.SalesOrderDetail.ProductID
	group by Customer.CompanyName  , SalesLT.Product.Name 
    order by Quantity desc
	)
select * from Customer_Orders();

--4.	crate index in table customer, orders 

create index Customer_id 
on SalesLT.Customer (CustomerID) 



create index order_id3
on SalesLT.SalesOrderHeader(SalesOrderID desc , ShipDate asc)

select SalesOrderID , ShipDate from SalesLT.SalesOrderHeader ;


--5.	Crate Triger to update ModifiedDate in table CustomerAddress after update

CREATE TRIGGER DateAlert 
on SalesLT.CustomerAddress
after update
as 
if UPDATE(ModifiedDate)
	print 'Modified date was updated '
   
update SalesLT.CustomerAddress
set ModifiedDate = '2-8-2021'
where CustomerID = 29485;


--6.	Crate Triger that display last added in Customer

Create trigger Customer_Address
on SalesLT.Customer
after insert 
as 
begin 
Select * from SalesLT.Customer where CustomerID = (Select MAX(CustomerID) from SalesLT.Customer)
end
/*On EXCUTING INSERT IT WILL DISPLAY THE LAST RECORD */ 
insert into SalesLT.Customer
values ('True',	'Mr.',	'Ahmad',	'M.',	'Armstrong',	'Jr.	','Resale Services	','adventure-works\linda3	','thomas1@adventure-works.com'	,'226-555-0146'	,'8ml/xroz0hroeUDl/KW2y2QlIIgHgygotLw0Md60cBY='	,'hXYQBis=',	'067bn7da-667d-4145-910c-ee0c82caa0e4' ,	'2001-08-01 00:00:00.000')



--7.	Create view that represent data from table customer with orders and products 
create view [Show_Details]
as
Select Concat(SalesLT.Customer.FirstName , ' ' ,SalesLT.Customer.LastName) "Name" , SalesLT.Product.Name as 'Product' , SalesLT.SalesOrderDetail.OrderQty as 'Quantity'
from SalesLT.SalesOrderHeader inner join SalesLT.SalesOrderDetail on  SalesLT.SalesOrderDetail.SalesOrderID = SalesLT.SalesOrderDetail.SalesOrderID
inner join SalesLT.Product on SalesLT.Product.ProductID = SalesLT.SalesOrderDetail.ProductID
inner join SalesLT.Customer on SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID;


select * from Show_Details;


--8.	Try the use aggregate functions

Select SalesLT.Customer.FirstName , count(SalesLT.SalesOrderDetail.UnitPriceDiscount )  as "Number of Discounts" , sum(SalesLT.SalesOrderDetail.OrderQty) as "Sum of quantity " 
from SalesLT.Customer, SalesLT.SalesOrderDetail 
group by SalesLT.Customer.FirstName


--9.	  Try to group by  in Product by Model Number

Select  ProductNumber , Name , ProductID 
from SalesLT.Product 
GROUP BY ProductNumber , Name , ProductID


--10.	Create Stored Procedure for Insert , Update in ProductCategory table

Create procedure Product_insert_update (@id int , @id2 int , @Name nvarchar(50)
,@row uniqueidentifier , @ModDate datetime ,@operation nvarchar(8))
as
Begin
if @operation = 'insert'
   begin 
		insert into SalesLT.ProductCategory values( @id2 , @Name , @row  ,@ModDate);
   end
if @operation = 'update'
	begin 
	update SalesLT.ProductCategory
	set Name=@Name , rowguid = @row  ,@ModDate = GETDATE()
	where ProductCategoryID = @id or ParentProductCategoryID = @id2;
	end
end

exec Product_insert_update @id = 1, @id2 = 1,@Name = 'Waleed',@row = '0E984725-C51C-4BF4-9960-E1C80E27ABA0'     ,@ModDate = '7-10-2000' 
,@operation = 'insert' ;

exec Product_insert_update @id = 5, @id2 = 1,@Name = 'Gaming Pc',@row = '2d364ade-264a-433c-b092-4fcbf3804e01'     ,@ModDate = '7-10-2000' 
,@operation = 'update' ;