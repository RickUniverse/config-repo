# 由于开启过慢查询日志，因为我们开启了bin-log,我们就必须开启log_bin_trust_function_creators
show variables like 'log_bin_trust_function_creators';
# 设置
set global log_bin_trust_function_creators=1;


delimiter $$
create procedure insert_emp(in start int(10),in max_num int(10))
begin
declare i int default 0;
set autocommit = 0;
repeat
set i = i+1;
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno) values((start+i),ran_string(6),'salesman',0001,curdate(),2000,400,rand_num());
until i=max_num
end repeat;
commit;
end $$delimiter $$
create procedure insert_dept(in start int(10),in max_num int(10))
begin
declare i int default 0;
set autocommit = 0;
repeat
set i = i+1;
insert into dept(deptno,dname,loc) values((start+i),ran_string(10),ran_string(8));
until i=max_num
end repeat;
commit;
end $$



delimiter $$
create function ran_string(n int) returns varchar(255)
begin
declare chars_str varchar(100) default 'abcdefghijklmnopqrstuvwxyz';
declare return_str varchar(255) default '';
declare i int default 0;
while i < n do
set return_str = concat(return_str,substring(chars_str,floor(1+rand()*52),1));
set i=i+1;
end while;
return return_str;
end $$

delimiter $$
create function rand_num() returns int(5)
begin
declare i int default 0;
set i=floor(100+rand()*10);
return i;
end $$

delimiter;
# 调用存储过程
call insert_emp(1000,5000);