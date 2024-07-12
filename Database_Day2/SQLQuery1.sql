Create Database Musicana_records ;

create table Musician(
IRD nvarchar(50)  primary key,
_Name nvarchar(40) not null , 
City nvarchar(40) , 
St nvarchar(40),
phone int not null , 
Ins_Name nvarchar(50) ,

);



create table Instrument(
Ins_Name nvarchar(50) primary key,
Ins_Key int  ,

);

Create table Instrument_Musician
(
   Ins_Name nvarchar(50) , 
   IRD nvarchar(50),

   FOREIGN KEY (IRD) REFERENCES Musician(IRD) , 
   FOREIGN KEY (Ins_Name) REFERENCES Instrument(Ins_Name)

);


create table Song
(
  title nvarchar(50) primary key, 
  author nvarchar(50) , 
  
);


create table Song_and_Musician
(
   Musician nvarchar(50) ,
   Song nvarchar(50) , 
   FOREIGN KEY (Musician) REFERENCES Musician(IRD) , 
   FOREIGN KEY (Song) REFERENCES Song(title)
	
);



create table album 
(
   Id nvarchar(50) primary key , 
   cr_date date ,
   title nvarchar(50)
   FOREIGN KEY (Id) REFERENCES Musician(IRD),
   FOREIGN KEY (title) REFERENCES Song(title)
   
);


