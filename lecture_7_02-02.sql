-- STORED/CUSTOM FUNCTIONS PRACTICE
delimiter $$
create function f1(hire_date date) -- this is the function header
returns varchar(20) -- define the return type
deterministic -- declare the function as either [non]/deterministic
begin -- input statement(s)/condition(s)
	declare res varchar(20); -- declaring a var
    set res = if (year(hire_date) < 2000, 'OLD EMPLOYEE', 'NEW EMPLOYEE');
    return (res); -- determine if res is old or new employee based on hire year
end $$ 
delimiter ; -- end use of delimiter '$$'

-- test - call the function
select 
first_name, last_name, hire_date, 
f1(hire_date) 
as status 
from employees;

-- can call the function in a select statement
select f1('2002-10-01');

-- load the function into a session var
set @emptstat = f1('2001-01-01');
select @empstat;

-- call function from inside procedure
declare var1 varchar(20);
set var1 = f1('2000-10-10');

-- using employees DB, write function to return employee id who was hired first
-- in the company, then use that function in a select statement to find the name
-- of the employee
delimiter $$
create function getFirstEmp()
returns int
deterministic
begin
	declare empId int;
	select emp_no into empId
	from employees
	where
	hire_date=(select min(hire_date) from employees)
	limit 1;
    return empId;
end $$
delimiter ;

select getFirstEmp();
select * from employees where emp_no=getFirstEmp();

-- write a functiont that will return the employee id of the oldest employee
-- in the company and then use that function in a select statement to find the name
-- of the employee
delimiter $$
create function getOldestEmp()
returns varchar(40)
deterministic
begin 
	declare empName varchar(40);
	select concat(employees.first_name, ' ', employees.last_name) into empName
	from employees 
	where
	employees.birth_date=(select max(employees.birth_date) from employees)
	limit 1;
    return empName;
end $$
delimiter ;

select getOldestEmp();