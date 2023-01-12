-- DATA TYPES EXERCISE
create table testfloat
(
floatingcol double,
fixedcol decimal (19,12)
);

insert into testfloat
values(1000000.899999999999, 1000000.899999999999);

select * from testfloat;

-- EMPLOYEES DB PRACTICE - DATA ANALYSIS
-- First, let us look at the information_schema database maintained by mysql.  
-- It contains all database and table information.
select * from information_schema.schemata;

-- Show all table info
describe information_schema.tables;

-- All tables stored in this MySQL server
select * from information_schema.tables;

-- Show all tables that exist in a desired schema
select * from information_schema.tables where table_schema='employees';

-- Show all tables in a desired schema, as well as how many records are stored
select table_name, table_rows from information_schema.tables where table_schema='employees';

-- Practice join query
select concat(employees.first_name, ' ', employees.last_name) as 'Name',
titles.*
from employees
join titles
on employees.emp_no=titles.emp_no;