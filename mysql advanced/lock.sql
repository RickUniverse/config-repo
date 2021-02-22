# 上表锁
lock table mylock read, book write;

# 查看有没有上锁
show open tables;

# 释放锁
unlock tables;

# 分析表锁定
show status like 'table%';

SET autocommit=0;

select * from test_innodb_lock;

update test_innodb_lock set b='124', a=a+1 where a='2'

select * from test_innodb_lock where a=3 for update;

commit;
