/* DML - insert 0 */
/* 기존 테이블로 새로운 테이블 생성
 * create table 새로운 테이블명 as select문
 * where 거짓 조건 - 빈 테이블만 생성 
 * where 거짓 조건 사용하면 기존 테이블 참고하여
 * 새 테이블 만들었을 때에 칼럼만 따라오고,
 * 값(내용)은 사라져 빈 테이블 생성됨.*/
 create table dept_temp
 as
 select * from dept where 1=0;
 select * from dept_temp;
 
/* 10번 테이블 */
create table dept_10
as
select * from dept where deptno = 10;
select * from dept_10;

select * from dept_temp;

/*insert int 테이블명(칼럼1, 칼럼2, 칼럼3) values(값1, 값2, 값3);*/
insert into dept_temp(deptno, dname, loc)
	values(10,upper('accounting'),upper('new york'))
;

/* insert into 테이블명 values(값1, 값2, 값3);*/
insert into dept_temp
	values(20, 'RESEARCH', 'DALLAS');

/*insert into 테이블명(칼럼3,칼럼1,칼럼2) values(값3,값1, 값2);*/
insert into dept_temp(loc, deptno, dname)
	values('CHICAGO', 30, 'SALES');
/* alter table dept_temp modify
 * loc varchar2(20) default 'BOSTON' not null; */
/* insert into 테이블명(칼럼1, 칼럼2) values(값3,값1,값2);*/
insert into dept_temp(deptno, dname)
	values(40,'OPERATIONS');
	
insert into dept_temp(deptno, dname)
	values(50,'OPERATIONS2');
	
insert into dept_temp(deptno, dname, loc)
	values(60,'OPERATIONS3','NEW YORK');
/* 명시적 null값 저장 */
insert into dept_temp(deptno, dname)
values(70,NULL); 

create table dept_temp2
as
select *from dept;

select * from dept_temp2;
/* 명시적 null값 입력 */
insert into dept_temp2 values(70,'WEB',NULL);
/* 암시적 null값 입력 */
insert into dept_temp2 (deptno, dname)
values (80,'MOBILE');


/*날짜 데이터 입력*/
create table emp_temp
as select * from emp
where 1=0;

select * from emp_temp;
/* 직접 문자열로 입력 */
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm,deptno)
values(1111,'성춘향','MANAGER',9999,'2001-01-05',4000,NULL,20);

insert into emp_temp/*처음에 선언한 emp_temp 순서대로 작성하므로 칼럼명은 작성하지 않아도 됨.*/
values(9999,'홍길동','PRESIDENT',NULL,'2001/01/01',5000,1000,10);

insert into emp_temp
values(2111,'이순신','MANAGER',9999,'07/01/2001',4000,NULL,20);/*실행 안 됨. 왜냐면 날짜 포맷이 바뀌었기 때문*/

insert into emp_temp
values(2111,'이순신','MANAGER',9999,TO_DATE('07/01/2001','dd/mm/yyyy'),4000,NULL,20);/*실행 안 됨. 왜냐면 날짜 포맷이 바뀌었기 때문*/

/* sysdate 을 이용한 입력 */
select sysdate from dual;
insert into emp_temp
values(3111, '심청이','MANAGER',9999,sysdate,4000,NULL,30);


/* 1. */
create table emp_temp2
as
select * from emp where 1=0;

select * from emp_temp2;
/* 2. */
alter table emp_temp2 add grad number(1);

select * from emp_temp2;
/* 기존테이블의 쿼리결과를 테이블에 삽입
 * insert into 테이블명
 * select문 ;*/
insert into emp_temp2
select empno, ename, job, mgr, hiredate, sal,
	   comm, deptno, grade
  from emp, salgrade
 where emp.sal between losal and hisal
;
/*
 * select 문;
 */
create table emp_dept_grade
    as
