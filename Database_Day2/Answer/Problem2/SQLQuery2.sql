Create database Firm;

create table Property
(
ID int primary key , 
_Add nvarchar(50) , 
City nvarchar(50) , 
_State nvarchar(50) ,
Zip nvarchar(50) ,
);

create table Property_Owner(
property_id int ,
Owner_id int ,
Percent_owned int ,
foreign key (property_id) REFERENCES Property(ID),
foreign key (Owner_id) REFERENCES _Owner(ID)

);

create table _Owner
(
 ID int primary key , 
 _Name nvarchar(50) , 
);

drop table Sales_Office;


create table Sales_Office(

NUM int primary key ,
Loc nvarchar(50) , 
Employee_id int ,
Manger_id int unique ,

foreign key (NUM) REFERENCES Property(ID)
);

alter table Sales_Office
Add foreign key (Manger_id) REFERENCES  Employee(ID) ;

drop table Employee;

create table Employee(
ID int primary key  ,
_Name nvarchar(50) , 
foreign key (ID) REFERENCES Sales_Office(Num)

);


select 
Sales_Office.Manger_id, 
Employee._Name  
from Employee inner join Sales_Office on Sales_Office.Manger_id  =  Employee.ID ;

