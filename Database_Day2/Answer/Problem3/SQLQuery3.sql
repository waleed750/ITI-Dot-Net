create database Hospital ; 

create table Patients
(
PID int primary key identity(1,1) , 
_Name nvarchar(50) not null, 
DOB date not null, 
foreign key (PID) REFERENCES Ward(WID)
);

create table Ward(

 WID int primary key ,

_Name nvarchar(50) , 

Supervision_id int ,

foreign key (WID) REFERENCES Nurse(NID),
foreign key (Supervision_id)  REFERENCES Nurse(NID)
);

create table Nurse 
(
    NID int primary key ,
   _Name nvarchar(50) 
   
);


Create table Drugs
(
Code int primary key ,
Bran_id int ,
Rec nvarchar(50),
foreign key (Bran_id) REFERENCES Bran(ID) 
);

create table Bran
(
   ID int primary key  , 
  _Name nvarchar(50) 

);
/* Relation Between Nurse , Drug and Patient*/
create table Nurse_Drug_Patient(
Nurse_id int ,
Drug_id int , 
patient_id int ,
_Date date , 
_Time time , 
Dosage nvarchar(50) , 
foreign key (Nurse_id) REFERENCES Nurse(NID),
foreign key (Drug_id) REFERENCES Drugs(Code),
foreign key (patient_id) REFERENCES Patients(PID),


);

create table Consultant
(
	CID int primary key , 
	_Name nvarchar(50) ,
);

create table Patient_Consultant
(
  Consultant_id int , 
  Patient_id int , 
  foreign key (Consultant_id) REFERENCES Consultant(CID) , 
  foreign key (Patient_id) REFERENCES Patients(PID)  
  
);

