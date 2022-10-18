/* sub 쿼리 */
/* 'JONES' 사원의 급여보다 많이 받는 사원 출력 */
select sal from emp where ename = 'JONES';
select * from em pwhere sal > 2975;

/* SUB쿼리 */
select *
  from emp
 where sal > (select sal
                from emp
               where ename = 'JONES');				
/* 'SCOTT' 사원보다 입사일자 먼저인 사원들 정보 출력 */
select * from emp where hiredate < '1981-07-13';
select hiredate from emp where ename = 'SCOTT';
/*
update emp set hiredate = to_date('1987-07-13')
where ename='scott';
*/
select *
  from emp
 where hiredate < (select hiredate
                     from EMP
                    where ename='SCOTT');

 /* 전체 평균급여보다 급여를 많이 받는 사원들 출력 */
select avg(sal) from emp /* 2073.214285714285714285714285714285714286*/
;

select * from emp where sal > 2073.214285714285714285714285714285714286
;

select empno, ename, job, sal
from emp
where sal > (select avg(sal) from emp)
;

/* join한 테이블에서 sub쿼리 */
select empno, ename, job, sal, dept.deptno, dname, loc
from emp, dept
where emp.deptno = dept.deptno
and sal > (select avg(sal) from emp)
;



/* 다중 행 sub쿼리 */
/* 부서별 최대 급여를 받는 사원들의 정보 출력*/

/* 다중행 결과는 in()으로 대체 가능 */
select *
  from EMP
 where sal in (select max(sal) from emp group by deptno)
 ;
 
 select *
  from EMP
 where sal in (2850, 3000, 5000)
 ;
 
/* 다중 행 = 비교는 =any, =some */ 
 select *
  from EMP
 where sal = any (select max(sal) from emp group by deptno)
 ;

 select *
  from EMP
 where sal = some (select max(sal) from emp group by deptno)
 ;

/* 30번 부서의 최고 급여보다 적게 받는 사원들 정보 출력 */
 select sal from emp where deptno=30;
select *
  from emp
 where sal < any (select sal from emp where deptno=30)
;

select sal from emp where deptno = 30; 
select *
  from emp
 where sal < some (select sal from emp where deptno = 30);
 
/* 30번 부서의 급여보다 적게받는 사원들 정보 출력
 * all 서브쿼리와 비교조건에서 모두 만족해얃 true */                
select *
  from emp
 where sal < all (select sal from emp where deptno = 30);               
               
/* 30번 부서의 최고 급여보다 많이 받는 사원들 정보 출력*/
select *
  from emp
 where sal > all (select sal from emp where deptno = 30)
;

select *
from emp
where (sal >= all (select sal from emp where deptno = 30)) and not deptno=30
;

/* exist 조건에 맞는 결과가 존재하면 true */
select *
  from emp
 where exists (select dname from dept where deptno=10);
 
 select *
  from emp
 where exists (select sysdate from dual);
 
 select *
  from emp
 where not exists (select dname from dept where deptno=10)
 ;
 
/* where 조건에 칼럼 두 개 이상 sub 쿼리와 비교 */
/* where (칼럼1, 칼럼2, ... ) in (select 칼럼1, 칼럼2, ... ) */
 select *
 from emp
 where (deptno, sal) in (select deptno, max(sal)
                         from emp
                         group by deptno)
;

 select *
 from emp
 where (empno, ename) in (select empno, ename
                           from emp
                          where sal = 1250)
;

/* from절에 sub쿼리 사용하기 */
select * from emp where deptno=10;
select * from dept;

select *
  from (select * from emp where deptno=10) a,
       (select * from dept) b
where a.deptno = b.deptno
;

select empno, ename, sal, deptno
  from emp
 where deptno=10;
 
 select *
 from
 (select empno, ename, sal, deptno
 from emp where deptno=10) a,
 (select deptno, dname from dept) b
 where a.deptno= b.deptno
 ;
 
 /* from절의 sub 쿼리 */
/* rownum은 테이블 where절이 실행될 때 조건에 맞으면 1을 부여하고 맞지 않으면 번호를 부여하지 않고 버리는 방식으로 진행
 * 따라서, where절이 없으면 rownum은 만들어지고, where절 조건을 충족시키지 못하면 rownum은 실행되지 못함*/
 select rownum, empno, ename, sal
 from emp
 ;
 
select rownum, empno, ename, sal
from emp
where rownum >=5
;

select *
from (select rownum as rn, empno, ename, sal
      from emp) a
where rn >= 5
;

select *
from (select rownum as rn, empno, ename, sal
from emp
where rownum <= 10) a
where rn >= 5
;

  
select *
  from (select rownum as rn, empno, ename, sal
          from emp
        ) a
  /*where rn >= 5 and rn <=10 */
  where rn between 5 and 10
 ;  
/* rownum가상(pseudo)칼럼 에 별칭을 붙여서 다른칼럼으로 사용 */ 
select *
  from (select rownum as rn, empno, ename, sal
          from emp
         where rownum <=10
        ) a
  where rn >=5
 ;
 

/* with절은 select 전에 선언 */
with
e10 as (select * from emp where deptno=10),
d as (select * from dept)
select e10.empno, e10.ename, e10.deptno, d.dname, d.loc
from e10,d
where e10.deptno = d.deptno
;

/* 칼럼에 사용되는 sub쿼리 */
select empno, ename, job, sal,
(select grade 
   from salgrade 
  where e.sal between losal and hisal) as salgrade,
(select dname 
   from dept 
  where e.deptno=dept.deptno) as dname
from emp e;