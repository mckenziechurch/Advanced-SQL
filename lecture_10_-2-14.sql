-- EXAM REVIEW
-- For marketing purposes, I need to know those renters (name and phone number) 
-- who are currently renting a unit but haven’t bought any insurance.  Show the 
-- query that can give the data I need.
select r.renter_name, r.renter_phone, r.id 
from renters r
join rentals rl
on rl.renter=r.id
join rental_insurance ri
on r.id=ri.id
where rl.rental_end_date is null
and r.id
not in (ri.id);

-- Write a procedure that will accept an insurance type ( the name of the 
-- insurance, not the id) as an input parameter and check if there is any 
-- rental associated with that insurance at all.  The procedure will follow 
-- the steps given below to do this - 

-- Step 1:  check if a valid insurance type was given by checking if that 
-- insurance type exists in the insurance_types table.  Insurance types can be 
-- - FIRE, FLOOD, EARTHQUAKE.  If the insurance does not exist, then it will 
-- throw an error saying "Invalid insurance type."   If the insurance type exist, 
-- then it will go to step 2.
DELIMITER $$
CREATE PROCEDURE check_rental_ins()
NONDETERMINISTIC
begin
	Declare inscount int;
	Declare returnmsg varchar(3);
	Select count(*) into inscount from insurances where insurance_type=instype;
	If inscount = 0 then
		Raise error
	End if;
END$$
DELIMITER ;

-- VIEWS, PREPARED STATEMENTS, INDEXES
-- updatable view creation
create view myview as 
select * from departments; -- create the view

select * from myview; -- run the view

update myview set dept_name='Customer Services' where dept_no = 'd009';
Select * from departments; -- testing to see if the department name is updated

-- inquiring about views
select * from information_schema.views;
select * from information_schema.views where table_name='myview';
show create view myview;

-- EXERCISE
-- Make sure the employees database is selected.
-- Now create a query that will show the employee full name and the department 
-- they worked for and the title they held.  Make sure the dates are used to match 
-- when they worked in what department and the position they held during that time.
select concat(employees.first_name, ' ', employees.last_name) as 'Full Name',
departments.dept_name as 'Department',
titles.title as 'Title' 
from employees 
join dept_emp
on employees.emp_no=dept_emp.emp_no
join departments
on dept_emp.dept_no=departments.dept_no
join titles
on titles.from_date=dept_emp.from_date;

-- Imagine running this ugly query frequently!
-- Now create a view for the query above.
-- We will create a user who will only have access to this view, nothing else.
-- Open up another connection from workbench and log in as the new user and see if you 
-- have access to the view and nothing else.
-- Now run the query that will show only the information for someone whose first name 
-- is John.
