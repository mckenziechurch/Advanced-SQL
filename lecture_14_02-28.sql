-- TRANSACTIONS LECTURE
-- procedure w/ NO TRANSACTION
delimiter $$
create procedure checknotr()
begin
    declare exit handler for sqlexception
    begin
	resignal; -- catch exceptions
    End;
	insert into employees(emp_no,first_name, last_name, hire_date, birth_date)
	values (500001, 'blah','mah','2021-01-01', '2000-01-01');  
	-- use the last_insert_id() function to get the last PK of the last inserted record
	-- if the primary column is auto increment
	-- employees table does not have a auto increment PK, so we can use the PK we provided i.e. 50001
	-- do sleep(10);
	insert into dept_emp values(500001, '10001', '2021-01-01', NULL); 
    -- error - dept_no is too large, but we cannot undo changes made in the first query. 
END $$
delimiter ;
Call checknotr();
select * from employees where emp_no=500001;  
-- the record was created even though the second query errored out

-- PROCEDURE W/ A TRANSACTION
delimiter $$
create procedure checktr()
begin
    declare exit handler for sqlexception
    begin
	rollback;
    end;
	start transaction; -- STARTING 
	insert into employees(emp_no,first_name, last_name, hire_date, birth_date)
	values (500002, 'blah','mah','2021-01-01', '2000-01-01'); 
	-- use the last_insert_id() function to get the last PK of the last inserted record
	-- if the primary column is auto increment
	-- employees table does not have a auto increment PK, so we can use the PK we provided i.e. 50001
	-- do sleep(10);
	insert into dept_emp values(500002, '10001', '2021-01-01', NULL); -- error - dept_no is too large, we can rollback
	commit; -- if an error occurs, will rolback the query and NOT commit
END $$
delimiter ;

Call checktr();
Select * from employees where emp_no=500002; -- (no employee since we rollbacked)

-- TRANSACTION USING ROLLBACK
start transaction;
delete from employees where emp_no=500001;
select * from employees where emp_no = 500001;
Rollback; -- rollback undoes any queries up until 'start transaction'

select * from employees where emp_no = 500001;

-- viewing concurrency when the transaction is put to sleep
-- 1. create a user
create user 'aaa'@'localhost' identified by 'bbb';
grant all on employees.* to 'aaa'@'localhost';

-- 2. login as the user and change the session timeout read time to 0
-- 3. create the following procedure in 'root'
delimiter $$
create procedure checktr_aaa()
begin
    declare exit handler for sqlexception
    Begin
		rollback;
    end;
	start transaction;
		update employees set hire_date='2000-10-10' where emp_no=10001; -- changes the hire date of emp 10001
    do sleep(60);
    select * from employees where emp_no=10001;
commit;
END $$
delimiter ;

-- 4. Go to the connection of aaa and open 2 query tabs
-- 5. in one tab, run 'Select * from employees where emp_no=10001;' and in the other, run 'update employees set hire_date='1996-12-12' where emp_no=10001;'
-- 6. Go back to the connection of root and call the procedure you just created
CALL checktr_aaa();

-- At this point it will wait for a second since there is a sleep command.
-- 7. Go back to the connection for aaa
	-- Select the first query tab and run the select query.  What do you see?
	-- Now quickly go to the update query tab and run the update query.  What happens?
