--------------------------------- mahmoud sherif-------------------

/* -------------SP_AddEmployee =-------------------*/

Create Procedure SP_AddEmployee @SSN bigint,
@FullName varchar(50),
@Phone varchar(15),
@Email varchar(100),
@Home_Address varchar(30),
@Qualification varchar(40),
@Emp_Date date,
@Gender varchar(7),
@Emergency varchar(100),
@Salary decimal(10,2),
@degree_of_diplomats varchar(20),
@Responsabilities varchar(40),
@Duration int,
@Experinces varchar(50),
@photo image,
@depart_ID int,
@Notes varchar(300)
with encryption
As
Begin
Insert into Employee(SSN,FullName,Phone,Email,Home_Address,Qualification,Emp_Date,Gender,Emergency,Salary,degree_of_diplomats,Responsabilities,Duration,Experinces,photo,depart_ID,Notes)
values(@SSN,@FullName,@Phone,@Email,@Home_Address,@Qualification,@Emp_Date,@Gender,@Emergency,@Salary,@degree_of_diplomats,@Responsabilities,@Duration,@Experinces,@photo,@depart_ID,@Notes);
End;


/*Update Employee Data*/

 Create Procedure SP_UpdateEmployee
 @SSN bigint,
@FullName varchar(50),
@Phone varchar(15),
@Email varchar(100),
@Home_Address varchar(30),
@Qualification varchar(40),
@Emp_Date date,
@Gender varchar(7),
@Emergency varchar(100),
@Salary decimal(10,2),
@degree_of_diplomats varchar(20),
@Responsabilities varchar(40),
@Duration int,
@Experinces varchar(50),
@photo image,
@depart_ID int,
@Notes varchar(300)
with encryption
As
Begin
Update Employee
Set
SSN=@SSN,
FullName=@FullName,
Phone=@Phone,
Email=@Email,
Home_Address=@Home_Address,
Qualification=@Qualification,
Emp_Date=@Emp_Date,
Gender=@Gender,
Emergency=@Emergency,
Salary=@Salary,
degree_of_diplomats=@degree_of_diplomats ,
Responsabilities=@Responsabilities,
Duration=@Duration,
Experinces=@Experinces,
photo=@photo,
depart_ID=@depart_ID,
Notes=@Notes
where SSN=@SSN;
End;


/*-------------------= Delete Employee  =----------*/

Create Procedure SP_DeleteEmployee
@ssn int
As
Begin
Delete From Employee Where SSN=@ssn;
End;


/* ----------------------= SP_AddDepartment =-------------------*/

Create Procedure SP_AddDepartment @Name varchar(20)
with encryption
As
Begin
Insert into Department(Type_Of_jop)
values(@Name);
End;

/*Update Department Data*/

 Create Procedure SP_UpdateDepartment @Name varchar(20),@id int
with encryption
As
Begin
Update Department
Set
Type_Of_jop=@Name
where Depart_id=@id;
End;


/*-------------------= Delete Department  =----------*/

Create Procedure SP_DeleteDepart @id int
As
Begin
Delete From Department Where Depart_id=@id;
End;

-------------------------= Add Admin  =---------------------------------------


Create Procedure SP_AddAdmin @code varchar(50),@userName varchar(50),@password varchar(50),@manager_ID int
with encryption
As
Begin
Insert into Admin(Code,UserName,Password,Manager_ID)
values(@code,@userName,@password,@manager_ID);
End;

/*Update Admin Data*/

 Create Procedure SP_UpdateAdmin @code varchar(50),@userName varchar(50),@password varchar(50),@manager_ID int
with encryption
As
Begin
Update Admin
Set
Code=@code,
UserName=@userName,
Password=@password,
Manager_ID=@manager_ID
where Code=@code;
End;


/*-------------------= Delete Admin  =----------*/

Create Procedure SP_DeleteAdmin @code varchar(50)
with encryption
As
Begin
Delete From Admin 
where Code=@code;
End;


-------------------------= Add Schadule  =---------------------------------------


Create Procedure SP_AddSchadule @days varchar(15),@RoomFK int,@CourseFK int,@EmployeeFK bigint,@STime time ,@ETime time
with encryption
As
Begin
Insert into Schadule(Days,Room_FK,Course_FK,Employee_FK_SSN,Starts_Date,End_Date)
values(@days,@RoomFK,@CourseFK,@EmployeeFK,@STime,@ETime);
End;

/*Update Schadule Data*/

 Create Procedure SP_UpdateSchadule @id int,@days varchar(15),@RoomFK int,@CourseFK int,@EmployeeFK bigint,@STime time ,@ETime time
with encryption
As
Begin
Update Schadule
Set
Days=@days,
Room_FK=Room_FK,
Course_FK=@CourseFK,
Employee_FK_SSN=@EmployeeFK,
Starts_Date=@STime,
End_Date=@ETime
where ID=@id;
End;


/*-------------------= Delete Schadule  =----------*/

Create Procedure SP_DeleteSchadule @id int
with encryption
As
Begin
Delete From Schadule 
where ID=@id;
End;



-------------------= Schadule =--------------------
create Procedure SP_GetSchadule 
with encryption
As
Begin
select count(s.ID),r.Room_Name,s.Days,r.Room_Name,e.FullName,c.Course_Name,s.Starts_Date,s.End_Date
from Schadule s join Room r on s.Room_FK=r.Room_Id 
join Employee e on s.Employee_FK_SSN=e.SSN
join Courses c on s.Course_FK=c.Course_id
End;

---------------------- search by code Teacher and day

Create Procedure SP_GetSchaduleBySSN @SSN bigint,@day varchar(10)
with encryption
As
Begin
select s.Days,r.Room_Name,e.FullName,c.Course_Name,s.Starts_Date,s.End_Date
from Schadule s join Room r on s.Room_FK=r.Room_Id 
join Employee e on s.Employee_FK_SSN=e.SSN
join Courses c on s.Course_FK=c.Course_id and s.Employee_FK_SSN=@SSN and s.Days=@day
End;


------------------------ All Employee and And departments --------------------


