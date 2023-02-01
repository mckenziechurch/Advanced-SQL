-- TRIGGERS LECTURE
-- create audit trail table to track any changes in any table through triggers
create table if not exists audit_trail
(id bigint unsigned auto_increment primary key,
tablename varchar (25) not null, -- table that was changed
old_data json not null, -- notice, we have JSON data now - data before the change
new_data json not null, -- data after it is changed
action_type varchar(10), -- the event query action
change_time_stamp timestamp default current_timestamp); -- when the data was changed
-- (default current_timestamp allows server to automatically input the current time of change
-- w/o needed an insert query for current timestamp)

-- now let's create the trigger
DELIMITER $$ -- temporary change default delimiter (;) to $$ so that ; inside of delimiters aren't ran until the 
-- end delimiter
CREATE TRIGGER record_salary_update
    AFTER UPDATE -- define the event to look for
    ON salaries FOR EACH ROW -- define the trigger TYPE
BEGIN -- define the trigger action
   insert into audit_trail (tablename, action_type, old_data, new_data) -- not the use of OLD/NEW
   values('salaries', JSON_OBJECT("empid",OLD.emp_no, "salary",   OLD.salary,"from", OLD.from_date, 	"to",OLD.to_date),
    'UPDATE' -- action type
    JSON_OBJECT("empid",NEW.emp_no, "salary", NEW.salary,"from", NEW.from_date, 	"to",NEW.to_date));
END$$    -- end the actual trigger
DELIMITER ; -- tell MySQL to resume using the default delimiter ';'

-- verify creation of the trigger
show triggers; -- this shows all triggers that were created

-- test the update trigger
update salaries set salary=76000 where emp_no=10001 and from_date='1986-06-26';

-- view the audit
select * from audit_trail;

-- verify trigger creation (created in another window)
show triggers;

-- test the validation trigger
insert into salaries values(10001, 100, '1990-10-10','1990-12-12');

-- check if trigger action performed
select * from salaries 
where emp_no=1001 and from_date='1990-10-10';

-- create invalid entry to see if our error is thrown
insert into salaries values(10001, 0, '1990-10-10','1990-12-12');

-- ensure that the invalid entry was NOT entered into the table (caught by our validation)
select * from salaries 
where salaries.salary=0;