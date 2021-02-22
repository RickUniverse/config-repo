
# 单表！！！！！
# 查询索引
show index from article;

# 查询category_id 为 1 且 comments 大于 1 的情况下，views 最多的 article_id.
# 查询语句优化前
explain select id,author_id from article where category_id = 1 and comments > 1 order by views desc limit 1;

# 优化,创建索引
create index idx_article_ca_co_vi on article(category_id,comments,views);

# 注意点：范围会导致索引失效也就是说：comments > 1 会导致索引失效从而出现 Using filesort
# 为什么 出现 Using filesort 
# 		当comments 字段在联合索引里处于中间位置时（on article(category_id,comments,views);）
# 		因为comments > 1 条件是一个范围值（所谓range）
# 		MySQL 无法利用索引再对后面的views部分进行检索，即range类型查询字段后面的索引无效
# 优化版本1：
explain select id,author_id from article where category_id = 1 and comments = 1 order by views desc limit 1;
# create index idx_article_ca_co_vi on article(category_id,comments,views); 索引建立不合适，删除
drop index idx_article_ca_co_vi on article

# 优化版本2：
# 创建索引2，去除会范围查找的comments
create index idx_article_ca_co_vi on article(category_id,views);

# 理想状态！type：ref Extra：Using where; Backward index scan
explain select id,author_id from article where category_id = 1 and comments > 1 order by views desc limit 1;



# 两表！！！！！

# 未优化前：type:ALL
explain select * from class left join book on class.card = book.card

    # 优化1，添加索引优化
alter table book add index Y (card);
# 再次查询发现：table：book 的type：ref  extra：Using index rows:1
explain select * from class left join book on class.card = book.card

    # 删除索引
drop index Y on book;

# 优化2，添加class的card索引优化
alter table class add index Y (card);
# 注意点！！！
# 再次查询发现：table：class 的type：index  extra：Using index rows:20 ，说明左连接时，索引建立在右表效果最好！！！
# 原因：
# 	这是由左连接的特性决定的。left join 条件用于确定如何从右表搜索行，左边一定都有
# 	所以右边是我们的关键点，一定要建立索引
# 	右连接是同样的道理，关注的是左边
# 	也就是说：from class left join book 的话就需要：alter table book add index Y (card);
explain select * from class left join book on class.card = book.card

    # 删除索引
drop index Y on class;



# 三表！！！！！

# 优化前
explain select * from class left join book on class.card = book.card left join phone on book.card = phone.card;

# 优化添加索引
alter table book add index idx_book_card (card);
alter table phone add index idx_phone_card (card);

# 优化后 book 和 phone 的type：ref ， rows：1 ，extra：Using index
explain select * from class left join book on class.card = book.card left join phone on book.card = phone.card;



# 总结注意事项
# 尽可能 减少join语句中的NestedLoop的循环总次数，永远用小结果集驱动大的结果集！！！！
# 例如：class 驱动 book
# 优先优化NestedLoop的内层循环
# 保证join语句中被驱动表上join条件字段已经被索引
# 当无法保证被驱动表的join条件字段被索引且内存资源充足的前提下，不要太吝啬joinBuffer的设置