create Procedure SP_GetEmployee 
with encryption
As
Begin
select count(e.Emp_id),e.SSN,e.FullName,e.Phone,d.Type_Of_jop,e.Date_Of_Join,
e.degree_of_diplomats,e.Phone,e.Duration,e.Salary,e.Gender
from Employee e join Department d
on e.depart_ID=d.Depart_id
group by d.Type_Of_jop
End;



-------------------= Admins =--------------------
Create Procedure SP_GetAdmins
with encryption
As
Begin
select a.Admin_id,a.Code,a.UserName,a.Date_Of_creation
from Admin a 
End;


Create Procedure SP_GetAdminsByUserName @userName varchar(50) 
with encryption
As
Begin
select a.Admin_id,a.Code,a.UserName,a.Password,a.Date_Of_creation
from Admin a 
where a.UserName=@userName
End;
------------------------------ get All child that Attend today

Create Procedure SP_GetAttendance 
with encryption
As
Begin
select c.ID,c.Child_Code,h.ChildName,c.Attend
from Child_Attendance c join Child h
on c.Attend_Date=cast(GETDATE() as date)
End;

------------------------------ search about child Attend today

Create Procedure SP_Search_Child_Attendance @code bigint
with encryption
As
Begin
select c.Child_Code,h.ChildName,c.Attend,COUNT(c.Child_Code) as Number_days
from Child_Attendance c join Child h
on c.Child_Code=@code and c.Child_Code=h.Child_Code and c.Attend_Date=GETDATE()

End;

------------------ Take Attendance for child 
Create Procedure SP_Take_Attendance 
@code bigint,
@Attend bit
with encryption
As
Begin
Insert into Child_Attendance(Child_Code,Attend)
values(@Code,@Attend);
End;



/*Update Child_Attendance Data*/


 Create Procedure SP_Update_Child_Attendance 
 @code bigint,
@Attend bit,
@Attend_Date date,
@Attend_time time 
with encryption
As
Begin
Update Child_Attendance 
Set
Attend=@Attend,
Attend_Date=@Attend_Date,
Attend_time=@Attend_time 
where Child_Code=@code;
End;

--------------------- Delete one Child_Attendance by code

Create Procedure SP_DeleteChild_Attendance @code bigint
As
Begin
Delete From Child_Attendance Where Child_Code=@code;
End;


--------------------- Delete All data Child_Attendance 

Create Procedure SP_DeleteALLChild_Attendance
As
Begin
Delete From Child_Attendance 
End;


-------------------------------------= Recive Salary 
 
 -------------------- List Recive Salary This month

Create Procedure SP_GetReciveSalary @Month int
with encryption
As
Begin
select r.Emp_SSN,e.FullName,r.Salary,r.Bouns,
r.check_recive,r.Salary_Date,r.Salary_Time,r.Notes
from Recive_Salary r join Employee e 
on r.Date_month=@Month
End;

 -------------------- filter Recive Salary 

Create Procedure SP_FilterReciveSalary @Department_Id int
with encryption
As
Begin
select r.Emp_SSN,e.FullName,r.Salary,r.Bouns,
r.check_recive,r.Salary_Date,r.Salary_Time,d.Type_Of_jop,r.Notes
from Recive_Salary r join Employee e on r.Emp_SSN=e.SSN 
join Department d on e.depart_ID=d.Depart_id and d.Depart_id=@Department_Id
End;

 -------------------- search about Employee if Recive Salary by SSN 

Create Procedure SP_SearchReciveSalary @SSN bigint
with encryption
As
Begin
select r.Emp_SSN,e.FullName,r.Salary,r.Bouns,
r.check_recive,r.Salary_Date,r.Salary_Time,r.Notes
from Recive_Salary r join Employee e 
on r.Emp_SSN=e.SSN and  r.Emp_SSN=@SSN
End;

 -------------------- SP Recive Salary by SSN 

Create Procedure SP_TakeReciveSalary
@SSN bigint,
@Salary decimal(10,2),
@Bouns decimal(10,2),
@month int,
@Notes varchar(300)
with encryption
As
Begin
Insert into Recive_Salary(Emp_SSN,Salary,Bouns,Date_month,Notes)
values(@SSN,@Salary,@Bouns,@month,@Notes);
End;

---------------------- Update recive salary or not or take bouns



Create Procedure SP_UpdateReciveSalary
@SSN bigint,
@Salary decimal(10,2),
@Bouns decimal(10,2),
@check_Recive bit
As
Begin
Update Recive_Salary
Set Emp_SSN=@SSN,
Salary=@Salary,
Bouns=@Bouns
Where Emp_SSN=@SSN;
End;

--------------------- Delete one Recive_Salary by SSN

Create Procedure SP_Delete_Recive_Salary @SSN bigint
As
Begin
Delete From Recive_Salary Where Emp_SSN=@SSN
End;

--------------------- Delete All data in Recive_Salary

Create Procedure SP_Delete_ALLRecive_Salary 
As
Begin
Delete From Recive_Salary 
End;

--------------------------- List of Department 

Create Procedure SP_Department
with encryption
As
Begin
select d.Type_Of_jop
from Department d
End;




----------------------------= Accounting =----------------

---------------------------

CREATE PROCEDURE AddFees
    @value DECIMAL(20, 2),
	@bouns DECIMAL(20, 2),
    @date DATE,
    @type VARCHAR(50),
	@descrption VARCHAR(500)
AS
BEGIN
    INSERT INTO fees (value, Bouns,date, type,descrption)
    VALUES (@value,@bouns, @date, @type,@descrption);
END;
GO

CREATE PROCEDURE UpdateFees
    @id INT,
    @value DECIMAL(10, 2),
    @bouns DECIMAL(20, 2),
    @date DATE,
    @type VARCHAR(50),
	@descrption VARCHAR(500)
AS
BEGIN
    UPDATE fees
    SET value = @value,Bouns=@bouns, date = @date, type = @type,descrption=@descrption
    WHERE fees_Id = @id;
END;
GO

CREATE PROCEDURE DeleteFees
    @id INT
AS
BEGIN
    DELETE FROM fees
    WHERE fees_Id = @id;
END;
GO


