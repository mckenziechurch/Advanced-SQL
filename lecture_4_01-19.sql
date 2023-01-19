-- FUNCTIONS LECTURE
-- extract the year from a string date - str_to_date(string, formatOfString)
select Year(str_to_date('10-10-2000', '%m-%d-%Y'));

-- select the average salary in the ##,###.## format from the employees database
select format(avg(salaries.salary), 2) as 'Avg Salary'
from salaries;

-- get descending salaries
select format(salary, 2) as 'Salaries'
from salaries
order by salary desc;

-- get count for salary col
set @numSalaries = 0;
select count(distinct(salary))
into @numSalaries
from salaries;
select @numSalaries;

-- what are the first and the last year of hire in the company?
set @firstYear = date(now());
set @lastYear = date(now());

select min(employees.hire_date)
into @firstYear
from employees;

select max(employees.hire_date)
into @lastYear
from employees;

select concat(@firstYear, ' - ', @lastYear) as 'Years Hiring';

-- the company had an issue with Quality in the year 1991.  
-- Who was the manager overseeing quality at that time?
select concat(employees.first_name, ' ', employees.last_name) as 'Manager', 
departments.dept_name as 'Department'
from employees
join dept_manager
on employees.emp_no=dept_manager.emp_no
join departments
on departments.dept_no=dept_manager.dept_no
where departments.dept_name='Quality Management'
and (year(dept_manager.to_date)=1991
or year(dept_manager.from_date)=1991);

-- find how many employees make over average salary
set @avgSalary = 0;
select avg(salaries.salary) into @avgSalary from salaries;

select count(sal.salary) as 'Employees who makes more than avg'
from salaries as sal
where (sal.salary>@avgSalary);