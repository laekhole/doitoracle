/* emp 테이블의 모든 열 출력하기 */
select * from emp;

/* 부서번호가 30인 데이터만 출력 */
select * from emp where deptno=30;

/* 사원번호가 7782인 사원정보 */
select * from emp where empno=7782;

/* and 연산자로 여러개 조건식 사용하기 */
select * from emp where deptno=30 and job='SALESMAN';

/* AND */
/* 사원번호가 7499이고(AND) 부서번호가 30인 사원정보 출력 */
SELECT * FROM EMP WHERE EMPNO=7499 AND DEPTNO=30;

/* OR */
select * from emp where deptno=30 or job='CLERK';
select * from emp where deptno=30;
select * from emp where job='CLERK';

/* 부서번호가 20이거나(or) 직업(job)이 SALESMAN인 사원 정보 출력 */
select * from emp where deptno=20 or job='SALESMAN';
select * from emp where deptno=20;
select * from emp where job='SALESMAN';

/* 대소 비교연산 */
select * from emp where sal >=300;

/* 급여가 2500이상 이고(and) 직업(job)이 analyst인 사원 정보 */
select * from emp where sal>=2500 and job='ANALYST';

/* 문자 대소 비교(비교문자열이 하나인 경우) */
select * from emp where ename >='F';

/* 문자 대소 비교(비교문자열이 여러개 인 경우) */
select * from emp where ename <='FORZ';

/* 등가 비교 다름 */
select * from emp where sal !=3000;
select * from emp where sal <> 3000;
select * from emp where sal ^=3000;

/* 논리 부정 not 연산자 */
select * from emp where not sal=3000;

/* or 연산자로 여러개 조건 출력 */
select * from emp 
 where job='MANAGER' or job='SALESMAN' or job='CLERK';

select * from emp where deptno = 20 or deptno=10;
select * from emp where mgr=7839 or mgr=7788;
 /* IN 연산자로 출력 */
select * from emp 
 where job in ('MANAGER','SALESMAN','CLERK');
 
select * from emp where deptno in (10,20); 
select * from emp where mgr in (7839,7788);

/* 등가비교연산자와 and 연산자로 출력 */
select * from emp where job !='MANAGER' AND JOB <> 'SALESMAN' AND JOB ^='CLERK';

/* IN 연산자와 논리 부정 연산자로 출력 */
select * from emp 
        where NOT JOB IN ('MANAGER','SALESMAN','CLERK');

        
        
/* 비교연산, AND */
/* 급여(SAL)가 2000 ~ 3000사이인 사원 */
select * from emp where sal >=2000 and sal<=3000;
select * from emp where sal < 2000 or sal >3000;
/* between A(최소) and B(최대) */
select * from emp where sal between 2000 and 3000;
select * from emp where not sal between 2000 and 3000;

/* like와 와일드카드문자 */
select * from emp where ename like 'S%';/*S로 시작하는 이름 */
/* 사원이름의 두 번째 글자가 L인 사원만 출력하기 */
select * from emp where ename like '_L%';
/* 사원이름 중에 'AM'이 들어간 사원 */
select * from emp where ename like '%AM%';
/* 이름의 세번째 글자가 M인 사원 출력*/
select * from emp where ename like '__M%';
/* 이름이 S로 끝나는 사원 출력 */
select * from emp where ename like '%S';

/* 사원이름 중에 'AM'이 들어있지않는 사원 */
select * from emp where not ename like '%AM%';

/* NULL값 비교 IS NULL, IS NOT NULL */
select * from emp where comm=null;/* null은 =로 비교 불가 */
select * from emp where comm is null;
select * from emp where mgr is not null;

/* NULL이 있는 칼럼의 비교 연산 */
select * from emp where sal > null;
select * from emp where sal > null and comm is null;
select * from emp where sal > null or comm is null;

/* 연산자 */
select ename, sal, sal*12 + nvl(comm,0) as annSal, comm
 from emp;

/* 직속상관(mgr)이 있는 사원만 출력 */
select * from emp where mgr is not null;

/* and와 is null 연산자 사용 */
select * from emp where sal> null and comm is null;
select * from emp where sal> null or comm is null;

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
 
/* 1)emp테이블에서 사원이름(ename) S로 끝나는 사원 모두 출력 */
select * from emp where ename like '%S'; 
/* 2)30번 부서(deptno)에서 근무하는 사원 중 직책(job)이 SALESMAN 인
 * 사원의 사원번호, 이름, 직책, 급여, 부서번호 출력 */ 
select empno,ename,job,sal,deptno 
  from emp
 where deptno=30 and job='SALESMAN';
/* 3)20번부서, 30번 부서에 근무하는 사원 중 급여가 2000 초과인 사원 출력 
 * 사원번호, 이름, 직채, 급여, 부서번호
 * 1. 집합연산자를 사용하지 않은 방식(or,and, 비교연산)
 * 2. 집합연산자를 사용하는 방식(union,union all)
 * */ 
/*1 집합연산 미사용 */ 
select empno,ename,job,sal,deptno   
  from emp
 /*where (deptno=20 or deptno=30 )and sal > 2000 */
  where deptno in (20,30)
   and sal > 2000;
/*2. 집합연산 사용 */
select empno,ename,job,sal,deptno   
  from emp
  where deptno =20
   and sal > 2000
union 
select empno,ename,job,sal,deptno   
  from emp
  where deptno =30
   and sal > 2000
;    
/* 4)급여열(sal)값이 2000이상 3000 이하 범위 이외의 값을 가진데이타 */
select * from emp where not sal between 2000 and 3000;
select * from emp where sal < 2000 or sal > 3000;
/* 5)사원이름에 E가 포함된 30번 부서의 사원 중 급여가 1000~2000사이인 
 * 사원의 이름, 사번, 급여, 부서번호 출력 */
select ename, empno, sal,deptno
  from emp
 where ename like '%E%'
   and deptno=30
   and sal between 1000 and 2000;
/* 6)추가수당(comm)이 존재하지않고 상급자가 있고 직책이 
 * MANAGER, CLERK인 
 * 사원 중 사원이름의 두번째 글자가 L이 아닌 사원 정보 */ 
select * 
  from emp   
 where comm is null
   and mgr is not null
   and job in ('MANAGER','CLERK')
   and ename not like '_L%';
 



 
 






