----------------------- Mahmoud Sherif 
-------------------------------= Filter Recive Salary by Date

Create Procedure SP_FilterReciveSalaryDate @Date date
with encryption
As
Begin
select r.Emp_SSN,e.FullName,r.Salary,r.Bouns,
r.check_recive,r.Salary_Date,r.Salary_Time,d.Type_Of_jop,r.Notes
from Recive_Salary r join Employee e on r.Emp_SSN=e.SSN 
join Department d on e.depart_ID=d.Depart_id and r.Salary_Date=@Date
End;


-----------------------= Filter Employee by type of jop

create Procedure SP_FilterEmployeeType_jop @D_Id int
with encryption
As
Begin
select e.SSN,e.FullName,e.Phone,d.Type_Of_jop,e.Date_Of_Join,
e.degree_of_diplomats,e.Phone,e.Duration,e.Salary,e.Gender,e.Email,e.photo,e.Qualification
from Employee e join Department d
on e.depart_ID=d.Depart_id and e.depart_ID=@D_Id
End;


---------------------------------------= filter child attendance by age today

Create Procedure SP_Search_Child_Attendance @age1 int ,@age2 int
with encryption
As
Begin
select c.Child_Code,h.ChildName,c.Attend,h.Age,COUNT(h.ChildName) as number_Days
from Child_Attendance c join Child h
on c.Age>@age1 and c.Age<@age2 and c.Attend_Date=cast(getdate() as date)
End;


---------------------------------------= filter child attendance spical day

Create Procedure SP_Attendance_SpicalDay @day date
with encryption
As
Begin
select c.ID,c.Child_Code,h.ChildName,c.Attend,h.Age,COUNT(h.ChildName) as number_Days
from Child_Attendance c join Child h
on c.Attend_Date=@day 
End;

--------==============================================
--------------------------------= Mohamed Saleh =-----------


CREATE PROCEDURE SP_FilterCourseCollection
    @search_term VARCHAR(50) = NULL,
    @desired_level_id INT = NULL
AS
BEGIN
    SELECT *
    FROM CourseCollection
    WHERE (@search_term IS NULL OR @search_term = '' OR Collection_Name LIKE '%' + @search_term + '%')
    AND (@desired_level_id IS NULL OR level_id = @desired_level_id)
   ORDER BY Collection_Name, level_id;
END;

--------------- Filter materal--------
CREATE PROCEDURE SP_FilterMaterials
    @book_name VARCHAR(50) = NULL, 
    @max_book_price DECIMAL(10,2) = NULL
AS
BEGIN
    SELECT *
    FROM Material
    WHERE (@book_name IS NULL OR @book_name = '' OR book_name LIKE '%' + @book_name + '%')
    AND (@max_book_price IS NULL OR book_price <= @max_book_price)
    ORDER BY book_name, book_price;
END;

---------------course-----------
CREATE PROCEDURE SP_FilterCourses
    @collection_name VARCHAR(50) = NULL,
    @course_name VARCHAR(50) = NULL
AS
BEGIN
    SELECT c.*
    FROM Courses c
    JOIN CourseCollection cc ON c.Collection_id = cc.Collection_id
    WHERE (@collection_name IS NULL OR @collection_name = '' OR cc.Collection_Name LIKE '%' + @collection_name + '%')
    AND (@course_name IS NULL OR @course_name = '' OR c.Course_Name LIKE '%' + @course_name + '%')
    ORDER BY c.Course_Name ,c.Collection_id ;
END;

------------------------


---------------------------------------= filter Employee attendance spical day

Create Procedure SP_Attendance_Employee_SpicalDay @day date
with encryption
As
Begin
select c.ID,c.SSN,h.FullName,c.Attend,COUNT(h.FullName) as number_Days
from Employee_Attendance c join Employee h
on c.Attend_Date=@day 
 GROUP BY 
        c.ID,
        c.SSN,
        h.FullName,
        c.Attend;
End;



---------------------------------------= filter Employee attendance by type of jop today

 
CREATE PROCEDURE SP_Filter_Employee_TypeofJop_Attendance
    @D_Id int
WITH ENCRYPTION
AS
BEGIN
    SELECT 
        a.SSN,
        e.FullName,
        a.Attend,
		
        COUNT(e.FullName) AS number_Days
    FROM 
        Employee_Attendance a
    JOIN 
        Employee e ON a.SSN = e.SSN
    
    WHERE 
        a.Attend_Date = CAST(GETDATE() AS DATE)
        AND e.depart_ID = @D_Id
    GROUP BY 
        a.SSN,
        e.FullName,
        a.Attend;
END;

EXEC SP_Filter_Employee_TypeofJop_Attendance
    @D_Id =1;





--========================######################################
------------------------Hamada----------------------

Create Procedure SP_FilterEmployeebySSN
(
@SSN bigint
)
As
Begin
Select * From Employee
Where SSN=@SSN;
End;
/*Filter Subscription By Name*/
Create Procedure SP_FilterSubByName
(
@Name Varchar(30)
)
As
Begin
Select * From Subscription
Where Name=@Name;
End;

