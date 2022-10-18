/*데이터 조회 select문*/
select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp;
/*wildcard문자 *로 전체 칼럼 대체*/
select * from emp;

/*selection*/
select * from emp where empno =7788;

/*projection*/
select empno, ename, job, deptno from emp;

/*select&projection*/
select empno, ename, job, deptno from emp where empno=7788;

/* select 중복*/
select all deptno from emp;
select deptno from emp;
/*중복 배제 select*/
select distinct deptno from emp;

/* 사원테이블(emp)에서 모든 사원 정보 출력 */
/* select 추출할 칼럼리스트 from 테이블명; */
select *
from emp;
/* 사원테이블(emp)에서 모든 사원의 사원번호, 이름, 부서번호 출력 */
select empno, ename, deptno
from emp;
/* 사원테이블(emp)에서 업무별(job) 부서번호(deptno) 종류별 출력*/
select distinct job, deptno
from emp;

/* 칼럼 결과*/
select ename, sal, sal*12+comm, comm
from emp;
/* 의미 : null과 다른 데이터와의 연산 결과는 null이 나옴*/

/* 칼럼 결과 as 별칭 */
select ename, sal, sal*12 as annual, sal*12+comm, comm
from emp;

/* 칼럼 결과 " " 별칭*/
/*별칭이 분리되었을 때 ""로 묶어줌*/
select ename, sal+sal+sal+sal+sal+sal+sal+sal+sal+sal+sal+sal "annual sal", comm
from emp;

/*empno순으로 오름차순 정렬하는 방법*/
/*order by 칼럼명 ascending asc*/
select * from emp order by empno;/*asc이 기본값임을 나타냄*/
select * from emp order by empno asc;
/* 정렬 - 내림차순 order by 칼럼명 descending desc*/
select * from emp order by empno desc;

/*정렬 기준이 두 개 이상인 경우 ,로 구분*/
/*부서번호는 오름차순, 부서별 급여는 내림차순*/
select * from emp order by deptno, sal desc;

/*부서별 오름차순, 업무별 오름차순, 급여별 내림차순, */
select * from emp order by deptno, job, sal desc;

/*칼럼명에 별칭 붙이기
 * empno -> employee_no, ename-> employee_name.
 * mgr -> manager,
 * sal -> salary,
 * comm -> commision,
 * deptno -> department_no
 */
select empno employee_no, ename employee_name, job, mgr manager,
sal salary, comm commision, deptno department_no from emp;