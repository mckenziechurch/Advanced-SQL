-- PREPARED STATEMENT PRACTICE
-- 1. it will create a prepared statement called myprepstmt
PREPARE myprepstmt from 'Select * from employees where emp_no=?';

-- 2. create a session variable to hold an employee id (the placeholder)
Set @empno = 10001;

-- 3. runs the query for employee id 10001 (run w/ an input value)
EXECUTE myprepstmt using @empno;

-- we can also REASSIGN the var
Set @empno = 10004;
EXECUTE myprepstmt using @empno;

-- 4. deallocate (close the connection)
DEALLOCATE PREPARE myprepstmt;

-- INDEXES
-- what's the runtime for this query?
explain SELECT * FROM employees WHERE first_name='John';
-- create an index
CREATE INDEX employees_fname_idx on employees(first_name);

-- example
explain SELECT * FROM employees e
JOIN salaries s
ON e.emp_no=s.emp_no
WHERE from_date='1999-10-10'; -- runtime = 0.016

-- create an index
CREATE INDEX salaries_from_date_idx ON salaries(from_date); -- runtime = 15.813 seconds

-- re-run the same query after index creation
explain SELECT * FROM employees e
JOIN salaries s
ON e.emp_no=s.emp_no
WHERE from_date='1999-10-10';