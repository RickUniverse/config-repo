EXPLAIN SELECT * FROM tbl_emp WHERE id = 1

EXPLAIN SELECT * FROM tbl_emp e, tbl_dept d WHERE e.deptId = d.id;