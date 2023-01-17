-- practising case function:
select case 1 when 1 then 'one' -- the value after 'case' is what is being compared
when 2 then 'two' -- after 'when' is what the value is being compared to
else 'more' end;

-- if statement (similar to ternary operator)
select if (4>2, 2, 3); -- if 1>2, return 3, otherwise return 2

-- use year
select year('1987-01-01'); -- formatting matters -> YYYY-MM-DD

-- MYSQL FUNCTIONS
-- find the avg salary
select avg(salaries.salary) as 'Avg Salary' from salaries;

-- find the min & max salaries
select max(salaries.salary) as 'Highest Salary',
min(salaries.salary) as 'Lowest Salary'
from salaries;

-- WHO gets the highest salary?
select concat(employees.first_name, ' ', employees.last_name) as 'Name',
salaries.salary as 'Salary'
from employees 
join salaries
on employees.emp_no=salaries.emp_no
where salaries.salary=(select max(salaries.salary) from salaries); -- this is a SUBQUERY
-- notice, this query took 4.4 seconds to run (slow)

-- NOTICE this returns a different results w/o the where
-- the where is saying, get the employee who's salary satisfied this condition
-- also, putting select max() at the top w/o where clause only gets ONE person, if more than one
-- person satisfies that condition!
select concat(employees.first_name, ' ', employees.last_name) as 'Name',
max(salaries.salary) as 'Salary'
from employees 
join salaries
on employees.emp_no=salaries.emp_no;

-- who gets the lowest salary?
select concat(employees.first_name, ' ', employees.last_name) as 'Name',
salaries.salary as 'Salary'
from employees 
join salaries
on employees.emp_no=salaries.emp_no
where salaries.salary=(select min(salaries.salary) from salaries);

-- combine the two queries to get BOTH highest and lowest paid employees
select first_name, last_name, salaries.salary from employees
join salaries
on employees.emp_no = salaries.emp_no
where salaries.salary = (select max(salaries.salary) from salaries)
union
select first_name, last_name, salaries.salary from employees
join salaries
on employees.emp_no = salaries.emp_no
where salaries.salary = (select min(salaries.salary) from salaries);

-- find the max salary by using a VARIABLE (session variable)
set @maxsal = 0; -- a session variable; create the var
select MAX(salaries.salary) into @maxsal from salaries; -- var initialization

-- test the var
select @maxsal;
select employees.first_name, employees.last_name
from employees
join salaries
on employees.emp_no = salaries.emp_no
where salaries.salary = @maxsal;

-- CASE function
SELECT employees.first_name, employees.last_name,
(CASE employees.gender WHEN 'M' THEN 'MALE' -- check the value of the gender col.
WHEN 'F' THEN 'FEMALE'
ELSE 'Other' 
END) as Gender -- we can put an alias for a case
FROM employees.employees; -- from goes after the case is ended

-- IF function
SELECT employees.first_name, employees.last_name,
Year(employees.birth_date),
(IF((YEAR(curdate())-Year(employees.birth_date)) > 65, 
'Senior citizen', 'Not senior')) as 'Category'
FROM employees.employees;