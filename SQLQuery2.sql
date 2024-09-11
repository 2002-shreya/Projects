create database HR_Analytics;

create table Department(
DepID int Primary Key,
DepName varchar(25) Not Null Default 'Department'
);
Create table Employee (
EmpId int Primary Key,
EmpName varchar(100),
StartYear int,
EndYear int,
StartSalary Float,
CurrentSalary Float,
EndSalary Float,
DepId int Not Null,
FOREIGN KEY (DepID) REFERENCES Department(DepID )
);

Insert into Department values (1,'Department' ),
(2,'HR' ), (3 ,'IT' ),(4 ,'Sales' );


use master;
INSERT INTO Employee (EmpId, DepId, EmpName, StartYear, EndYear, StartSalary, 
CurrentSalary, EndSalary )
VALUES
(1,1,'Bill Gates', 2000,NULL, 310000.00, 310000.00,NULL),
(2,1,'John Lenon', 2000,NULL, 110000.00,110000.00,NULL),
(3,2,'Haily Anderson', 2010,NULL, 90000.00, 90000.00,NULL),
(4,2,'Nicolaus Michelson', 2009,NULL, 95000.00, 95000.00,NULL),
(5,2,'Rebecca Michelson', 2010,NULL, 85000.00, 85000.00,NULL),
(6,3,'Elena Gilbert', 2010,NULL, 55000.00, 55000.00,NULL),
(7,3,'John Smith', 2010,NULL, 65000.00, 65000.00,NULL),
(8,3,'Alex Red', 20013,NULL, 68000.00, 68000.00,NULL),
(9,3,'Richard Blue', 2013,NULL, 1198000.00, 1198000.00,NULL),
(10,3,'Edward Cullen', 2013,NULL, 1298000.00, 1298000.00,NULL);

select * from Employee;

select * from Department;

--  To show the names of the employees whose name starts with 'B'

select Employee.EmpName from Employee where Employee.EmpName like 'B%';

--To show the names of the employees belonging to the department having department id 2.

Select Employee.EmpName from Employee where Employee.DepId=2;

-- To calculate the number of records in the Employee table. 

select COUNT(Employee.EmpName) as no_of_Records from Employee;

-- . To calculate maximum StartSalary for the StartYear ‘2010’

select MAX( Employee.StartSalary) from Employee where Employee.StartYear= 2010;

--To show names of the employees and their starting salary sorted by StartSalary (from higher to lower)
--who joined after 2010 

select Employee.EmpName, Employee.StartSalary from Employee where Employee.StartYear >= 2010 
order by Employee.StartSalary;

-- To show a summarized StartSalary for each DepID.

select SUM( Employee.StartSalary) as Total_Department_salary, Employee.DepId from Employee group by Employee.DepId;

 --To show department names and employee names belonging in each department. (Hint:
--Join 2 tables)

select Employee.EmpName,Department.DepName, Employee.DepId,Department.DepID from Employee left join  Department
on Employee.DepId= Department.DepID;

-- To show names of the employee in the following departments: HR, Sales, and IT.

select Employee.EmpName , Department.DepName from Employee left join Department on Employee.DepId=Department.DepID 
where Department.DepName in ('IT''HR''SALES');

-- A new department "Accounting" is to be created in the department table

select * from Department;

Insert into Department values (5,'Accounting');

--New Employee "Brian Latona" joined "Sales" in 2014 with starting salary of 120000.00

select * from Employee;

Insert into Employee values (11,'Brian Latona',2014,Null,120000,120000,null,4);

--Meredith Whitney and Mario Gabelli started in 2011 with a starting salary of 350000.00 and 
--420000.00 in the department Accounting

insert into Employee values (12,'Meredith Whitney',2011,null,350000,350000,null,5),(13,'Mario Gabelli',2011,null,420000,420000
,null,5);

--Ms. Haily Anderson left in 2013 with an EndSalary 3000.00 greater than the CurrentSalary

update Employee set EndYear= 2013, EndSalary=3000+ CurrentSalary where EmpName= 'Haily Anderson';

select * from Employee;

-- Display Total  CurrentSalary for the department HR. Your output must include 
--existing employees only. 


SELECT SUM(Employee.CurrentSalary) AS TotalCurrentSalary
FROM Employee
JOIN Department ON employee.DepId = Department.DepID
WHERE department.DepName = 'HR' and EndYear is null;

--A 6% increment is to be made to current salary for all existing employees in the department with 
--department id ‘2’

begin transaction;

update Employee set CurrentSalary= 1.06 *(CurrentSalary  )    where Employee.DepId= 2;

-- Write SQL to create a single View, ‘Week3_DepartmentEmployee_vi’, that displays the 
--following:Department ID, DepartmentName, EmployeeID, EmployeeName, StartSalary, CurrentSalary,
--Difference between StartSalary and CurrentSalary as Promoted, EndSalary.

Begin transaction;

select Employee.DepId, Department.DepName, Employee.EmpId,Employee.EmpName, Employee.StartSalary,
Employee.StartSalary, Employee.CurrentSalary , (Employee.CurrentSalary- Employee.StartSalary) as Promoted,
Employee.EndSalary from Employee left join Department on Employee.DepId=Department.DepID; 