CREATE PROCEDURE AddRevenues
    @value DECIMAL(20, 2),
	@bouns DECIMAL(20, 2),
    @date DATE,
    @type VARCHAR(50),
	@descrption VARCHAR(500)
AS
BEGIN
    INSERT INTO Revenues (value, Bouns,date, type,descrption)
    VALUES (@value,@bouns, @date, @type,@descrption);
END;
GO

CREATE PROCEDURE UpdateRevenue
    @id INT,
    @value DECIMAL(10, 2),
    @bouns DECIMAL(20, 2),
    @date DATE,
    @type VARCHAR(50),
	@descrption VARCHAR(500)
AS
BEGIN
    UPDATE Revenues
    SET value = @value,Bouns=@bouns, date = @date, type = @type,descrption=@descrption
    WHERE Revenue_Id = @id;
END;
GO



CREATE PROCEDURE DeleteRevenue
    @id INT
AS
BEGIN
    DELETE FROM Revenues
    WHERE Revenue_Id = @id;
END;
GO

-----------------------------= Insert Child And Parent =----------==================

CREATE PROCEDURE InsertChildAndParent
@Child_Code bigint,
@ChildName varchar(100),
@Child_Date Date,
@Gender varchar(30),
@Age int,
@Child_Address varchar(100),
@Child_Level int,
@Medical_Conditions varchar(100),
@EmergencyContactInformation varchar(200),
@AnySpecialNeedsORRequirement varchar(300),
@DataJoin date,
@Child_Photo image,
@Child_certificate image,
@Pay_Value decimal(10,3),
@Notes varchar(300),
@Room_Id int,
@CourseCollection varchar(30),
--------------------------------
@SSN bigint, 
@FullName Varchar(70),
@PhoneNumbers varchar(20),
@EmailAddress varchar(100),
@HomeAddress varchar(100),
@JopTitle varchar(100),
@WorkAddress varchar(100),
@WorkSchedule varchar(100),
@Additional_Notes varchar(500),
@Relationship_to_Child varchar(20)
AS
BEGIN
    DECLARE @SSN_Parent bigint;

  -- Insert into Parents table
Insert into Parents(SSN,FullName,PhoneNumbers,EmailAddress,HomeAddress,JopTitle,WorkAddress,WorkSchedule,Additional_Notes,Relationship_to_Child)
values(@SSN,@FullName,@PhoneNumbers,@EmailAddress,@HomeAddress,@JopTitle,@WorkAddress,@WorkSchedule,@Additional_Notes,@Relationship_to_Child);

    -- Get the ID of the newly inserted child
    SET @SSN_Parent = SCOPE_IDENTITY();

	  -- Insert into Children table
   insert into Child(Age,Child_Code,ChildName,Child_Date,Gender,Child_Level,Medical_Conditions,EmergencyContactInformation,AnySpecialNeedsORRequirement,DataJoin,Child_Photo,Child_certificate,Pay_Value,Notes,Parent_id,Room_Id,CourseCollection)
values(@Age,@Child_Code,@ChildName,@Child_Date,@Gender,@Child_Level,@Medical_Conditions,@EmergencyContactInformation,@AnySpecialNeedsORRequirement,@DataJoin,@Child_Photo,@Child_certificate,@Pay_Value,@Notes,@SSN_Parent,@Room_Id,@CourseCollection);
END;



-----------------------------= Insert Hosting Child And Hosting Parent =----------==================

CREATE PROCEDURE InsertHosting_ChildAndParent
---------------- child--------------
@Name varchar(30),
@ChildHosting_Code bigint,
@Address varchar(30),
@Medical_Condition varchar(300),
@Emergency_Contact varchar(50),
@Notes varchar(300),
@Date date,
@Hosting_date date,
@Gender varchar(10),
@Pay_value decimal(10,2),
@ChildHosting_Photo image,
@Date_Join DATETIME,
@Room_Id int,
-------------Parent-------------------
@SSN bigint,
@FullName varchar(30),
@PhoneNumber varchar(30),
@Email varchar(40),
@Jop_Tittle varchar(50),
@Work_Address varchar(40),
@Home_Address varchar(50),
@Additional_Notes varchar(300),
@Work_Schedule varchar(60),
@Relationship_to_Child varchar(50)
AS
BEGIN
    DECLARE @SSN_Parent bigint;

  -- Insert into Parents table

insert into ParentsHosting(SSN,FullName,PhoneNumber,Email,Jop_Tittle,Work_Address,Home_Address,Additional_Notes,Work_Schedule,Relationship_to_Child)
values(@SSN,@FullName,@PhoneNumber,@Email,@Jop_Tittle,@Work_Address,@Home_Address,@Additional_Notes,@Work_Schedule,@Relationship_to_Child);

    -- Get the ID of the newly inserted child
    SET @SSN_Parent = SCOPE_IDENTITY();

	  -- Insert into Children table
insert into ChildHosting(Name,ChildHosting_Code,Address,Medical_Condition,Emergency_Contact,Notes,Date,Hosting_date,Gender,Pay_value,ChildHosting_Photo,Date_Join,Room_Id,host_parent_id)
Values(@Name,@ChildHosting_Code,@Address,@Medical_Condition,@Emergency_Contact,@Notes,@Date,@Hosting_date,@Gender,@Pay_value,@ChildHosting_Photo,@Date_Join,@Room_Id,@SSN_Parent);
END;

------------------------------------------ Accounting

--------------------------------=  Calculate Total Fees

create PROCEDURE SP_CalculateTotalFees
    @total_fees DECIMAL(30, 2) OUTPUT
AS
BEGIN
    DECLARE @total_salaries DECIMAL(20, 2) = 0;
    DECLARE @total_materials DECIMAL(20, 2) = 0;
    DECLARE @Sum_Fees DECIMAL(20, 2) = 0;


    -- Sum all salaries
    SELECT @total_salaries = ISNULL(SUM(Salary), 0) 
    FROM Recive_Salary;

    -- Sum all material costs
    SELECT @total_materials = ISNULL(SUM(book_price), 0) 
    FROM Material;
	-- Sum Fees costs
    SELECT @Sum_Fees = ISNULL((SUM(Value)+SUM(Bouns)), 0) 
    FROM Fees;

    -- Calculate total fees
    SET @total_fees = @total_salaries + @total_materials+@Sum_Fees;
