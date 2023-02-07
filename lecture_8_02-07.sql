-- CREATING STORED PROCEDURE
delimiter $$
	create procedure getFullNames()
    begin
		select concat(employees.first_name, ' ', employees.last_name) from employees;
	end $$
    delimiter ;

-- test calling the procedure
call getFullNames();

-- Create a procedure that will return the full name of an employee given an ID
-- here, we are accepting an IN param and returning an OUT param
delimiter $$
create procedure getFullNamesByID(IN empid int, OUT fullname varchar(50))
-- we did not use a SINGLE INOUT param bc the IN and OUT are two diff data types
begin
	select concat(employees.first_name, ' ', employees.last_name) into fullname from
    employees where employees.emp_no=empid;
end $$
delimiter ;

-- test the IN/OUT procedure
call getFullNamesByID(10001, @fullname);
select @fullname;

-- Create a procedure that will return the full names of all 
-- employee hired between two dates
delimiter $$
create procedure getFullNamesByHireDates(IN date1 date, IN date2 date)
begin
	select concat(employees.first_name, ' ', employees.last_name) as 'Full Name'
    from employees
    where employees.hire_date between date1 and date2;
end $$
delimiter ;

-- test the procedure
call getFullNamesByHireDates('1999-10-10', '2000-10-10');

-- VALIDATION: Create a procedure that will return the full name 
-- of an employee given an ID 
delimiter $$
create procedure getFullNamesByHireDatesWithValidityChk(IN date1 date, IN date2 date)
begin
-- validation step
	if date1 > date2 then 
		signal sqlstate '45000'
		set message_text='End date cannot be earlier than start date.';
	end if;
    select concat(employees.first_name, ' ', employees.last_name) as 'Full Name'
    from employees
    where employees.hire_date between date1 and date2;
end $$
delimiter ;

-- test the procedure
call getFullNamesByHireDatesWithValidityChk('1991-10-10', '2000-10-10');
call getFullNamesByHireDatesWithValidityChk('2000-10-10', '1991-10-10');