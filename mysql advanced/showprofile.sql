# 默认关闭
show variables like 'profiling';
# 开启
set profiling=on;

select count(*) from tbl_emp;

# 查看记录的sql语句情况
show profiles;

# 查询sql的完整生命周期
show profile cpu,block io for query 2;
show profile for query 2;


show variables like "%pro%";