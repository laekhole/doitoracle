/* 다중행 함수 */
select sum(sal) 
  from emp
/* where deptno=30; */

/*select sal 
  from emp
where deptno=30; */

  
/* 평균 avg(값)*/  
select avg(sal), sum(sal)/14, sum(comm), sum(sal)/count(*) 
  from emp;
  
/* count()함수는 값이 null이면 집계에서 제외 됨,
 * 일반적으로 count()함수는 count(*)로 사용 */  
select count(empno), count(*), count(comm), count(nvl(comm,0)) 
  from emp  
/*최대값 */  
select max(sal)
  from emp;
  
/* 최소값 */  
select min(sal)  
  from emp;
  
/**----------- 그룹별 집계 --------------**/ 
  
/* 다중행 함수 -group by 그룹기준  */
select deptno, sum(sal) 
  from emp
  group by deptno
;

select sum(sal) 
  from emp
  group by deptno
;
  
/* 평균 avg(값)*/  
select deptno, avg(sal), sum(sal)/14, sum(comm), round(sum(sal)/count(*)) 
  from emp
 group by deptno;
  
/* count()함수는 값이 null이면 집계에서 제외 됨,
 * 일반적으로 count()함수는 count(*)로 사용 */  
select deptno, count(empno), count(*), count(comm), count(nvl(comm,0)) 
  from emp
group by deptno;
  
  
/*최대값, 최소값  */  
select deptno, max(sal),min(sal)
  from emp
 group by deptno;

select max(sal),min(sal)
  from emp
 group by deptno;  
 
/**-----------------------------------**/
 select deptno, job, max(sal),min(sal)
  from emp
 group by deptno, job /* group by 절 */
 order by deptno, job /* order by 절 */
 ;
 
 
/* group by 후 having절 사용하기 */
select deptno, job, avg(sal)
  from emp
 group by deptno, job
  having  avg(sal) >= 2000 /* 개별 데이타가 아닌 집계데이타대상으로 필터링 조건 */
 order by deptno, job
  ;
  
/* 개별데이타 조건 where, 집계데이타 조건 having -오류 발생  */  
 select deptno, job, avg(sal)
  from emp
 where having  avg(sal) >= 2000 /* 개별 데이타가 아닌 집계데이타대상으로 필터링 조건 */
 group by deptno, job
 order by deptno, job
  ; 
  
/* where, having */  
select deptno, job, sum(sal)
  from emp
 where deptno in (10,30) /* 개별 테이타 추출 조건 where*/
 group by deptno, job
having sum(sal) >=2500 /* 집계 이휴 데이타 추출 조건 having */
 order by deptno, job
 
/* 과제 p.174 ~ p.175 잊기전에 한번더(ch06) */ 
 
/* rollup, cube */
select deptno, job, count(*), max(sal), sum(sal), avg(sal)
  from emp
 group by deptno, job
 order by deptno, job
 ;
 
/* 소계/합계 구하기 rollup(그룹바이 기준) n+1 조합 */ 
select deptno, job, count(*), max(sal), sum(sal), avg(sal)
  from emp
 group by rollup(deptno, job);
 
/* 단계 그룹별 소계/합계 cube(그룹바이 기준) 2^n 조합 */ 
select deptno, job, count(*), max(sal), sum(sal), avg(sal)
  from emp
 group by cube(deptno, job)
 order by deptno,job;
 
 
/* 그룹핑 셋 deptno별 집계, job집계 */
select deptno, job, count(*)
  from emp
 group by grouping sets(deptno,job)
 order by deptno, job
 ;
 
/* grouping(칼럼) 그룹이 되어 있으면 0, 그룹이 안 되어 있으면 1 */
select deptno, job, count(*), max(sal), sum(sal), min(sal), grouping(deptno), grouping(job)
from emp
group by cube(deptno, job)
order by deptno, job
;

/* grouping_id(여러 개 칼럼)
 * (a,b) : (0,0) -> 0, (1,0) -> 1, (0,1) -> 2, (1,1) -> 3  */
select	deptno, job, count(*), sum(sal),
		grouping(deptno),
		grouping(job),
		grouping_id(deptno, job)
from emp
group by cube(deptno, job)
order by deptno, job
;

/* LISTAGG */
select	deptno,
		listagg(ename,',')
		within group(order by sal desc) as enames
from	emp
group by deptno;

/* pivot */
select * from(select deptno, job, sal from emp)
pivot(max(sal) for deptno in (10,20,30) )
order by job;

/* uppivot - 세로 출력 */
select deptno,
max(decode(job, 'CLERK', sal)) "CLERK",
max(decode(job, 'SALESMAN', sal)) "SALESMAN",
max(decode(job, 'PRESIDENT', sal)) "PRESIDENT",
max(decode(job, 'MANAGER', sal)) "MANAGER",
max(decode(job, 'ANALYST', sal)) "ANALYST"
from emp
group by deptno
order by deptno
;