select empno,ename,emp.deptno,dname,sal,grade
  from emp,dept,salgrade
 where emp.deptno = dept.deptno
   and sal between losal and hisal
   and 1= 0;
/* 생성된 테이블 조회 */
select * from emp_dept_grade;
/* 기존 데이터를 select하여 테이블에 입력 */
insert into emp_dept_grade
select empno,ename,emp.deptno,dname,sal,grade
  from emp,dept,salgrade
 where emp.deptno = dept.deptno
   and sal between losal and hisal
   and emp.deptno = 10
;


/* update 테이블 */

create table dept_temp2
as
select * from dept;

select * from dept_temp2;
/* UPDATE 테이블명 SET 칼럼 = 새로운값 */
update dept_temp2
   set loc = 'NEW YORK'
;

select dept_temp2.deptno, dept.loc
from dept, dept_temp2
where dept.deptno(+) = dept_temp2.deptno
;

update dept_temp2
   set loc = 'NEW YORK'
 where deptno = 10
;

update dept_temp2
   set loc = 'DALLAS'
 where deptno = 20
;

update dept_temp2
   set loc = 'CHICAGO'
 where deptno = 30
;

update dept_temp2
   set dname = 'e',
       loc = 'swon'
 where deptno = 40
;

update dept_temp2
   set loc = 'NULL'
 where deptno IN (70,80);
;

select * from dept_temp2;

insert into dept_temp2 values(70,'WEB',NULL);
insert into dept_temp2 values(80,'MOBILE',NULL);

select deptno from dept_temp2 where deptno=70;

delete from dept_temp2
where deptno = 70
and rownum=1
;

delete from dept_temp2
 where deptno = 80
 and rownum =1
;

/* 칼럼 1개 수정 */
update dept_temp2
   set loc = 'SEOUL'
 where deptno=70
;

update dept_temp2
   set loc = 'SEOUL'
 where deptno=70
;

/* 칼럼 2개 수정
 * update 테이블명
 * set 칼럼1=값, 칼럼2=값2 ,....
 * where 조건 */
update dept_temp2
   set dname = 'INTERNET',
       loc = 'PANGYO'
 where deptno = 80;
;

/* 서브쿼리로 데이터 수정 */
update dept_temp2
   set (dname,loc)=(select dname, loc
                   from dept
                   where deptno = 40)
 where deptno=40
;

update dept_temp2
   set dname=(select dnamec
                from dept
                where deptno = 40)
        loc= (select loc
              from dept
              where deptno = 40)
1 where deptno=40
;


select * from dept_temp2

/* update 값 직접 입력, select로 수정 */
update dept_temp2
   set loc='SEOUL';
       dname=(select dname from dept where deptno=40)
 where deptno=40;
;

/* where 조건에 sub쿼리 사용 */
update dept_temp2
   set loc ='PANGYO'
 where deptno = (select deptno
                   from dept_temp2
                  where dname='RESEARCH')
;

/* 데이터 삭제 delete from 테이블 where 조건 */
select * from emp_temp;

delete from emp_temp where job ='PRESIDENT';

/* 삭제 조건에 sub 쿼리 사용 */
/* 급여등급 3등급이고, 부서번호 30인 사원 정보 삭제*/
select * from emp_temp2
select * from salgrade


/* 위 조건에 맞는 쿼리 추출 (서브쿼리로 사용) */
select empno
  from emp, salgrade
 where emp.sal between losal and hisal
   and emp.deptno=30
   and salgrade.grade=3
;
/* 위 조건대로 쿼리 삭제한 테이블 */
delete from emp_temp2
where empno in
            (select empno
               from emp, salgrade
              where emp.sal between losal and hisal
                and emp.deptno=30
                and salgrade.grade=3
             );
             
/* 전체 데이터 삭제 */
delete from emp_temp;
select * from emp_temp;

/* Data Manipulation Language */
/* select(retrieve), insert(create), update, delete
 * CRUD
 *  */
