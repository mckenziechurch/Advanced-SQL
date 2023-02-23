-- DATABASE SECURITY
-- create a user
create user kenzie@localhost
identified by 'kenzie'; -- remember, this is the PASSWORD for the user

-- see all users 
select * from user;

-- give permissions
grant all on world.* to kenzie@localhost; -- grant unlimited permission to specified db

-- revoke permissions
revoke all privileges,
grant option from kenzie@localhost; -- revoke all permissions for the specified db
-- validate revoke by logging in as the user and running `show databases` to see all accessible DBs

-- create roles
create role world_read;
grant select on world.* to world_read;

create role world_update;
grant update on world.* to world_update;

-- assign user to a role
grant world_read to kenzie@localhost;

-- show all permissions for the current user
show grants;