select * from dba_objects order by owner;
select * from user_objects;
select * from all_objects;

/* objects 중 index */
select * from user_indexes;
/* 생성된 index의 칼럼정보 조회 */
select * from user_ind_columns;

select * from emp;
/* 인덱스 생성
 * create index idx_테이블명_칼럼명 on 테이블명(칼럼);
 * */
create index idx_emp_sal on emp(sal);

select * from user_indexes;
select * from user_ind_columns;

select * from dept;

insert into dept values (50,'SALES','JEJU');

delete from dept where deptno=50;
COMMIT

select * from dept where dname ='SALE';

/* 인덱스 삭제 */
drop index ind_dept;
/* create unique index 인덱스명 on 테이블(칼럼) */
create unique index ind_dept on dept(dname);
insert into dept values (50,'SALES','JEJU');
/*ORA-00001: unique constraint (SCOTT.IND_DEPT) violated*/

/* 테이블 생성 시 
 * primary key를 지정하면
 * unique index 가 생성 됨*/
create table emp_imsi(
empno number(4) primary key,/* 중복불가(unique),not null */
ename varchar2(10),
job varchar2(10),
deptno number(2)
);

select * from user_indexes;

select * from user_tables;
select * from dba_tables;
select * from all_tables;

/* view 정보 조회 */
select * from user_views;

/* view 생성 */
create or replace view vw_emp20
as 
select empno, ename, job, deptno
  from emp
  where deptno = 20;

select * from vw_emp20;

/* 단순 view에 대이터 입력 */
insert into vw_emp20 values(8888,'홍길동','MANAGER',20);
  
select * from emp;
/* view 삭제 drop view 뷰명 */
drop view vw_emp20;


/* 읽기 전용 view 생성 */
create or replace view vw_emp20
as 
select empno, ename, job, deptno
  from emp
  where deptno = 20
with read only
;

select * from vw_emp20;
/* ORA-42399: cannot perform a DML operation on a read-only view*/
insert into vw_emp20 values(7777,'임꺽정','MANAGER',20);

/* view 삭제 */
drop view vw_emp20;
/* view 생성 */
create or replace view vw_emp20
as 
select empno, ename, job, deptno
  from emp
  where deptno = 20
with check option
;
select * from vw_emp20;
/* ORA-01402: view WITH CHECK OPTION where-clause violation */
insert into vw_emp20 values(6666,'일지매','MANAGER',30);

/* top-n */
select rownum, e.*
  from (select * from emp order by sal desc) e
 where rownum <=3;
 

 /* top-m~ n */
select a.rn, a.empno, a.ename, a.sal
 from 
(select rownum as rn,emp.*
  from emp
 where rownum <=11
 order by sal desc )a
where rn >5  
order by rn
 ;

 
/* 시퀀스 자동 발번 객체 sequence */
create sequence seq_dept_sequence
increment by 10
start with 10
maxvalue 90
minvalue 0
nocycle
cache 2;

create table dept_sequence 
as 
select * from dept where 1=0;
select * from dept_sequence;
/* sequence 조회 */
select * from user_sequences;
/* sequence를 이용한 데이타 입력 nextval, currval */
/* sequnece의 옵션이 nocycle이므로 더이상 입력불가 */
/* ORA-08004: sequence SEQ_DEPT_SEQUENCE.NEXTVAL exceeds MAXVALUE and cannot be instantiated*/
insert into dept_sequence(deptno,dname,loc)
 values (seq_dept_sequence.nextval,'DATABASE','SEOUL')

select *from dept_sequence;
 
/* cycle옵션 */ 
create sequence seq_dept2_sequence
increment by 10
start with 10
maxvalue 90
minvalue 0
cycle
cache 2;

create table dept2_sequence 
as 
select * from dept where 1=0;

insert into dept2_sequence(deptno,dname,loc)
 values (seq_dept2_sequence.nextval,'DATABASE','SEOUL')

select * from dept2_sequence;

/* 시퀀스 수정 */
alter sequence seq_dept_sequence
increment by 3
maxvalue 99
cycle;

/* 시퀀스 삭제 drop sequence 시퀀스명 */
drop sequence seq_dept_sequence

/* 동의어 synonym */
create public synonym e for emp;
select * from e;

/* 동의어 삭제 drop synonym 시노님명*/
drop synonym e;