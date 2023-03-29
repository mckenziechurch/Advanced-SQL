show engines;

-- show buffer size (in bytes)
SELECT @@innodb_buffer_pool_size;

-- set buffer pool size
set global innodb_buffer_pool_size=60000000;
SELECT @@innodb_buffer_pool_size;

-- check chunk size
select @@innodb_buffer_pool_chunk_size;

-- check pool instances
select @@innodb_buffer_pool_instances;

-- view status of the buffer pool
show engine innodb status;

-- buffer pool prefetching param
select @@innodb_read_ahead_threshold;

-- checking change in performance time relative to read-ahead
select * from employees where hire_date > '1999-10-10';
set global innodb_read_ahead_threshold = 2; -- change the threshold
select * from employees where hire_date > '1999-10-10'; -- re-reun the query