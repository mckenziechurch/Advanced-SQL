-- PRACTICE/REVIEW DAY
-- VIEWS
-- Create a query that will show the employee full name and the department 
-- they worked for and the title they held.  Make sure the dates are used to 
-- match when they worked in what department and the position they held during that time.

-- employees can work in different departments at different times, w/ different titles
-- what tables do we need? employees, departments, titles -> how will we join the data?
-- how will we find emp where they have multiple positions at the same time?
-- this will be NON-UPDATABLE due to the use of concat agg. function
select concat(e.first_name, ' ', e.last_name) as 'Full Name', 
dep.dept_name as 'Department', t.title as 'Title',
t.from_date as 'From Date', t.to_date as 'End Date'
from employees e
join titles t 
on e.emp_no=t.emp_no
join dept_emp depte
on depte.emp_no=e.emp_no
join departments dep
on dep.dept_no=depte.dept_no
where depte.from_date=t.from_date;

-- create the above query as a VIEW
Create view emp_dept_title AS
Select 
concat_ws(' ', e.first_name, e.last_name) as fullname, 
d.dept_name,t.title,
t.from_date, t.to_date 
from departments d
join dept_emp de on de.dept_no=d.dept_no
join employees e on e.emp_no=de.emp_no
join titles t on e.emp_no=t.emp_no
order by fullname;

select * from emp_dept_title;

-- TRIGGER
-- Create a trigger so that whenever we try to insert a record into the employees table, it will 
-- check the date of birth and raise error if the age of the employee being inserted is less than 18.
DELIMITER $$
create trigger check_dob
before insert
on employees for each row
begin
	declare age int;
    declare msg varchar(50);
    set age = (year(current_date()) - year(new.birth_date));
    if age < 18 then 
		set msg = 'Employee is under the age of 18.';
        signal sqlstate '45000' set message_text=msg;
	end if;
end $$
DELIMITER ;

show triggers;
-- test trigger
-- valid input
insert into employees
(emp_no, first_name, last_name, birth_date, hire_date, gender)
values
(500000, 'Kenzie', 'Church', '2000-08-10', '2023-01-01', 'F');

-- invalid input
insert into employees
(emp_no, first_name, last_name, birth_date, hire_date, gender)
values
(500001, 'McKenzie', 'Church', '2022-08-10', '2022-01-01', 'F');

-- FUNCTIONS
-- Create a function that will accept the department name and a year as input.  
-- Then it will return the number of people worked in that department in the specified year.
delimiter $$
create function get_dept_size(year int, deptName varchar(40))
returns int
deterministic
begin
	declare total_emp int;
    select count(*) into total_emp
    from dept_emp d 
    join departments de
    on d.dept_no=de.dept_no
    where de.dept_name=deptName 
    and year between year(d.from_date) and year(d.to_date);
    return total_emp;
end $$
delimiter ;

select count(*) get_dept_size(2020, 'Sales') from employees;