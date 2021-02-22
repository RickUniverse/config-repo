# 方式1
select * from tbl_emp e where e.deptId in(select id from tbl_dept d)

    # 如果tbl_emp 数据量多于 tbl_dept,则使用exists,效率高
#  exists (select 1 from tbl_dept d where e.deptId = d.id) 只返回true和false
select * from tbl_emp e where exists (select 1 from tbl_dept d where e.deptId = d.id)