END
GO

-- Step 1: Declare the variable to hold the total fees
DECLARE @total_fees DECIMAL(30, 2);

-- Step 2: Call the procedure to calculate total fees
EXEC SP_CalculateTotalFees @total_fees OUTPUT;

-- Step 3: Select the total fees to display the result
SELECT @total_fees AS TotalFees;


----------------------------= Calculate Total Revenues

create PROCEDURE SP_CalculateTotalRevenues
    @total_Revenues DECIMAL(30, 2) OUTPUT
AS
BEGIN
     DECLARE @total_subscription DECIMAL(20, 2) = 0;
    DECLARE @total_Child DECIMAL(20, 2) = 0;
    DECLARE @total_HostingChild DECIMAL(20, 2) = 0;
    DECLARE	@Sum_Revenues DECIMAL(20, 2) = 0;

    -- Sum all subscription
    SELECT @total_subscription = ISNULL(SUM(Price), 0) 
    FROM Subscription;

    -- Sum all Child pay value
    SELECT @total_Child = SUM(Pay_Value) 
    FROM Child 
	where payORnot_payvalue='1';

	-- Sum all hosting Child pay value
    SELECT @total_HostingChild = ISNULL(SUM(Pay_Value), 0) 
    FROM ChildHosting ;
	-- Sum Revenues
    SELECT @Sum_Revenues = ISNULL((SUM(Value)+SUM(Bouns)), 0) 
    FROM Revenues ;

    -- Calculate total Revenues
    SET @total_Revenues =@total_subscription +@total_Child + @total_HostingChild+@Sum_Revenues;
END
GO

-- Step 1: Declare the variable to hold the total Revenues
DECLARE @total_Revenues DECIMAL(30, 2);

-- Step 2: Call the procedure to calculate total Revenues
EXEC SP_CalculateTotalRevenues @total_Revenues OUTPUT;

-- Step 3: Select the total Revenues to display the result
SELECT @total_Revenues AS TotalRevenues;

------------------------------------= Benfits =-------------------


create PROCEDURE SP_CalculateBenfits
    @total_Benfits DECIMAL(30, 2) OUTPUT
AS
BEGIN
     DECLARE @total_subscription DECIMAL(20, 2) = 0;
    DECLARE @total_Child DECIMAL(20, 2) = 0;
    DECLARE @total_HostingChild DECIMAL(20, 2) = 0;
    DECLARE	@Sum_Revenues DECIMAL(20, 2) = 0;
	DECLARE @total_Revenues DECIMAL(20, 2) = 0; 

	DECLARE @total_salaries DECIMAL(20, 2) = 0;
    DECLARE @total_materials DECIMAL(20, 2) = 0;
    DECLARE @Sum_Fees DECIMAL(20, 2) = 0;
	DECLARE @total_fees DECIMAL(20, 2) = 0;

    -- Sum all salaries
    SELECT @total_salaries = ISNULL(SUM(Salary), 0) 
    FROM Recive_Salary;

    -- Sum all material costs
    SELECT @total_materials = ISNULL(SUM(book_price), 0) 
    FROM Material;
	-- Sum Fees costs
    SELECT @Sum_Fees = ISNULL((SUM(Value)+SUM(Bouns)), 0) 
    FROM Fees;

    -- Calculate total fees
    SET @total_fees = @total_salaries + @total_materials+@Sum_Fees;
	------------------------------------------------------------------
    -- Sum all subscription
    SELECT @total_subscription = ISNULL(SUM(Price), 0) 
    FROM Subscription;

    -- Sum all Child pay value
    SELECT @total_Child = SUM(Pay_Value) 
    FROM Child 
	where payORnot_payvalue='1';

	-- Sum all hosting Child pay value
    SELECT @total_HostingChild = ISNULL(SUM(Pay_Value), 0) 
    FROM ChildHosting ;
	-- Sum Revenues
    SELECT @Sum_Revenues = ISNULL((SUM(Value)+SUM(Bouns)), 0) 
    FROM Revenues ;

    -- Calculate total Revenues
    SET @total_Revenues =@total_subscription +@total_Child + @total_HostingChild+@Sum_Revenues;

	  -- Calculate total Benfits
	    SET @total_Benfits =@total_Revenues-@total_Fees;

END
GO

-- Step 1: Declare the variable to hold the total Benfits
DECLARE @total_Benfits DECIMAL(30, 2);

-- Step 2: Call the procedure to calculate total Benfits
EXEC SP_CalculateBenfits @total_Benfits OUTPUT;

-- Step 3: Select the total Benfits to display the result
SELECT @total_Benfits AS TotalBenfits;


---------------------%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-------------------------------------- = Mohamed Saleh

----------------------- list category subscription

CREATE PROCEDURE SP_list_category_subscription
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ID, Name
    FROM Category_Subscription
    ORDER BY Name;
END;


CREATE PROCEDURE SP_list_Level
AS
BEGIN
    SET NOCOUNT ON;
    SELECT *
    FROM Level
    ORDER BY level_Name;
END;
 -- Stored Procedures for Material

-- Add
CREATE PROCEDURE SP_AddMaterial
    @book_name VARCHAR(50),
    @Copy_Count INT,
    @book_price DECIMAL(10,2),
    @Additional_Notes VARCHAR(700),
    @payORnot_Material BIT
AS
BEGIN
    INSERT INTO Material (book_name, Copy_Count, book_price, Additional_Notes, payORnot_Material)
    VALUES (@book_name, @Copy_Count, @book_price, @Additional_Notes, @payORnot_Material);
END;


-- Update
CREATE PROCEDURE SP_UpdateMaterial
    @Material_id INT,
    @book_name VARCHAR(50),
    @Copy_Count INT,
    @book_price DECIMAL(10,2),
    @Additional_Notes VARCHAR(700),
    @payORnot_Material BIT
AS
BEGIN
    UPDATE Material
    SET 
        book_name = @book_name,
        Copy_Count = @Copy_Count,
        book_price = @book_price,
        Additional_Notes = @Additional_Notes,
        payORnot_Material = @payORnot_Material
    WHERE Material_id = @Material_id;
