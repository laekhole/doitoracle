select * from emp;
select*from emp where deptno=30;
select * from emp where empno=7782; 
/* AND */
select*from emp where deptno=30 and job ='SALESMAN';
select*from emp where empno=7499 and deptno=30;
/* OR */
select*from emp where deptno=30 or job ='CLERK';
select*from emp where deptno=30;
select*from emp where job='CLERK';

/* 부서번호가 20이거나(or) 직업(job)이 SALESMAN인 사원 정보 출력 */
select * from emp where deptno=20 or job='SALESMAN';
select*from emp where deptno=20;
select*from emp where deptno='SALESMAN';

/* 대소 비교 연산 */
select * from emp where sal >= 3000;

/* 급여가 2500 이상이고(and) 직업(job)이 analyst인 사원 정보 */
select * from emp where sal>=2500 and job='ANALYST';

/* 문자 대소 비교 (비교문자열이 하나인 경우) */
select * from emp where ename >= 'F';

/* 문자 대소 비교(비교문자열이 여러 개인 경우) */
select * from emp where ename <= 'FORZ';

/* 등가 비교 다름 */
select * from emp where sal != 3000;
select * from emp where sal <> 3000;
select * from emp where sal ^= 3000;

/* 논리 부정 not 연산자 */
select * from emp where not sal=3000;

/* or 연산자로 여러개 조건 출력 */
select * from emp
where job='MANAGER' or job='SALESMAN' or job ='CLERK';

select * from emp where deptno = 20 or deptno=10;

/* IN연산자로 출력 */
select * from emp
where job in ('MANAGER', 'SALESMAN', 'CLERK');

select * from emp where deptno in (10,20);

/* IN 연산자와 논리 부정 연산자로 출력 */
select * from emp
where not job in ('manager', 'salesman', 'clerk');

/* 비교연산, AND */
/* 급여(SAL)가 2000~3000 사이인 사원*/
select * from emp where sal >= 2000 and sal <= 3000;

select * from emp where sal >= 2000 or sal <= 3000;
/* between A and B */
select * from emp where sal between 2000 and 3000;

/* 사원 이름의 첫글자가 S인 사원 */
select * from emp where ename like 'S%';

/* 사원 이름의 두번째 글자가 L인 사원 */
select * from emp where ename like '_L%';

/* 사원 이름 중에 'AM'이 들어있는 사원 */
select * from emp where ename like '%AM%';

/* 사원 이름 중에 'AM'이 들어있지 않은 사원 */
select * from emp where not ename like '%AM%';

/* NULL값 비교 IS NULL, IS NOT NULL */
select * from emp where comm = null; /* null은 =로 비교 불가 */
select * from emp where comm is null;
select * from emp where mgr is not null;

/* NULL이 있는 칼럼의 비교 연산 */
select * from emp where sal > null;
select * from emp where sal > null and comm is null;
select * from emp where sal > null or comm is null;

/* 연산자 */
select ename, sal, sal*12 + nvl(comm,0) as annSal, comm from emp;

/* 직속상관(mgr)이 있는 사원만 출력 */
select * from emp where mgr is not null;

/* and와 is null 연산자 사용 */
select * from emp where sal>null;


/*집합 연산 */
/* UNION */
select empno, ename, sal, deptno
  from emp
 where deptno=10
 union
select empno, ename, sal, deptno
  from emp
 where deptno=20
 ;
/* 출력되는 두 쿼리의 칼럼수가 다른경우 - 오류 
 * ORA-01789: query block has incorrect number of result columns*/
select empno, ename, sal
  from emp
 where deptno=10
 union
select empno, ename, sal,deptno 
  from emp
 where deptno=20;
 
/* 두 쿼리의 칼럼 데이타입이 다른 경우 - 오류 
 * ORA-01790: expression must have same datatype as corresponding expression*/
 select empno, sal, ename,deptno
  from emp
 where deptno=10
 union
