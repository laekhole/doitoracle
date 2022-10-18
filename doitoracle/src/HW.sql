Q1)

select deptno,
	   trunc(sum(sal)/count(*)) as avg_sal,
	   max(sal) as MAX_SAL,
	   min(sal) as min_sal,
   	   count(*) as CNT
from emp
group by deptno
order by deptno desc
;


Q2)
select job, count(*)
from emp
group by job
having count(*)>=3
;

Q3)
select to_char(hiredate,'yyyy') as hire_year,
                deptno,
                count(*) cnt
from emp
group by hire_year, deptno
order by hire_year desc, deptno
;

select to_char(hiredate,'yyyy') as hire_year,
	   deptno   
from emp
;

select distinct to_date(to_char(hiredate,'yyyy'),'yyyy') as HIRE_YEAR,
	   deptno
FROM EMp
;