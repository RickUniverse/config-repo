# 创建索引方式1： UNIQUE 可选 表示唯一索引
CREATE UNIQUE INDEX idx_emp_name ON tbl_emp(NAME);

# 创建索引方式2：[UNIQUE] 可选
# ALTER tbl_emp ADD UNIQUE INDEX idx_emp_id ON (id);

# 删除索引：
DROP INDEX idx_emp_name ON tbl_emp;

# 查看索引
SHOW INDEX FROM tbl_emp;