END;


-- Delete
CREATE PROCEDURE SP_DeleteMaterial
    @Material_id INT
AS
BEGIN
    DELETE FROM Material
    WHERE Material_id = @Material_id;
END;

-- Select All
CREATE PROCEDURE SP_SelectAllMaterial
AS
BEGIN
    SELECT * FROM Material;
END;
--------------------------------------------
CREATE PROCEDURE SP_SearchMaterialByName
    @book_name VARCHAR(50)
AS
BEGIN
    SELECT * FROM Material
    WHERE book_name LIKE '%' + @book_name + '%';
END;


-- Select by ID

CREATE PROCEDURE SP_SelectMaterialByID
    @Material_id INT
AS
BEGIN
    SELECT * FROM Material
    WHERE Material_id = @Material_id;
END;

-- Stored Procedures for CourseCollection

-- Add
CREATE PROCEDURE SP_AddCourseCollection
    @Collection_Name VARCHAR(50),
    @Collection_description TEXT,
    @level_id INT,
    @Additional_Notes VARCHAR(300)
AS
BEGIN
    INSERT INTO CourseCollection (Collection_Name, Collection_description, level_id, Additional_Notes)
    VALUES (@Collection_Name, @Collection_description, @level_id, @Additional_Notes);
END;

-- Update
CREATE PROCEDURE SP_UpdateCourseCollection
    @Collection_id INT,
    @Collection_Name VARCHAR(50),
    @Collection_description TEXT,
    @level_id INT,
    @Additional_Notes VARCHAR(300)
AS
BEGIN
    UPDATE CourseCollection
    SET Collection_Name = @Collection_Name,
        Collection_description = @Collection_description,
        level_id = @level_id,
        Additional_Notes = @Additional_Notes
    WHERE Collection_id = @Collection_id;
END;

-- Delete
CREATE PROCEDURE SP_DeleteCourseCollection
    @Collection_id INT
AS
BEGIN
    DELETE FROM CourseCollection
    WHERE Collection_id = @Collection_id;
END;

-- Select All
CREATE PROCEDURE SP_SelectAllCourseCollection
AS
BEGIN
    SELECT * FROM CourseCollection;
END;
------------------------------------------------------------------
CREATE PROCEDURE SP_SearchCourseCollectionByName
    @Collection_Name VARCHAR(50)
AS
BEGIN
    SELECT * FROM CourseCollection
    WHERE Collection_Name LIKE '%' + @Collection_Name + '%';
END;

 

-- Select by ID
CREATE PROCEDURE SP_SelectCourseCollectionByID
    @Collection_id INT
AS
BEGIN
    SELECT * FROM CourseCollection
    WHERE Collection_id = @Collection_id;
END;

-- Stored Procedures for Courses

-- Add
CREATE PROCEDURE SP_AddCourse
     
    @Course_Name VARCHAR(50),
    @Range_Age VARCHAR(60),
    @Course_Description TEXT,
    @Grade_Course INT,
    @Additional_Notes VARCHAR(600),
    @book INT
AS
BEGIN
    INSERT INTO Courses (  Course_Name, Range_Age, Course_Description, Grade_Course, Additional_Notes, book)
    VALUES (  @Course_Name, @Range_Age, @Course_Description, @Grade_Course, @Additional_Notes, @book);
END;

-- Update
CREATE PROCEDURE SP_UpdateCourse
    @Course_id INT,
    @Collection_id INT,
    @Course_Name VARCHAR(50),
    @Range_Age VARCHAR(60),
    @Course_Description TEXT,
    @Grade_Course INT,
    @Additional_Notes VARCHAR(600),
    @book INT
AS
BEGIN
    UPDATE Courses
    SET Collection_id = @Collection_id,
        Course_Name = @Course_Name,
        Range_Age = @Range_Age,
        Course_Description = @Course_Description,
        Grade_Course = @Grade_Course,
        Additional_Notes = @Additional_Notes,
        book = @book
    WHERE Course_id = @Course_id;
END;

-- Delete
CREATE PROCEDURE SP_DeleteCourse
    @Course_id INT
AS
BEGIN
    DELETE FROM Courses
    WHERE Course_id = @Course_id;
END;

-- Select All
CREATE PROCEDURE SP_SelectAllCourses
AS
BEGIN
    SELECT * FROM Courses;
END;
---------------------------------------------------------------
CREATE PROCEDURE SP_SearchCourseByName
    @Course_Name VARCHAR(50)
AS
BEGIN
    SELECT * FROM Courses
    WHERE Course_Name LIKE '%' + @Course_Name + '%';
END;



-- Select by ID
CREATE PROCEDURE SP_SelectCourseByID
    @Course_id INT
AS
BEGIN
    SELECT * FROM Courses
    WHERE Course_id = @Course_id;
END;

-- Stored Procedures for Room

-- Add
CREATE PROCEDURE SP_AddRoom
    @Room_Name VARCHAR(50),
    @Room_Type VARCHAR(50),
    @Room_Rate DECIMAL(10,2),
    @Room_Capacity INT,
    @Room_Description VARCHAR(550),
    @Additional_Notes VARCHAR(600)
AS
BEGIN
    INSERT INTO Room (Room_Name, Room_Type, Room_Rate, Room_Capacity, Room_Description, Additional_Notes)
    VALUES (@Room_Name, @Room_Type, @Room_Rate, @Room_Capacity, @Room_Description, @Additional_Notes);
END;

-- Update
CREATE PROCEDURE SP_UpdateRoom
    @Room_Id INT,
    @Room_Name VARCHAR(50),
    @Room_Type VARCHAR(50),
    @Room_Rate DECIMAL(10,2),
    @Room_Capacity INT,
    @Room_Description VARCHAR(550),
    @Additional_Notes VARCHAR(600)
AS
BEGIN
    UPDATE Room
    SET Room_Name = @Room_Name,
        Room_Type = @Room_Type,
        Room_Rate = @Room_Rate,
        Room_Capacity = @Room_Capacity,
        Room_Description = @Room_Description,
        Additional_Notes = @Additional_Notes
    WHERE Room_Id = @Room_Id;
