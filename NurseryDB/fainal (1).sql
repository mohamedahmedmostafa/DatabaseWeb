use master
go
create database children;
create schema Nursery;
--------------------------------------


CREATE TABLE Level
(
    level_id INT PRIMARY KEY IDENTITY(1,1),
    level_Name VARCHAR(100) NOT NULL
);

CREATE TABLE Material
(
    Material_id INT PRIMARY KEY IDENTITY(1,1),
    book_name VARCHAR(100) NOT NULL,
    Copy_Count INT,
    book_price DECIMAL(20,2),
    Additional_Notes VARCHAR(700),
 payORnot_Material bit null,
);

 

CREATE TABLE CourseCollection
(
    Collection_id INT PRIMARY KEY IDENTITY(1,1),
    Collection_Name VARCHAR(100) NOT NULL,
    Collection_description TEXT,
    level_id INT null,
    Additional_Notes VARCHAR(300),
    FOREIGN KEY (level_id) REFERENCES Level(level_id) ON DELETE SET NULL ON UPDATE CASCADE
);



CREATE TABLE Courses
(
    Course_id INT PRIMARY KEY IDENTITY(1,1),
 
    Collection_id INT null,
    Course_Name VARCHAR(100) NOT NULL,
    Range_Age VARCHAR(60),
    Course_Description TEXT,
    Grade_Course INT,
    Additional_Notes VARCHAR(600),
    book INT null,
    FOREIGN KEY (Collection_id) REFERENCES CourseCollection(Collection_id) ON DELETE SET NULL ON UPDATE CASCADE,
   
    FOREIGN KEY (book) REFERENCES Material(Material_id) ON DELETE CASCADE ON UPDATE CASCADE
);

 
 


 
create table Room
(
Room_Id int Primary Key IDENTITY(1,1),
Room_Name varchar(50) not null,
Room_Type varchar(50),
Room_Rate decimal(10,2),
Room_Capacity int ,
Room_Description varchar(550),
Additional_Notes varchar(600)
);
 
 
 

  create table Parents
(
Parent_Id int Identity(1,1)  ,
SSN bigint  Primary Key , 
FullName Varchar(100) not null,
PhoneNumbers varchar(20),
EmailAddress varchar(100),
HomeAddress varchar(100),
JopTitle varchar(100),
WorkAddress varchar(100),
WorkSchedule varchar(100),
Additional_Notes varchar(500),
Relationship_to_Child varchar(20),
);

Create table Subscription
(
Sub_id int primary key ,
Name varchar(100) Not null,
Price decimal(20,2),
Location varchar(50),
Description varchar(300),
Additional_Notes varchar(400),
 
);