/*Filter Employee by Name*/
Create Procedure SP_FilterEmployeesByName
(
@FullName Varchar(50)
)
As
Begin
Select * From Employee
Where FullName=@FullName;
End;

/*Filter Employee by Emp_date*/
Create Procedure SP_FilterEmployeesByEmpDate
(
@Emp_Date Date
)
As
Begin
Select * From Employee
Where Emp_Date=@Emp_Date;
End;

/*Filter Schedule By Days*/
Create Procedure SP_FilterScheduleByDays
(
@Days varchar(10)
)
As
Begin
Select * From Schadule
Where Days=@Days;
End;

/*filter Schedule by date*/

/*Filter Child By Code*/
Create Procedure SP_FilterChildByCode
(
@Code bigint
)
As
Begin
Select * From Child
Where Child_Code=@Code;
End;

/*Filter Child By Name*/
Create Procedure SP_FilterChildByName
(
@FullName Varchar(100)
)
As
Begin
Select * From Child
where ChildName=@FullName;
End;

/*Filter Child By date*/
Create Procedure SP_FilterChildByDate
(
@Date date
)
As
Begin
Select * From Child
Where Child_Date=@Date;
End;

/*Filter Parents By SSN*/
Create Procedure SP_FilterParentsBySSN
(
@SSN Bigint
)
As
Begin
Select * From Parents
Where SSN=@SSN;
End;

/*Filter Parents By Name*/
Create Procedure SP_FilterParentsByName
(
@Name Varchar(70)
)
As
Begin
Select * From Parents
Where FullName=@Name;
End;

/*Filter Department*/
Create Procedure SP_FilterDapartmentByJop
(
@Jop varchar(20)
)
As
Begin
Select * From Department
Where Type_Of_jop=@Jop;
End;

/*Filter Levels By Name*/
Create Procedure SP_FilterLevelsByName
(
@Level_Name varchar(30)
)
As
Begin
Select * From Level
Where level_Name=@Level_Name;
End;

/*Filter Materials By Name*/
Create Procedure SP_FiltermaterialsByName
(
@Book_Name Varchar(30)
)
As
Begin
Select * From Material
Where book_name=@Book_Name;
End;

/*Filter Category Subscriptions*/
Create Procedure SP_FilterCategoriesSubscription
(
@Name varchar(20)
)
As
Begin
Select * From Category_Subscription
Where Name=@Name;
End;

/*Filter Employee Attendance*/
Create Procedure SP_FilterEmployeeAttendance
(
@SSN bigint
)
As
Begin
Select * From Employee_Attendance
Where SSN=@SSN;
End;

/*Filter Employee Attendance*/
Create Procedure SP_FilterEmployeeAttendanceByName
(
@Fullname Varchar(30)
)
As
Begin
Select * From Employee_Attendance
Where FullName=@Fullname;
End;

/*Filter Room By Name*/
Create Procedure Sp_FilterRoomByName
(
@Room_name Varchar(50)
)
As
Begin
Select * From Room
Where Room_Name=@Room_name;
End;

/*Filter Room By Type*/
Create Procedure SP_FilterByType
(
@Room_type varchar(50)
)
As
Begin
Select * From Room
Where Room_Type=@Room_type;
End;

/*Filter Parents Hosting */
Create Procedure SP_FilterParentsHostingBySSN
(
@SSN Bigint
)
As
Begin
Select * From ParentsHosting
Where SSN=@SSN;
End;

/*Filter Parents Hosting*/
Create Procedure SP_FilterParentsHostingByName
(
@Name Varchar(70)
)
As
Begin
Select * From ParentsHosting
Where FullName=@Name;
End;

/*Filter Child By Code*/
Create Procedure SP_FilterChildHostingByCode
(
@Code bigint
)
As
Begin
Select * From Child
Where Child_Code=@Code;
End;

/*Filter Child Hosting By Name*/
Create Procedure SP_FilterChildHostingByName
(
@FullName Varchar(100)
)
As
Begin
Select * From Child
where ChildName=@FullName;
End;

/*Filter Child Hosting By date*/
Create Procedure SP_FilterChildHostingByDate
(
@Date date
)
As
Begin
Select * From Child
Where Child_Date=@Date;
End;

/*Filter Courses Collection by level_id*/
Create Procedure SP_FilterCourseCollectionByLevel
(
@Level_id int
)
As
Begin
Select * From CourseCollection
Where level_id=@Level_id;
End;

/*Filter Courses By Name*/
Create Procedure SP_FilterCoursesByName
(
@name Varchar(30)
)
As
Begin 
Select * From Courses
Where Course_Name=@name;
End;


/*Filter Child By Age*/
Create Procedure SP_FilterChildByAge
(
@Age int 
)
As
Begin 
Select * From Child
Where Age=@Age;
End;