END;

-- Delete
CREATE PROCEDURE SP_DeleteRoom
    @Room_Id INT
AS
BEGIN
    DELETE FROM Room
    WHERE Room_Id = @Room_Id;
END;

-- Select All
CREATE PROCEDURE SP_SelectAllRooms
AS
BEGIN
    SELECT * FROM Room;
END;
--------------------------------
CREATE PROCEDURE SP_GetRoomsWithStudentCount
AS
BEGIN
    SELECT 
        r.Room_Id,
        r.Room_Name,
        r.Room_Type,
        r.Room_Rate,
        r.Room_Capacity,
        r.Room_Description,
        r.Additional_Notes,
        COUNT(c.Child_Id) AS NumberOfStudents
    FROM 
        Room r
    LEFT JOIN 
        Child c ON r.Room_Id = c.Room_Id
    GROUP BY 
        r.Room_Id,
        r.Room_Name,
        r.Room_Type,
        r.Room_Rate,
        r.Room_Capacity,
        r.Room_Description,
        r.Additional_Notes;
END;
------------------------------

------------------------------ get All Employee that Attend today

Create Procedure SP_GetAttendance_Employee
with encryption
As
Begin
select a.ID,a.SSN,e.FullName,a.Attend
from Employee_Attendance a join Employee e
on a.Attend_Date=cast(GETDATE() as date)
End;

------------------------------ search about Employee Attend today

Create Procedure SP_Search_Employee_Attendance @SSn bigint
with encryption
As
Begin
select a.SSN,e.FullName,a.Attend,COUNT(a.SSN) as Number_days
from Employee_Attendance a join Employee e
on a.SSN=@SSn and a.SSN=e.SSN and a.Attend_Date=GETDATE()
 GROUP BY 
        a.SSN,
        e.FullName,
        a.Attend
End;

------------------ Take Attendance for Employee 
Create Procedure SP_Take_Attendance_Employee
@SSn bigint,
@Attend bit
with encryption
As
Begin
Insert into Employee_Attendance(SSN,Attend)
values(@SSn,@Attend);
End;


---------------------------------
 
--------------------------------------------------------------
-------------------------------------
 
 CREATE PROCEDURE SP_AddRevenue
    @Type varchar(30),
    @Value decimal(10,2),
    @Bouns decimal(10,2),
    @Revenue_Date date,
    @Revenue_time time,
    @descrption varchar(200)
AS
BEGIN
    INSERT INTO Revenues (Type, Value, Bouns, Revenue_Date, Revenue_time, descrption)
    VALUES (@Type, @Value, @Bouns, @Revenue_Date, @Revenue_time, @descrption);
END;

CREATE PROCEDURE SP_UpdateRevenue
    @Revenue_Id int,
    @Type varchar(30),
    @Value decimal(10,2),
    @Bouns decimal(10,2),
    @Revenue_Date date,
    @Revenue_time time,
    @descrption varchar(200)
AS
BEGIN
    UPDATE Revenues
    SET Type = @Type,
        Value = @Value,
        Bouns = @Bouns,
        Revenue_Date = @Revenue_Date,
        Revenue_time = @Revenue_time,
        descrption = @descrption
    WHERE Revenue_Id = @Revenue_Id;
END;

CREATE PROCEDURE SP_DeleteRevenue
    @Revenue_Id int
AS
BEGIN
    DELETE FROM Revenues
    WHERE Revenue_Id = @Revenue_Id;
END;

CREATE PROCEDURE SP_AddFee
    @Type varchar(30),
    @Value decimal(10,2),
    @Bouns decimal(10,2),
    @Revenue_Date date,
    @Revenue_time time,
    @descrption varchar(200)
AS
BEGIN
    INSERT INTO Fees (Type, Value, Bouns, Revenue_Date, Revenue_time, descrption)
    VALUES (@Type, @Value, @Bouns, @Revenue_Date, @Revenue_time, @descrption);
END;


CREATE PROCEDURE SP_UpdateFee
    @Revenue_Id int,
    @Type varchar(30),
    @Value decimal(10,2),
    @Bouns decimal(10,2),
    @Revenue_Date date,
    @Revenue_time time,
    @descrption varchar(200)
AS
BEGIN
    UPDATE Fees
    SET Type = @Type,
        Value = @Value,
        Bouns = @Bouns,
        Revenue_Date = @Revenue_Date,
        Revenue_time = @Revenue_time,
        descrption = @descrption
    WHERE Revenue_Id = @Revenue_Id;
END;

CREATE PROCEDURE SP_DeleteFees
    @Revenue_Id int
AS
BEGIN
    DELETE FROM Fees
    WHERE Revenue_Id = @Revenue_Id;
END;

--------------------------%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5555
----------------------------------= Hamada =--------------------------


/*Get All Categories in Subscription*/
Create Procedure SP_GetAllCategoriesInSubscription
As
Begin
Select * From Category_Subscription
End;

exec SP_GetAllCategoriesInSubscription;

/*Get All Children Subscription*/
Create Procedure SP_GetAllChildSubscription
As
Begin
Select * 
From Child c join Child_Subscriptions cs
on c.Child_Code=cs.Child_Id join Subscription s on cs.Sub_id=s.Sub_id
End;

/*Get All Child*/
Create Procedure SP_GetAllChild
As
Begin
Select * From Child
End;

exec SP_GetAllChild;

/*Get All Child Hosting*/
Create Procedure SP_GetAllChildHosting
As
Begin
Select * From ChildHosting
End;

exec SP_GetAllChildHosting;


/*Get All Parents*/
Create Procedure SP_GetAllParents
As
Begin
Select * From Parents
End;

Exec SP_GetAllParents;


/*Get All Parents Hosting*/
Create Procedure SP_GetAllParentsHosting
As
Begin
Select * From ParentsHosting
End;

exec SP_GetAllParentsHosting;


/*Get All Subscriptions*/
Create Procedure SP_GetAllSubscriptions
As
Begin
Select * From Subscription
End;