create table Child
(
Child_Id int  Identity(1,1),
Child_Code bigint Primary Key,
ChildName varchar(100) not null,
Child_Date Date,
Gender varchar(30),
Age int,
Child_Address varchar(100),
Child_Level int null,
Medical_Conditions varchar(100),
EmergencyContactInformation varchar(200),
AnySpecialNeedsORRequirement varchar(300),
DataJoin date,
Child_Photo image,
Child_certificate image,
Pay_Value decimal(10,3),
Notes varchar(300),
Parent_id bigint null,
payORnot_payvalue  bit null,
Room_Id int null,
CourseCollection varchar(100) null,
--FOREIGN KEY (Collection_id) REFERENCES CourseCollection(Collection_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
 FOREIGN KEY (Room_Id) REFERENCES Room(Room_Id) ON DELETE Set NULL ON UPDATE CASCADE,
 FOREIGN KEY (Parent_id) REFERENCES Parents(SSN) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (Child_Level) REFERENCES Level(level_id) ON DELETE Set NULL ON UPDATE CASCADE,
);
 


create table Child_Attendance(
ID int identity(1,1),
Child_Code bigint,
Attend bit default '1',
Age int,
Attend_Date date default cast(getdate() as date),
Attend_time time default cast(getdate() as time),
primary key(Child_Code,Attend_Date),
 FOREIGN KEY (Child_Code) REFERENCES Child(Child_Code) ON DELETE CASCADE ON UPDATE CASCADE
);

Create table Child_Subscriptions(
    Child_Id bigint,
    Sub_id INT,
    PRIMARY KEY (Child_Id, Sub_id),
    FOREIGN KEY (Child_Id) REFERENCES Child(Child_Code) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Sub_id) REFERENCES Subscription(Sub_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

create table Category_Subscription
(
ID int primary key identity(1,1),
Name varchar(100)
);


ALTER TABLE Subscription
ADD Category_FK int;

ALTER TABLE Subscription
ADD FOREIGN KEY (Category_FK) REFERENCES Category_Subscription(ID) ON DELETE NO Action ON UPDATE CASCADE;

create table ParentsHosting
(
Parent_id int  identity(1,1),
SSN bigint Primary key,
FullName varchar(50) Not null,
PhoneNumber varchar(30),
Email varchar(40),
Jop_Tittle varchar(50),
Work_Address varchar(40),
Home_Address varchar(50),
Additional_Notes varchar(300),
Work_Schedule varchar(60),
Relationship_to_Child varchar(50),
);

drop table ParentsHosting;



-- Create the ChildHosting table
CREATE TABLE ChildHosting
(
    Child_id int PRIMARY KEY IDENTITY(1,1),
    Name varchar(50) NOT NULL,
    ChildHosting_Code bigint,
    Address varchar(30),
    Medical_Condition varchar(300),
    Emergency_Contact varchar(50),
    Notes varchar(300),
    Date date,
    Hosting_date date,
    Gender varchar(10),
    Pay_value decimal(10,2),
    ChildHosting_Photo image,
    Date_Join DATETIME DEFAULT GETDATE(),
    Room_Id int NULL,
    host_parent_id bigint,
    FOREIGN KEY (Room_Id) REFERENCES Room(Room_Id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (host_parent_id) REFERENCES ParentsHosting(SSN) ON DELETE CASCADE ON UPDATE CASCADE
);

 
------------------------------------


create table Department (
Depart_id int primary key identity,
Type_Of_jop varchar(100)
);


Create table Employee
(
Emp_id int Identity(1,1),
SSN bigint Primary Key,
FullName varchar(100) not null,
Phone varchar(15),
Email varchar(100),
Home_Address varchar(30),
Qualification varchar(40),
Emp_Date date,
Gender varchar(7),
Emergency varchar(100),
Salary decimal(10,2),
degree_of_diplomats varchar(20),
Responsabilities varchar(40),
Duration int,
Experinces varchar(50),
photo image,
Date_Of_Join datetime default getdate(),
depart_ID int,
Notes varchar(300),
FOREIGN KEY (depart_ID) REFERENCES Department(Depart_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

 
create table Employee_Attendance(
ID int identity(1,1),
SSN bigint,
Attend bit default '1',
Attend_Date datetime default cast(getdate() as date),
Attend_time time default cast(getdate() as time),
primary key(SSN,Attend_Date),
 FOREIGN KEY (SSN) REFERENCES Employee(SSN) ON DELETE CASCADE ON UPDATE CASCADE
);



Create table Recive_Salary
(
Emp_id int Identity(1,1),
Emp_SSN bigint,
check_recive bit,
Salary decimal(10,2),
Bouns decimal(10,2),
Date_month int,
Salary_Date date default cast(getdate() as date),
Salary_Time time default cast(getdate() as time),
Notes varchar(300),
primary Key (Emp_SSN,Date_month),
FOREIGN KEY (Emp_SSN) REFERENCES Employee(SSN) ON DELETE NO ACTION ON UPDATE CASCADE
);


create table Admin 
(
Admin_id int identity(1,1),
Code bigint primary key ,
UserName varchar(100),
Password varchar(50),
Date_Of_creation datetime default getdate(),
Manager_ID bigint null,
FOREIGN KEY (Manager_ID) REFERENCES Admin(Code) ON DELETE NO ACTION ON UPDATE NO ACTION
);


create table Schadule 
(
ID int identity(1,1),
Days varchar(20),
Course_FK int,
Employee_FK_SSN bigint,
Room_FK int,
Starts_Date time,
End_Date time,
  primary key(Room_FK,Starts_Date),
FOREIGN KEY (Room_FK) REFERENCES Room(Room_Id) ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (Employee_FK_SSN) REFERENCES Employee(SSN) ON DELETE Set NULL ON UPDATE CASCADE,
 FOREIGN KEY (Course_FK) REFERENCES Courses(Course_Id) ON DELETE CASCADE ON UPDATE CASCADE,
);



 -----------------------= Accounting
 
  create Table Revenues
(
Revenue_Id int Primary Key Identity(1,1),
Type varchar(30),
Value decimal(10,2),
Bouns decimal(10,2),
Revenue_Date date,
Revenue_time time,
descrption varchar(200)
);

 create Table Fees
(
Fees_Id int Primary Key Identity(1,1),
Type varchar(30),
Value decimal(10,2),
Bouns decimal(10,2),
Fees_Date date,
Fees_time time,
descrption varchar(200)
);


