# 1，左外连接,取左表全部，右表满足 ON e.deptId = d.id
SELECT * FROM tbl_emp e LEFT JOIN tbl_dept d ON e.deptId = d.id;

# 2,右外连接,取右表全部，左表满足 ON e.deptId = d.id
SELECT * FROM tbl_emp e RIGHT JOIN tbl_dept d ON e.deptId = d.id;

# 3,内连接，取两表共有(交集)
SELECT * FROM tbl_emp e INNER JOIN tbl_dept d ON e.deptId = d.id;

# 4,左连接取左表独有，不满足 ON e.deptId = d.id, WHERE d.id IS NULL; 需要是d.id
SELECT * FROM tbl_emp e LEFT JOIN tbl_dept d ON e.deptId = d.id WHERE d.id IS NULL;

# 5,右连接取右表独有，不满足 ON e.deptId = d.id, WHERE e.id IS NULL; 需要是e.id
SELECT * FROM tbl_emp e RIGHT JOIN tbl_dept d ON e.deptId = d.id WHERE e.id IS NULL;

# 6,取两表所有，full
# MySQL不支持FULL OUTER ，Oracle 支持： SELECT * FROM tbl_emp e FULL OUTER JOIN tbl_dept d ON e.deptId = d.id
SELECT * FROM tbl_emp e LEFT JOIN tbl_dept d ON e.deptId = d.id
    # UNION：两者合并去重
UNION
SELECT * FROM tbl_emp e RIGHT JOIN tbl_dept d ON e.deptId = d.id

    # 7,取表全没有，（差集）
SELECT * FROM tbl_emp e LEFT JOIN tbl_dept d ON e.deptId = d.id WHERE d.id IS NULL
    # UNION：两者合并去重
UNION
SELECT * FROM tbl_emp e RIGHT JOIN tbl_dept d ON e.deptId = d.id WHERE e.id IS NULL