/* 데이터 정의의 Data Definition Language(DDL) 
 * 데이터 저장소(table), 데이터 타입, 데이터 최대 길이
 *  */

/* create table 테이블명 (칼럼명 타입,); */
create table emp_ddl(
empno number(4),
ename varchar2(10),
job varchar(9),
mgr number(4),
hiredate date,
sal number(7,2),
comm number(7,2),
deptno number(2)
);

desc emp_ddl

insert into emp_ddl
	values(1111, '홍길동', 'MANAGER', 9999, SYSDATE, 5000, NULL, 20,'5678');
insert into emp_ddl
	values(2222, '임꺽정', 'SALESMAN', 1111, SYSDATE, 3000, 1000, 30);
insert into emp_ddl
	values(3333, '일지매', 'SALESMAN', 1111, SYSDATE, 3000, 1000, 30);

select * from emp_ddl;

rollback /* 그 전 commit 시점으로 되돌리는 명령어. create가 DDL이므로 create가 마지막 저장 위치라고 이해 */
commit/* commit했기 때문에 rollback해도 데이터 롤백 작동 안됨 */
truncate table emp_ddl; /* 데이터 직접 반영 -> roll back 불가 . truncate가 DDL이므로 */
rollback

/******** table 수정
 ******** alter table 변경 작업 ********/

/* table 칼럼 변경
 * alter table 테이블명 modify */
alter table emp_ddl modify empno number(5);
select * from emp_ddl;
alter table emp_ddl modify empno number(3);
alter table emp_ddl modify empno number(4);

/* 칼럼 추가
 * alter table 테이블명 add 칼럼 타입(길이) */
alter table emp_ddl add hp varchar(20);

/* 칼럼명 바꾸기
 * alter table 테이블명 rename 이전명 to 새로운명*/
alter table emp_ddl rename column hp to tel;

/* 칼럼 삭제
 * alter table 테이블명 drop column 칼럼명 */
alter table emp_ddl drop column tel;

/* 테이블명 변경
 * rename 이전 테이블명 to 바꿀 테이블명*/
rename emp_ddl to emp_myddl;
select * from emp_myddl;