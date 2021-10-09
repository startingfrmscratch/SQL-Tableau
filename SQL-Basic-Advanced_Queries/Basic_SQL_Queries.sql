/****** Script for Creating Employee Table ******/

--Create Table EmployeeDemographics
--(EmployeeID int,
--FirstName varchar(50),
--LastName varchar(50),
--Age int,
--Gender varchar(50)
--)


/****** Script for Creating Employee Salary ******/

--Create Table EmployeeSalary
--(EmployeeID int,
--JobTitle varchar(50),
--Salary int
--)

/****** Script for Inserting Values in Table: EmployeeDemographics ******/

--Insert into EmployeeDemographics values
--(1001, 'Jim', 'Halpert', 30, 'Male'),
--(1002, 'Pam', 'Beasley', 30, 'Female'),
--(1003, 'Dwight', 'Schrute', 29, 'Male'),
--(1004, 'Angela', 'Martin', 31, 'Female'),
--(1005, 'Toby', 'Flenderson', 32, 'Male'),
--(1006, 'Michael', 'Scott', 35, 'Male'),
--(1007, 'Meredith', 'Palmer', 32, 'Female'),
--(1008, 'Stanley', 'Hudson', 38, 'Male'),
--(1009, 'Kevin', 'Malone', 31,'Male')


/****** Script for Inserting Values in Table EmployeeSalary ******/

--Insert into EmployeeSalary Values
--(1001, 'Salesman', 45000),
--(1002, 'Receptionist', 36000),
--(1003, 'Salesman', 63000),
--(1004, 'Accountant', 47000),
--(1005, 'HR', 50000),
--(1006, 'Regional Manager', 65000),
--(1007, 'Supplier Relations', 41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)


/****** Script for General Queries ******/

Select *
from EmployeeDemographics

Select FirstName, LastName
from EmployeeDemographics

Select Top 5 *
from EmployeeDemographics

Select DISTINCT(EmployeeID)
from EmployeeDemographics

Select DISTINCT(Gender)
from EmployeeDemographics

Select COUNT(LastName) As LastNameCount
from EmployeeDemographics

Select MAX(Salary) As Max_Salary
from EmployeeSalary

Select MIN(Salary) As Min_Salary
from EmployeeSalary

Select AVG(Salary)
from EmployeeSalary


/*
Where Statement
=, <>, <, >, And, Or, Like, Null, Not Null, In
*/

Select *
from EmployeeDemographics
where FirstName = 'Jim'

Select *
from EmployeeDemographics
where FirstName <> 'Jim'

Select *
from EmployeeDemographics
where Age > 30

Select *
from EmployeeDemographics
where Age >= 30

Select *
from EmployeeDemographics
where Age < 32

Select *
from EmployeeDemographics
where Age <= 32

Select *
from EmployeeDemographics
where Age <= 32 and Gender = 'Male'

Select *
from EmployeeDemographics
where Age <= 32 or Gender = 'Male'

Select *
from EmployeeDemographics
where LastName like 'S%'

Select *
from EmployeeDemographics
where LastName like '%S%'

Select *
from EmployeeDemographics
where LastName like 'S%o%'

Select *
from EmployeeDemographics
where FirstName is null

Select *
from EmployeeDemographics
where FirstName is not null

Select *
from EmployeeDemographics
where FirstName in ('Jim', 'Michael')

/*
Group By, Order By
*/

Select Gender, Count(Gender) As Count_of_Gender
from EmployeeDemographics
group by Gender

Select Gender, Age, Count(Gender) As Count_of_Gender
from EmployeeDemographics
group by Gender, Age

Select Gender, Count(Gender) As Count_of_Gender
from EmployeeDemographics
where Age > 31
group by Gender
order by Count_of_Gender ASC

Select Gender, Count(Gender) As Count_of_Gender
from EmployeeDemographics
where Age > 31
group by Gender
order by Count_of_Gender DESC

Select *
from EmployeeDemographics
order by Age DESC, Gender

Select *
from EmployeeDemographics
order by 4 DESC, 5 DESC