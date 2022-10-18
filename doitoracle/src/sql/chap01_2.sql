select * from dba_users;
/*물리적 공간 확인*/
desc dba_users
select * from dba_data_files;
/*논리적 공간 확인*/
select * from dba_tablespaces;
select*from user_indexes;
/*사용자 인덱스 정보
primary key는 주키로 사용, 인덱스(빠른 검색)로도 사용*/

create index ind_dept
on dept(dname);
/* index 생성
 * create index 인덱스명 on 테이블(칼럼) */


select * from dept where dname='SALES';
/*생성된 인덱스에 해당하는 칼럼을 기준으로 조회*/

select * from emp;
select * from dept;
select * from salgrade;

create view emp_dept_salInfo as
select empno, ename, job, sal, dname, loc, grade
from emp, dept, salgrade
where emp.deptno = dept.deptno
and emp.sal between salgrade.losal and salgrade.hisal;

select * from user_views;
/*생성된 view 확인*/
select * from emp_dept_salInfo;
/*view로부터 조회*/

/*민감한 정보를 제외한 칼럼으로만 view 생성*/
create view emp_info
as
select empno, ename, job, deptno
from emp;
/*view로부터 공개된 정보 조회*/
select * from emp_info;

/*시퀀스 생성*/

create sequence seq_no;
/*접속한 유저가 생성한 모든 오브젝트 정보 조회*/
select * from user_objects order by object_type;

/*시퀀스로부터 값 조회 */
/*select 값(식|함수) from 테이블;*/
select 'hello' from emp;
/*hello가 emp의 크기만큼 나옴.*/
select 'hello' from dept;
/*dept로하면 4개 나옴. dept의 크기 만큼*/
select 'hello' from dual;
select sysdate from dual;
select 10*3/5 from dual;
/*dual의 행은 1개. 따라서 1개 출력*/

select seq_no.nextval, seq_no.currval from dual;

/* 시노님(동의어) 생성 */
create synonym myEmp
for scott.emp;

select * from myEmp;

/* 프로시저 생성*/
create or replace procedure pro_noparam
is
v_empno number(4):=7788;
v_ename varchar2(10);
begin
	v_ename := 'SCOTT';
	dbms_output.put_line('v_empno : '||v_empno);
	dbms_output.put_line('v_ename : '||v_ename);
end;

/*함수 생성*/
create or replace function func_aftertax(
sal in number/* 입력되는 매개변수 선언*/
)
return number /* 리턴할 타입 선언 */
is
tax  number:=0.05;
begin
	return (round(sal-(sal*tax)));
end func_aftertax;

/*함수 실행 */
select func_aftertax(10000) from dual;

create table a(col1 varchar2(10));
create table b(col1 varchar2(10));
insert into a values('hello');
insert into b values('hello');
select * from a;
select * from b;
/* a테이블에 값이 insert되면 b에도 자동 insert 되게 trigger 작성 */
/* :old.col1<-입력 전인 old한 col1의 값은 null, :new.col1 <-입력 후인 new한 col1의 값은 'hello' */
/* 1)삭제일 경우
   :old.col1<-삭제 전인 old한 col1의 값은 'hello', :new.col1 <- null
   2)수정일 경우 'hello' -> hi
   :old.col1 <- 'hello' , :new.col1 <- 'hi'
*/
create or replace trigger trg_insrt_a
after /*트리거 발생 시점 입력 직후*/
insert on a/*insert <- 이벤트(입력), a<-테이블명*/
for each row
begin
	insert into b(col1) values (:new.col1);
end ;

select * from user_triggers;

insert into a(col1) values ('hello kim');
insert into a(col1) values ('hi kim');
insert into a(col1) values ('bye kim');
select * from a;
select * from b;

alter trigger trg_insrt_a  disable;
alter trigger trg_insrt_a enable;