select empno, ename, deptno, sal
  from emp
 where deptno=20;
 
/* 동일쿼리문으로 union= A+B -(A and B) */
select empno, ename, sal, deptno
  from emp where deptno=10
union
select empno, ename, sal, deptno
  from emp where deptno=10
  ;
  
/* union all = A + B*/  
select empno, ename, sal, deptno
  from emp where deptno=10
union all
select empno, ename, sal, deptno
  from emp where deptno=10
  ;

 /* 중복 제거 */
select 10, 'hello', sysdate
 from dual
union  
select 10, 'hello', sysdate
 from dual;
/* 중복 포함 */
select 10, 'hello', sysdate
 from dual
union all
select 10, 'hello', sysdate
 from dual;
 
 
/* 칼럼개수 다른경우 숫자인경우 처리 */
select empno, ename, sal, 99
  from emp
 where deptno=10
 union
select empno, ename, sal, deptno 
  from emp
 where deptno=20;

 /* 칼럼개수 다른경우 문자인 경우 처리 */
 select empno, 'noName', sal, deptno
  from emp
 where deptno=10
 union 
select empno, ename, sal, deptno 
  from emp
 where deptno=20;
 
 /* 차집합 */
select 10, 'hello', sysdate
 from dual
minus 
select 10, 'hello', sysdate
 from dual;
 
select empno, ename, sal, deptno
  from emp where deptno=10
minus
select empno, ename, sal, deptno
  from emp where deptno=10
  ; 

  /* A - (A AND B) */
select mgr, job
  from emp where deptno=10
minus
select mgr, job
  from emp where deptno=20
  ; 
/* B - (A AND B) */  
select mgr, job
  from emp where deptno=20
minus
select mgr, job
  from emp where deptno=10
  ;  
 
/* 교집합 intersection */
select empno, ename, sal, deptno
 from emp
intersect
select empno, ename, sal, deptno
 from emp where deptno=10;
 
 
/* 연산자 우선순위 
 * ()
 * *,/
 * +,-
 * =, !=, <>=, ^=, >,>=,<,<=
 * is null, is not null, like , not like, in, not in
 * between A and B
 * not 
 * and
 * or
 * */

/* 1) emp 테이블에서 사원이름(ename) S로 끝나는 사원 모두 출력 */
select * from emp where ename like '%S';

/* 2) 30번 부서(deptno)에서 근무하는 사원 중 직책(job)이 SALESMAN인
 * 사원의 사원번호, 이름, 직책, 급여, 부서번호 출력*/
select empno, ename, job, sal, deptno from emp where deptno=30 and job = 'SALESMAN'

/* 3) 20번 부서, 30번 부서에 근무하는 사원 중 급여가 2000 초과인 사원 출력 
 * 사원 번호, 이름, 직책, 급여, 부서번호 
 * 1. 집합연산자를 사용하지 않은 방식(or, and, 비교연산 사용)
 * 2. 집한 연산자를 사용하는 방식(union, union all) */
select * from emp where sal > 2000 and (deptno=20 or deptno=30);

/* 4) 급여열(sal)값이 2000이상 3000이하 범위 이외의 값을 가진 데이터 */
select * from emp where not sal>=2000 and sal<=3000;
select * from emp where not sal between 2000 and 3000;

/* 5) 사원 이름에 E가 포함된 30번 부서의 사원 중 급여가 1000~2000 사이인
 * 사원의 이름, 사번, 급여, 부서번호 출력 */
select ename, empno, sal, deptno from emp where sal between 1000 and 2000 
union
select ename, empno, sal, deptno from emp where ename like '%E%'
/* 6) 추가수당(comm)이 존재하지 않고 상급자가 있고 직책이 MANAGER,CLERK인
 * 사원 중 사원 이름의 두번째 글자가 L이 아닌 사원 정보*/

select *
from emp
where comm is null
and mgr is not null
and job in ('Manager', 'clerk')
and ename not like '_L%";'