--/*Add Parent*/
--Create Procedure SP_AddParent
--@SSN bigint, 
--@FullName Varchar(70),
--@PhoneNumbers varchar(20),
--@EmailAddress varchar(100),
--@HomeAddress varchar(100),
--@JopTitle varchar(100),
--@WorkAddress varchar(100),
--@WorkSchedule varchar(100),
--@Additional_Notes varchar(500),
--@Relationship_to_Child varchar(20)
--As
--Begin
--Insert into Parents(SSN,FullName,PhoneNumbers,EmailAddress,HomeAddress,JopTitle,WorkAddress,WorkSchedule,Additional_Notes,Relationship_to_Child)
--values(@SSN,@FullName,@PhoneNumbers,@EmailAddress,@HomeAddress,@JopTitle,@WorkAddress,@WorkSchedule,@Additional_Notes,@Relationship_to_Child);
--End;


/*Update Parent Data*/

 Create Procedure SP_UpdateParents
@SSN bigint, 
@FullName Varchar(70),
@PhoneNumbers varchar(20),
@EmailAddress varchar(100),
@HomeAddress varchar(100),
@JopTitle varchar(100),
@WorkAddress varchar(100),
@WorkSchedule varchar(100),
@Additional_Notes varchar(500),
@Relationship_to_Child varchar(20)
As
Begin
Update Parents
Set
FullName=@FullName,
PhoneNumbers=@PhoneNumbers,
EmailAddress=@EmailAddress,
HomeAddress=@HomeAddress,
JopTitle=@JopTitle,
WorkAddress=@WorkAddress,
WorkSchedule=@WorkSchedule,
Additional_Notes=@Additional_Notes,
Relationship_to_Child=@Relationship_to_Child
where SSN=@SSN;
End;

/*Delete Parent*/
Create Procedure SP_DeleteParents
@SSN bigint
As
Begin 
Delete From Child where Parent_id=@SSN;
Delete From Parents Where SSN=@SSN;
End;


--/*Add Parent Hosting*/
--Create Procedure SP_HostParent
--@SSN bigint,
--@FullName varchar(30),
--@PhoneNumber varchar(30),
--@Email varchar(40),
--@Jop_Tittle varchar(50),
--@Work_Address varchar(40),
--@Home_Address varchar(50),
--@Additional_Notes varchar(300),
--@Work_Schedule varchar(60),
--@Relationship_to_Child varchar(50)
--As
--Begin
--insert into ParentsHosting(SSN,FullName,PhoneNumber,Email,Jop_Tittle,Work_Address,Home_Address,Additional_Notes,Work_Schedule,Relationship_to_Child)
--values(@SSN,@FullName,@PhoneNumber,@Email,@Jop_Tittle,@Work_Address,@Home_Address,@Additional_Notes,@Work_Schedule,@Relationship_to_Child);
--End;


/*Update Parent Hosting*/
Create Procedure SP_UpdateHostParents

@SSN bigint,
@FullName varchar(30),
@PhoneNumber varchar(30),
@Email varchar(40),
@Jop_Tittle varchar(50),
@Work_Address varchar(40),
@Home_Address varchar(50),
@Additional_Notes varchar(300),
@Work_Schedule varchar(60),
@Relationship_to_Child varchar(50)
As
Begin
Update ParentsHosting
Set 
FullName=@FullName,
PhoneNumber=@PhoneNumber,
Email=@Email,
Jop_Tittle=@Jop_Tittle,
Work_Address=@Work_Address,
Home_Address=@Home_Address,
Additional_Notes=@Additional_Notes,
Work_Schedule=@Work_Schedule,
Relationship_to_Child=@Relationship_to_Child
Where SSN=@SSN;
End;


/*Delete Host Parent*/
Create Procedure SP_DeleteHostParents
@SSN bigint
As
Begin
Delete From ChildHosting Where host_parent_id=@SSN;
Delete From ParentsHosting Where SSN=@SSN;
End;


/*Add ChildHosting*/
Create Procedure SP_AddChildHost
@Name varchar(30),
@ChildHosting_Code bigint,
@Address varchar(30),
@Medical_Condition varchar(300),
@Emergency_Contact varchar(50),
@Notes varchar(300),
@Date date,
@Hosting_date date,
@Gender varchar(10),
@Pay_value decimal(10,2),
@ChildHosting_Photo image,
@Date_Join DATETIME,
@Room_Id int,
@host_parent_id bigint
As
Begin 
insert into ChildHosting(Name,ChildHosting_Code,Address,Medical_Condition,Emergency_Contact,Notes,Date,Hosting_date,Gender,Pay_value,ChildHosting_Photo,Date_Join,Room_Id,host_parent_id)
Values(@Name,@ChildHosting_Code,@Address,@Medical_Condition,@Emergency_Contact,@Notes,@Date,@Hosting_date,@Gender,@Pay_value,@ChildHosting_Photo,@Date_Join,@Room_Id,@host_parent_id);
End;

/*Update Child Host*/
CREATE PROCEDURE SP_UpdateChildHost
    @Child_id int,
    @Name varchar(30),
    @ChildHosting_Code bigint,
    @Address varchar(30),
    @Medical_Condition varchar(300),
    @Emergency_Contact varchar(50),
    @Notes varchar(300),
    @Date date,
    @Hosting_date date,
    @Gender varchar(10),
    @Pay_value decimal(10,2),
    @ChildHosting_Photo image,
    @Date_Join DATETIME,
    @Room_Id int,
    @host_parent_id bigint
AS
BEGIN
    UPDATE ChildHosting
    SET 
        Name = @Name,
        ChildHosting_Code = @ChildHosting_Code,
        Address = @Address,
        Medical_Condition = @Medical_Condition,
        Emergency_Contact = @Emergency_Contact,
        Notes = @Notes,
        Date = @Date,
        Hosting_date = @Hosting_date,
        Gender = @Gender,
        Pay_value = @Pay_value,
        ChildHosting_Photo = @ChildHosting_Photo,
        Date_Join = @Date_Join,
        Room_Id = @Room_Id,
        host_parent_id = @host_parent_id
    WHERE Child_id = @Child_id;
END;

/*Delete Child Host*/
Create Procedure SP_DeleteHostChild
@Child_id int
As
Begin
Delete From ChildHosting Where Child_id=@Child_id;
End;

