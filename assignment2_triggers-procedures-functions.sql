-- 1. Create a trigger that will run when someone tries to update records in the salaries table.  It will raise an error 
-- if the salary is less than 35,000 and higher than 1,40,000.  It will do nothing if the salary is within range.
DELIMITER $$
CREATE TRIGGER salary_validation
	BEFORE UPDATE
    ON salaries FOR EACH ROW
BEGIN
	declare msg varchar(150);
    if new.salary < 35000 OR new.salary > 1400000 THEN
		set msg = 'New salary record error: salary cannot be less than $35,000 or higher than $1,400,000.';
        signal sqlstate '45000' set message_text=msg;
	end if;
END $$
DELIMITER ;

-- Create a function that will accept the department name and a year as input.  Then it will return the number of people 
-- worked in that department in the specified year.  After you create the function, show how you will use it.
DELIMITER $$
CREATE FUNCTION num_employees_by_year(year int, deptName varchar(40))
RETURNS int
DETERMINISTIC
BEGIN
	DECLARE total_emp int;
    SELECT count(*) INTO total_emp
    FROM dept_emp d
    JOIN departments de
    ON d.dept_no=de.dept_no
    WHERE de.dept_name=deptName
    AND year between YEAR(d.from_date) AND year(d.to_date);
    return total_emp;
END $$
DELIMITER ;

-- test
select num_employees_by_year(2000, 'Sales');

-- Create a procedure that will return the total salary paid out for a department in a specific year.  It will take the 
-- department name and the year as input.  After that, show how you would call it.
DELIMITER $$
CREATE PROCEDURE total_salary_dept(IN year int, IN deptName varchar(40))
BEGIN
	select sum(salaries.salary) as 'Total Salary'
    from salaries s
    join dept_emp de
    on s.emp_no=de.emp_no
    join departments d
    on de.dept_no=dempt_emp.dept_no
    where d.dept_name=deptName AND year between YEAR(s.from_date) AND YEAR(s.to_date);
END $$
DELIMITER ;

-- call procedure
call total_salary_dept(2000, 'Sales');