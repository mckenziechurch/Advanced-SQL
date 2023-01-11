-- REVIEW - CRUD OPERATIONS
-- create a new database/schema
CREATE DATABASE our_employeedb CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci; 
-- verify by refreshing the schemas list

-- 1. create the independent tables using DDL
create table employees 
(id integer auto_increment primary key, 
first_name varchar (50) not null, 
last_name varchar (50), 
SSN varchar(9), 
dob date not null);

create table departments 
(id tinyint auto_increment primary key, 
department_name varchar (25) not null, 
manager_name varchar (50));

-- 2. now create the dependent tables (these have foreign keys)
create table dependents 
(id integer auto_increment primary key, 
first_name varchar (50) not null, 
last_name varchar (50), 
employee_id integer not null, 
foreign key(employee_id) references employees(id));

create table department_employee 
(id BIGINT auto_increment primary key, 
department_id tinyint not null, 
employee_id integer not null, 
start_date date not null, 
end_date date not null, 
foreign key(employee_id) references employees(id), 
foreign key(department_id) references departments(id));

-- insert/create new records
insert into employees 
(first_name, last_name, dob, SSN)
values('John', 'Doe', '1995-10-10', '111111111');

insert into departments 
(department_name, manager_name)
values('HR', 'Jane Doe'); 

alter table dependents add dob date not null;

insert into dependents
(first_name, last_name, dob, employee_id
)values('little', 'john', '2018-10-10', 1);

insert into department_employee 
(employee_id, department_id, start_date, end_date)
values(1, 1, '2019-01-01', current_date()); 

-- update
 update employees set dob='1996-10-10'  where id=1;
 
 -- read
 select * from employees;
 select * from departments;
 
 -- join query
 -- Notice all the aliases we used - 
 -- dept for departments, 
 -- emp for employees, 
 -- and de for department_employee
select dept.department_name as 'Department', 
de.start_date as 'Start Date', 
de.end_date as 'End Date', 
emp.first_name as 'First Name', 
emp.last_name as 'Last Name' 
from departments dept
join department_employee de
on dept.id=de.department_id
join employees emp
on de.employee_id=emp.id
order by emp.first_name;
