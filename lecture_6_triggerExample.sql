-- UPDATE trigger
DELIMITER $$
CREATE TRIGGER record_salary_update
    AFTER UPDATE
    ON salaries FOR EACH ROW
BEGIN
   insert into audit_trail (tablename, action_type,old_data, new_data) 
   values('salaries', ‘UPDATE’, JSON_OBJECT("empid",OLD.emp_no, "salary",   OLD.salary,"from", OLD.from_date, 	"to",OLD.to_date),
    JSON_OBJECT("empid",NEW.emp_no, "salary", NEW.salary,"from", NEW.from_date, 	"to",NEW.to_date));
END$$    
DELIMITER ;

-- delete a trigger
drop trigger record_salary_update;

DELIMITER $$
CREATE TRIGGER record_salary_update
    AFTER UPDATE
    ON salaries FOR EACH ROW
BEGIN
   insert into audit_trail (tablename, action_type,old_data, new_data) 
   values('salaries', 'UPDATE', JSON_OBJECT("empid",OLD.emp_no, "salary",   OLD.salary,"from", OLD.from_date, 	"to",OLD.to_date),
    JSON_OBJECT("empid",NEW.emp_no, "salary", NEW.salary,"from", NEW.from_date, 	"to",NEW.to_date));
END$$    
DELIMITER ;

show triggers;

-- VALIDATION trigger
DELIMITER $$
CREATE TRIGGER validate_salary_insert
    BEFORE INSERT
    ON salaries FOR EACH ROW
    BEGIN
	declare msg varchar(150); -- create a var inside of a trigger
    	if new.salary <= 0 then -- validate salary
        		set msg = 'New salary record error: salary cannot be 0 or negative';
        		signal sqlstate '45000' set message_text = msg;
    	end if;
    END$$   
DELIMITER ;
