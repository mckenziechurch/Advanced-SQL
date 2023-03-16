-- TRANSACTIONS - ISOLATION & CONCURRENCY
-- check isolation level of entire DB
select @@global.transaction_isolation;

-- check isolation level of the current session
select @@session.transaction_isolation;

-- set isolation level
set session transaction isolation level read uncommitted;

--
select @@autocommit;