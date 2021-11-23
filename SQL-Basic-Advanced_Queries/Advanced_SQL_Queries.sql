use [SQL Tutorial]

/*
CTE: Common Table Expression
*/

WITH CTE_Employee as 
(Select FirstName, LastName, Gender, Salary
, COUNT(gender) over (Partition by Gender) as TotalGender
, AVG(Salary) over (Partition by Gender) as AvgSalary
from [SQL Tutorial]..EmployeeDemographics emp
join [SQL Tutorial]..EmployeeSalary sal
	on emp.EmployeeID = sal.EmployeeID
where Salary >'45000'
)

Select *
from CTE_Employee


/*
Temp Tables
*/

Create table #temp_Employee (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

Select *
from #temp_Employee

Insert into #temp_Employee Values (
'1001', 'HR', '45000'
)

-- Inserting data from another table into a "temp table"
Insert into #temp_Employee
Select *
from [SQL Tutorial]..EmployeeSalary

-- We can use temp tables to store data based on certian operations like joins, window functions etc

Drop Table IF EXISTS #temp_Employee2 
-- without the above line there will be an error as the temp table would aready exist after the right run.
Create table #temp_Employee2 (
JobTitle varchar(50),
EmployeePerJob int,
AvgAge int,
AvgSalary int)

Insert into #temp_Employee2
Select JobTitle, COUNT(JobTitle), AVG(AGE), AVG(Salary)
from [SQL Tutorial]..EmployeeDemographics emp
join [SQL Tutorial]..EmployeeSalary sal
	on emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select *
from #temp_Employee2


/*
String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower
*/

Drop Table if exists EmployeeErrors

Create Table EmployeeErrors (
EmployeeID varchar(50),
FirstName varchar(50),
LastName varchar(50)
)

Insert into EmployeeErrors values
('1001 ', 'Jimbo', 'Halbert'),
(' 1002', 'Pamela', 'Beasely'),
('1005', 'TOby', 'Flenderson - Fired')

Select *
from EmployeeErrors

-- TRIM, LTRIM, RTRIM

Select EmployeeID, TRIM(EmployeeID) as IDTRIM
from EmployeeErrors

Select EmployeeID, LTRIM(EmployeeID) as IDLTRIM
from EmployeeErrors

Select EmployeeID, RTRIM(EmployeeID) as IDRTRIM
from EmployeeErrors

-- Replace
Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
from EmployeeErrors

-- Substring
Select SUBSTRING(FirstName,3,3)
from EmployeeErrors

-- Fuzzy Matching (SubString)
Select err.FirstName ,SUBSTRING(err.FirstName,1,3), emp.FirstName, SUBSTRING(emp.FirstName,1,3)
from EmployeeErrors err
join EmployeeDemographics emp
	on SUBSTRING(err.FirstName,1,3) = SUBSTRING(emp.FirstName,1,3)

-- Typically Fuzzy Matching is performed on:
-- 1. Gender
-- 2. LastName
-- 3. Age
-- 4. DOB

-- Upper and Lower
Select FirstName, LOWER(FirstName)
from EmployeeErrors

Select FirstName, UPPER(FirstName)
from EmployeeErrors

/*
Stored Procedures
*/

Create Procedure Test
as
Select *
from EmployeeDemographics

Exec Test

Drop Procedure if exists Temp_Employee

Create Procedure Temp_Employee
@JobTitle nvarchar(100)
As
Create table #temp_Employee3 (
JobTitle varchar(50),
EmployeePerJob int,
AvgAge int,
AvgSalary int)

Insert into #temp_Employee3
Select JobTitle, COUNT(JobTitle), AVG(AGE), AVG(Salary)
from [SQL Tutorial]..EmployeeDemographics emp
join [SQL Tutorial]..EmployeeSalary sal
	on emp.EmployeeID = sal.EmployeeID
where JobTitle = @JobTitle
group by JobTitle

Select *
from #temp_Employee3

Exec Temp_Employee @JobTitle = 'Salesman'


/*
Subqueries
*/

Select *
from EmployeeSalary

-- Subquery in Select
Select EmployeeID, Salary, (Select AVG(Salary) from EmployeeSalary) As AllAvgSalary
from EmployeeSalary

-- Subquery using Partition By
Select EmployeeID, Salary, AVG(Salary) over () As AllAvgSalary
from EmployeeSalary

-- Why Group by Doesn't Works for Subquery
Select EmployeeID, Salary, AVG(Salary) As AllAvgSalary
from EmployeeSalary
group by EmployeeID, Salary
order by 1,2
-- using the above query we didn't get the avg. salary that we obtained in the select and partion by queries

-- Subquery in Form
Select a.EmployeeID, AllAvgSalary
from (Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
	  from EmployeeSalary) a

-- Subquery in Where
Select EmployeeID, JobTitle, Salary
from EmployeeSalary
where EmployeeID in (
		Select EmployeeID -- we can select only one column
		from EmployeeDemographics
		where Age > 30)