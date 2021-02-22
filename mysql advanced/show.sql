# 查询慢查询
show variables like '%slow_query_log%';
# 开启慢查询，重启msql失效
set global slow_query_log=1;
# 默认慢查询超时时间
show variables like '%long_query_time%';
# 设置
set global long_query_time=3;

# 测试
select sleep(4);

# 查询当前有多少条慢查询语句
show global status like '%Slow_queries%';

# xxxx!
mysqldumpslow --help

