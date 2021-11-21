/*
This query text was retrieved from showplan XML, and may be truncated.
*/

/*
Inner Joins, Full/Left/Right Outer Joins
*/

Select *
from EmployeeDemographics
Select *
from EmployeeSalary
-- Inner Join

Select *
from [SQL Tutorial].dbo.EmployeeDemographics
Inner Join [SQL Tutorial].dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- Full Outer Join

Select *
from [SQL Tutorial].dbo.EmployeeDemographics
Full Outer Join [SQL Tutorial].dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- Left Outer Join

Select *
from [SQL Tutorial].dbo.EmployeeDemographics
Left Outer Join [SQL Tutorial].dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- Right Outer Join

Select *
from [SQL Tutorial].dbo.EmployeeDemographics
Right Outer Join [SQL Tutorial].dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--USE CASE: To Find Highest Paying Employee Apart from Michael
Select EmployeeDemographics.EmployeeID, FirstName, LastName, Salary
from [SQL Tutorial].dbo.EmployeeDemographics
Inner Join [SQL Tutorial].dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
where FirstName <> 'Michael'
order by Salary DESC
--USE CASE: To Find the Average Salary of Salesman
Select JobTitle, AVG(Salary) As Avg_Salary
from [SQL Tutorial].dbo.EmployeeDemographics
Inner Join [SQL Tutorial].dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
where JobTitle = 'Salesman'
Group by JobTitle
/*
Union, Union All
*/

Select * from [SQL Tutorial].dbo.EmployeeDemographics

Select * from [SQL Tutorial].dbo.WareHouseEmployeeDemographics

--Create table WareHouseEmployeeDemographics (
--	EmployeeID int,
--	FirstName varchar(20),
--	LastName varchar(20),
--	Age char(2),
--	Gender varchar(6)
--)

--Insert into WareHouseEmployeeDemographics values
--	(1013, 'Darryl', 'Philbin', NULL, 'Male'),
--	(1050, 'Roy', 'Anderson', 31, 'Male'),
--	(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
--	(1052, 'Val', 'Johnson', 31, 'Female')

Select *
from [SQL Tutorial].dbo.EmployeeDemographics
FULL Outer Join [SQL Tutorial].dbo.WareHouseEmployeeDemographics
	on EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID

-- Applying UINON --> Skips repeating rows
Select * from [SQL Tutorial].dbo.EmployeeDemographics
Union
Select  * from [SQL Tutorial].dbo.WareHouseEmployeeDemographics

--Applying UNION ALL --> Doesn't skips repeating rows
Select * from [SQL Tutorial].dbo.EmployeeDemographics
Union All
Select  * from [SQL Tutorial].dbo.WareHouseEmployeeDemographics

-- Note: UNION will work even if the column names between two tables doesn't match
Select EmployeeID, FirstName, Age from [SQL Tutorial].dbo.EmployeeDemographics
Union All
Select EmployeeID, JobTitle, Salary from [SQL Tutorial].dbo.EmployeeSalary
Order by EmployeeID


/*
USE CASES
*/

-- Case Statement One
Select FirstName, LastName, Age,
CASE
	When Age > 30 Then 'Old'
	When Age between 27 and 30 then 'Young'
	Else 'Baby'
END
from [SQL Tutorial].dbo.EmployeeDemographics
where Age is not Null
order by Age

-- Case Statement Two --> if the statement is of the same value the first statement is executed
Select FirstName, LastName, Age,
CASE
	When Age > 30 Then 'Old'
	When Age = 38 Then 'Stanley'
	Else 'Baby'
END
from [SQL Tutorial].dbo.EmployeeDemographics
where Age is not Null
order by Age

-- Case Statement Three --> if the second case condition is moved up, the output changes [All conditions are met] --> works CORRECTLY
Select FirstName, LastName, Age,
CASE
	When Age = 38 Then 'Stanley'
	When Age > 30 Then 'Old'
	Else 'Baby'
END
from [SQL Tutorial].dbo.EmployeeDemographics
where Age is not Null
order by Age

-- Case Statement Four --> Salary Calculation
Select FirstName, LastName, JobTitle, Salary,
Case
	When JobTitle = 'Salesman' Then Salary + (Salary * 0.10)
	When JobTitle = 'Accountant' Then Salary + (Salary * 0.05)
	When JobTitle = 'HR' Then Salary + (Salary * 0.04)
	Else Salary + (Salary * 0.03)
End As SalaryAfterRaise
from [SQL Tutorial].dbo.EmployeeDemographics
join [SQL Tutorial].dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Order by SalaryAfterRaise DESC

--Note: Case Statements are used to categorize and or label Data


/*
Having Clause
*/

Select JobTitle, COUNT(JobTitle)
from [SQL Tutorial].dbo.EmployeeDemographics
Join [SQL Tutorial].dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- Where COUNT(JobTitle) > 1  }--> Throws Error, we cannot use Where clause with Count. Therefore we need to use Having Clause
-- Having COUNT(JobTitle) > 1 }--> Throws Error, because this Having statement is completely dependant on Group By Statement.
Group by JobTitle
Having COUNT(JobTitle) > 1

Select JobTitle, AVG(Salary)
from [SQL Tutorial].dbo.EmployeeDemographics
Join [SQL Tutorial].dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Group by JobTitle
Having AVG(Salary) > 45000
Order by AVG(Salary)

/*
Updating/Deleting Data
*/

Select *
from [SQL Tutorial].dbo.EmployeeDemographics

Update [SQL Tutorial].dbo.EmployeeDemographics
Set Age = 31, Gender = 'Female', EmployeeID=1012
Where FirstName = 'Holly' and LastName = 'Flax'

--Delete
--from [SQL Tutorial].dbo.EmployeeDemographics
--where EmployeeID = 1005


/*
Aliasing
*/

Select *
from [SQL Tutorial].dbo.EmployeeDemographics

-- Combining FirstName and LastName and giving it an alias
Select FirstName + ' ' + LastName as FullName
from [SQL Tutorial].dbo.EmployeeDemographics

-- Aliasing avgerage of Age
Select AVG(Age) AS AvgAge
from [SQL Tutorial].dbo.EmployeeDemographics

-- Table Alias
Select DEMO.EmployeeID, SAL.Salary
from [SQL Tutorial].dbo.EmployeeDemographics as DEMO
join [SQL Tutorial].dbo.EmployeeSalary as SAL
	on DEMO.EmployeeID = SAL.EmployeeID

Select Demo.EmployeeID, Demo.FirstName, Sal.Salary, Ware.Gender
from [SQL Tutorial].dbo.EmployeeDemographics as Demo
left join [SQL Tutorial].dbo.EmployeeSalary as Sal
	on Demo.EmployeeID = Sal.EmployeeID
left join [SQL Tutorial].dbo.WareHouseEmployeeDemographics as Ware
	on Sal.EmployeeID = Ware.EmployeeID


/*
Partition By
*/

Select *
from [SQL Tutorial]..EmployeeDemographics

Select *
from [SQL Tutorial]..EmployeeSalary

-- Partition By uses and Provides it on each row. Here the tota number of Female are 3 and considering the first row
-- --> 'Pam' , 'Female' whose Salary is '36000' works beside other 2 women --> total count is '3'
Select FirstName, LastName, Gender, Salary,
COUNT(Gender) Over (Partition by Gender) as TotalGender
from [SQL Tutorial]..EmployeeDemographics demo
Join [SQL Tutorial]..EmployeeSalary sal
	on demo.EmployeeID = sal.EmployeeID