/*Add Child */
Create Procedure SP_AddChild
@Child_Id int,
@Age int,
@Child_Code bigint,
@ChildName varchar(100),
@Child_Date Date,
@Gender varchar(30),
@Child_Address varchar(100),
@Child_Level int,
@Medical_Conditions varchar(100),
@EmergencyContactInformation varchar(200),
@AnySpecialNeedsORRequirement varchar(300),
@DataJoin date,
@Child_Photo image,
@Child_certificate image,
@Pay_Value decimal(10,3),
@Notes varchar(300),
@Parent_id bigint,
@Room_Id int,
@CourseCollection varchar(30)
As
Begin 
insert into Child(Child_Id,Age,Child_Code,ChildName,Child_Date,Gender,Child_Level,Medical_Conditions,EmergencyContactInformation,AnySpecialNeedsORRequirement,DataJoin,Child_Photo,Child_certificate,Pay_Value,Notes,Parent_id,Room_Id,CourseCollection)
values(@Child_Id,@Age,@Child_Code,@ChildName,@Child_Date,@Gender,@Child_Level,@Medical_Conditions,@EmergencyContactInformation,@AnySpecialNeedsORRequirement,@DataJoin,@Child_Photo,@Child_certificate,@Pay_Value,@Notes,@Parent_id,@Room_Id,@CourseCollection);
End;

/*Update Child*/
Create Procedure SP_UpdateChild
@Child_Code bigint,
@ChildName varchar(100),
@Child_Date Date,
@Gender varchar(30),
@Child_Address varchar(100),
@Child_Level int,
@Medical_Conditions varchar(100),
@EmergencyContactInformation varchar(200),
@AnySpecialNeedsORRequirement varchar(300),
@DataJoin date,
@Child_Photo image,
@Child_certificate image,
@Pay_Value decimal(10,3),
@Notes varchar(300),
@Parent_id bigint,
@Room_Id int,
@Age int,
@CollectionCourse varchar(30)
As
Begin 
Update Child 
Set 
Child_Code=@Child_Code,
ChildName=@ChildName,
Gender=@Gender,
Child_Date=@Child_Date,
Child_Level=@Child_Level,
Child_Address=@Child_Address,
Medical_Conditions=@Medical_Conditions,
EmergencyContactInformation=@EmergencyContactInformation,
AnySpecialNeedsORRequirement=@AnySpecialNeedsORRequirement,
DataJoin=@DataJoin,
Child_Photo=@Child_Photo,
Child_certificate=@Child_certificate,
Pay_Value=@Pay_Value,
Notes=@Notes,
Parent_id=@Parent_id,
Room_Id=@Room_Id,
Age=@Age,
CourseCollection=@CollectionCourse
where Child_Code=@Child_Code;
End;


/*Delete Child*/
CREATE PROCEDURE SP_DeleteChild
    @Child_Code bigint
AS
BEGIN
    DELETE FROM Child
    WHERE Child_Code = @Child_Code;
END;


/*Add Subscription*/
Create Procedure SP_AddSubs
@Sub_id int,
@Name varchar(30),
@Price decimal(10,3),
@Location varchar(30),
@Description varchar(300),
@Additional_Notes varchar(400),
@Category_FK int
As
Begin
insert into Subscription(Sub_id,Name,Price,Location,Description,Additional_Notes,Category_FK)
values(@Sub_id,@Name,@Price,@Location,@Description,@Additional_Notes,@Category_Fk);
End;

/*Update Subscription*/
Create Procedure SP_UpdateSubscription
@Sub_id int,
@Name varchar(30),
@Price decimal(10,3),
@Location varchar(30),
@Description varchar(300),
@Additional_Notes varchar(400)
As
Begin
Update Subscription
Set Name=@Name,
Price=@Price,
Location=@Location,
Description=@Description,
Additional_Notes=@Additional_Notes
where Sub_id=@Sub_id;
End;

/*Delete Sub*/
Create Procedure SP_DeleteSubs
@Sub_id int
As
Begin
Delete From Child_Subscriptions Where Sub_id=@Sub_id;
Delete From Subscription Where Sub_id=@Sub_id;
End;


/*Search For Parent by SSN*/
Create Procedure SP_SearchParentsBySSN
(
@SSN bigint
)
As
Begin
Select *
From Parents
Where SSN=@SSN;
End;

/*Search For Parent by name*/
Create Procedure SP_SearchParentsByName
(
@Name Varchar(70)
)
As
Begin
Select *
From Parents
Where FullName=@Name;
End;

/*Search For Child By Code*/
Create Procedure SP_SearchChildBySSN
(
@Code bigint
)
As
Begin
Select *
From Child
Where Child_Code=@Code;
End;

/*Search For Child By name*/
Create Procedure SP_SearchChildByName
(
@ChildName Varchar(30)
)
As
Begin
Select *
From Child
Where ChildName=@ChildName;
End;



/*Search For Parent Hosting by SSN*/
Create Procedure SP_SearchParentsHostingBySSN
(
@SSN bigint
)
As
Begin
Select *
From ParentsHosting
Where SSN=@SSN;
End;

/*Search For Parent Hosting by name*/
Create Procedure SP_SearchParentsHostingByName
(
@Name Varchar(70)
)
As
Begin
Select *
From ParentsHosting
Where FullName=@Name;
End;

/*Search For Child Hosting By Date_Join */
Create Procedure SP_SearchChildHostingBySSN
(
@DateJoin date
)
As
Begin
Select *
From ChildHosting
Where Date_Join=@DateJoin;
End;

/*Search For Child Hosting By name*/
Create Procedure SP_SearchChildHostingByName
(
@ChildName Varchar(30)
)
As
Begin
Select *
From ChildHosting
Where Name=@ChildName;
End;

/*Search Subscription By Name*/
Create Procedure SP_SearchSubscriptionByName
(
@Name varchar(30)
)
As
Begin
Select * 
From Subscription
Where Name=@Name;
End;

/*Search For Child By Age*/
Create Procedure SP_SearchForChildByAge
(
@Age int
)
As
Begin
Select * From Child
Where Age=@Age;
End;





