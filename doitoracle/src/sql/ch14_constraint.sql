/* 14. 1 */
create table table_null(
login_id varchar2(20),
login_pw varchar2(20),
tel varchar2(20)
);

insert into table_null(login_id, login_pw, tel)
values(null,null,null)
;

select * from table_null
;

insert into table_null(login_id, login_pw, tel)
values('HONG','hong',null)
;

insert into table_null(login_id, login_pw)
values('HONG','1234')
;

insert into table_null(login_pw, tel)
values('1234','010-111-1234')
;

insert into table_null
values('kim','1234')
; /* 실행 안 됨. ()생성자 없이 value를 입력하므로 table_null의 column 형식에 맞게 집어 넣어줘야 하는데,
     values 뒤에 값이 문자열 2개 뿐이라 문자열 3개가 되지 않아 입력이 되지 않는 것 */

insert into table_null
values('kim','1234','010-111-1234')
;

commit
/* 무결성 제약 조건 */
/* 1. 영역 무결성(domain integrity)
 *    - 자료형, 형식 데이터, null 여부 지정한 형식에 맞는지 체크
 * 2. 개체 무결성(entity integrity)
 *    - 테이블의 데이터 유일 식별 키(기본키는 null이 되면 안됨)
 * 3. 참조 무결성(referential integrity)
 *    - 외래키 값은 참조 테이블의 기본키로서 존재해야 함. null 가능
 */
create table table_notnull(
login_id varchar2(20) not null,
login_pw varchar2(20) not null,
tel varchar2(20) not null
);

insert into table_notnull(login_id, login_pw, tel)
values(null,null,null)
;

select * from table_notnull
;

insert into table_notnull(login_id, login_pw, tel)
values('HONG','hong',null)
;

insert into table_notnull(login_id, login_pw)
values('HONG','1234')
;

insert into table_notnull(login_pw, tel)
values('1234','010-111-1234')
;

insert into table_notnull
values('kim','1234')
; /*  */

insert into table_notnull
values('kim','1234','010-111-1234')
;

commit

/* not null 저장한 칼럼의 데이터를 update로 null로 변경*/
select * from table_notnull;
/* ORA-01407: cannot update ("SCOTT"."TABLE_NOTNULL"."LOGIN_PW") to NULL (0 rows affected) */
update table_notnull
set login_pw=null
where login_id='kim'
;
/* 제약조건 조회 user_constraints */
select * from user_constraints
where constraint_name not like 'BIN%'
;

/* 사용자 정의 제약 조건명 */
/* constraint 제약조건명 제약조건 */
create table table_notnull2(
login_id varchar2(20) constraint tblnn2_lgnid not null,
/* tblnn2_lgnid는 정해진 명령어가 아님. 교재에 나와 있듯 제약 조건 이름을 직접 지정한 형태. nn은 not null 의미*/
login_pw varchar2(20) constraint tblnn2_lgnpw not null,
/* 제약조건 이름을 정해주지 않으면 SYS_C007000~7002 같은 무슨 의미인지도 모르는 제약조건이 임의로 생성됨.
 * 이는 user_constraints 함으로써 확인할 수 있음. constraint_name.*/
tel varchar2(20)
);

create table table_notnull0(
login_id varchar2(20) not null,
login_pw varchar2(20) not null,
tel varchar2(20) 
);

/* 제약 조건 변경 alter table */
alter table table_notnull0 modify (tel not null);

alter table table_notnull modify (tel not null);
/* ORA-01442: column to be modified to NOT NULL is already NOT NULL (0 rows affected) */
update table_notnull
   set tel ='010-1111-1234'
 where login_id='hong';
 commit
select * from table_notnull;

commit
select * from table_notnull
;

select * from table_null;

/* not null 칼럼 제약조건 명 */
select * from table_null;

update table_null
set login_id ='kim'
where login_id is null
and rownum = 1
;


update table_null
set login_id ='kang'
where login_id is null
and rownum = 1
;

alter table table_null
modify (login_id constraint tblN_notnull not null)
;


/* 제약조건 조회 user_constraints */
select * from user_constraints
where constraint_name not like 'BIN%'
;

/* 제약조건 명 변경 */
/* alter table 테이블명 rename 이전제약조건명 to 새로운 제약조건명 */
/* 값을 수정할 땐 update지만 제약 조건을 수정할 땐 alter table을 이용해야 함*/
alter table table_null
rename constraint tblN_loginid_noutnull to tbl_tel_nn;

alter table table_null
rename constraint tbl_tel_nn to tbl_id_nn;

/* 제약 조건 삭제 */
/* drop constraint 제약조건명 */
alter table table_null
drop constraint tbl_id
;

create table table_unique(
id varchar2(20) unique,
pwd varchar2(20) not null,
tel varchar2(20)
);

insert into table_unique
values ('hong', '1234', '010-111-1234')
;


/* ORA-00001: unique constraint (SCOTT.SYS_C007009) violated */
insert into table_unique
values ('hong', '1234', '010-111-1234')
;

/* unique 제약 조건은 null 입력(중복) 입력 가능 */
insert into table_unique
values ('null', '1234', '010-111-1234')
;

select * from table_unique;

/* 테이블의 id는 primary key, tel은 unique 제약조건 */
create table table_tel_unique(
id varchar2(20) primary key,
pwd varchar2(20),
tel varchar2(20) unique
)
;

insert into table_tel_unique
values ('hong', '1234', '010-111-1234')
;

/* tel이 unique 걸려 있는데 hong과 tel 같으므로 실행 x
 * ORA-00001: unique constraint (SCOTT.SYS_C007011) violated */
insert into table_tel_unique
values ('kim', '1234', '010-111-1234')
;

/* primary key(기본키, 주키) 가 중복 되어 실행 x
 * ORA-00001: unique constraint (SCOTT.SYS_C007010) violated */
insert into table_tel_unique
values ('hong', '1234', '010-111-5678')
;

insert into table_tel_unique
values ('kang', '1234', '010-111-5678')
;

select * from table_tel_unique
;


/* 제약조건 조회 user_constraints */
select * from user_constraints
where constraint_name not like 'BIN%'
;

/* 제약 조건 삭제
 * alter table 테이블명 drop constraint 제약조건명*/
alter table table_tel_unique drop constraint SYS_C007011
;

/* 테이블 생성 후 제약 조건 추가하기 */
alter table table_tel_unique modify (tel constraint tbl_unique_tel unique)
;

/* 제약조건 이름 변경 */
alter table table_tel_unique
rename constraint tbl_unique_tel to tbl_tel_unique;

/* primary key 제약 조건 ( not null + unique) */
create table table_pk(
id varchar2(20) primary key,
pwd varchar2(20) not null,
tel varchar2(20)
)
;


/* 제약조건 조회 user_constraints */
select * from user_constraints
where table_name = 'TABLE_PK'
;

insert into table_pk
values ('hong','1234',null)
;
/* ORA-00001: unique constraint (SCOTT.SYS_C007014) violated */
insert into table_pk
values ('hong','1234','010-111-1234')
;

/* ORA-01400: cannot insert NULL into ("SCOTT"."TABLE_PK"."ID") */
insert into table_pk
values (null,'1234','010-111-1234')
;

/* 제약조건 조회 user_constraints */
select * from user_constraints
where table_name = 'TABLE_PK2'
;

/* primary key 이름 부여 */
create table table_pk2(
id varchar2(20) constraint tblpk2_id_pk primary key,
pwd varchar2(20) constraint tblpk2_pwd_nn not null,
tel varchar2(20)
);

/* 테이블 생성 및 제약조건 이름 부여 한번에 */
create table table_pk3(
id varchar2(20),
pwd varchar2(20) not null,
tel varchar2(20),
primary key(id),
constraint tbl_pwd_nn unique(pwd) /* not null은 쓸 수 없음 오류남..*/
);

/* 복합키로 primary key(기본키, 주키) 생성시
 * (primary key 2개 생성하는 방법)
 * 실패하는 예
 * ORA-02260: table can have only one primary key */
create table table_pk4(
id varchar2(20) primary key,
pwd varchar2(20) primary key,
tel varchar2(20)
)
;

/* 복합키로 primary key(기본키, 주키) 생성시
 * (primary key 2개 생성하는 방법)
 * 성공하는 예 */
create table table_pk4(
id varchar2(20),
sno varchar2(20),
pwd varchar2(20),
tel varchar2(20),
primary key(id,sno) /* primary key(칼럼1, 칼럼2 ,...)*/
)
;

/* Foreign key 제약 조건
 * 부모테이블의 주키가 자식테이블의 속성으로 참조되는 키
 * 부모테이블(참조되는 테이블) */
drop table dept_fk;
create table dept_fk(
deptno number(2) constraint deptfk_deptno_pk primary key,
dname varchar2(14),
loc varchar2(13)
);

/* 자식테이블(참조하는 테이블) */
create table emp_fk(
empno number(4) constraint emp_fk_empno_pk primary key,
ename varchar2(10),
job varchar2(9),
mgr number(4),
hiredate date,
sal number(7,2),
comm number(7,2),
/* constraint 제약명 references 테이블(칼럼) */
deptno number(2) constraint empfk_deptno_fk 
                 references dept_fk(deptno)

);

/* 부모테이블에 데이타 입력 */
insert into dept_fk values(10,'Accounting','서울시');
select * from dept_fk;
/* 
ORA-02291: integrity constraint (SCOTT.EMPFK_DEPTNO_FK) violated - parent key not found*/
insert into emp_fk
values(9999,'홍길동','MANAGER',null, 
       to_date('2001/01/01','yyyy/mm/dd'),3000,null,10);
/* null */
insert into emp_fk
values(9998,'일지매','ANALYST',null, 
       to_date('2001/01/01','yyyy/mm/dd'),3000,null,null);
       
select * from emp_fk;

insert into dept_fk values(20,'SALES','수원시');
select * from dept_fk;
/* foreign key로 지정된 칼럼의 데이타를 null 
 *              -> 부모테이블의 domain값으로 update */
update emp_fk
   set deptno =20
 where empno = 9998;
 
select * from emp_fk;       

select * from user_constraints;

/* foreign key제약조건이 적용된 부모테이블 삭제 */
/*ORA-02292: integrity constraint (SCOTT.EMPFK_DEPTNO_FK) violated - child record found */
delete from dept_fk where deptno=10;

/* alter table 테이블명 disable constraint 제약조건명*/
alter table emp_fk 
disable constraint empfk_deptno_fk;

/* 제약조건이 비활성화 된 상태에서 부모테이블 삭제 */
delete from dept_fk where deptno=10;

alter table emp_fk 
enable constraint empfk_deptno_fk;

select * from dept_fk; 
select * from emp_fk; 

/*참조하는 자식테이블 데이터 부터 먼저 삭제 */
delete from emp_fk where deptno=10;
delete from dept_fk where deptno=10;

/* 제약조건 생성시 on delete 옵션추가 */
select * from user_constraints 
 where table_name=upper('emp_fk');

 /* emp_fk테이블의 foreign key 제약 조건 삭제 */
alter table emp_fk 
drop constraint empfk_deptno_fk;

/* 참조되는 부모테이블의 칼럼값 삭제시 참조하는 모든 자식 테이블의
 * 해당칼럼값이 삭제 */
/* alter table 테이블명
 * add constraint 제약조건면
 * foreign key(칼럼)
 * references 부모테이블(부모칼럼)
 * on delete cascade;--참조하는 자식테이블의 행삭제
 * */
alter table emp_fk
add constraint empfk_deptno_fk 
foreign key(deptno)
references dept_fk(deptno)
on delete cascade;

select * from dept_fk; 
select * from emp_fk; 

/* on delete cascade 적용 후 부모테이블의 칼럼값 삭제 */
delete from dept_fk where deptno=20;

select * from emp_fk; 

rollback;
       
       
 /* emp_fk테이블의 foreign key 제약 조건 삭제 */
alter table emp_fk 
drop constraint empfk_deptno_fk;

/* 참조되는 부모테이블의 칼럼값 삭제시 참조하는 모든 자식 테이블의
 * 해당칼럼값을 null로 처리 */     
alter table emp_fk
add constraint empfk_deptno_fk 
foreign key(deptno)
references dept_fk(deptno)
on delete set null;       
       
/* 제약조건 생성시 on delete 옵션추가 */
select * from user_constraints 
 where table_name=upper('emp_fk');       
       
       
 /* on delete set null 적용 후 부모테이블의 칼럼값 삭제 */
delete from dept_fk where deptno=20;
select * from dept_fk;
select * from emp_fk;

/* check 제약조건 */
create table table_check(
id varchar2(20) constraint tbl_id_pk primary key,
pwd varchar2(20) constraint tbl_pwd_ck check (length(pwd) >3),
tel varchar2(20)

);

insert into table_check
values ('hong','1234','010-111-1234');
select * from table_check;

/*ORA-02290: check constraint (SCOTT.TBL_PWD_CK) violated */
insert into table_check
values ('kim','123','010-111-1234');

select * from user_constraints;

/* 기본값 지정하는 default */
create table table_default(
id varchar2(20) constraint tblck2_id_pk primary key,
pwd varchar2(20) default '1234',
tel varchar2(20),
regdate date default sysdate
);
select * from table_default;
select * from user_constraints 
  where table_name=upper('table_default');
  
insert into table_default(id,tel)
values('hong','010-111-1234');
select * from table_default;

insert into table_default(id,pwd,tel,regdate)
values('kang','3333','010-111-5678',to_date('2022-10-17','yyyy-mm-dd'));
select * from table_default;


/* 부모테이블에 데이터 입력 */
insert into dept_fk values(10,'Accounting', '서울시')
;
insert into emp_fk
values(9999,'홍길동','MANAGER',null,
                   to_date('2001/01/01','yyyy/mm/dd'),3000,null,10)
;
insert into emp_fk
values(9998,'일지매','ANALYST',null,
                   to_date('2001/01/01','yyyy/mm/dd'),3000,null,Null)
;
insert into dept_fk values(20,'SALES','수원시')
;
select * from dept_fk
;
/* 부모로 지정된 칼럼의 데이터를 null -> 부모테이블의 값으로 update */
select * from emp_fk
;
select * from user_constraints
;
/* foreign key 제약 조건이 적용된 부모테이블 삭제*/
/* ORA-02292: integrity constraint (SCOTT.EMPFK_DEPTNO_FK) violated - child record found 
 * 현재 foreign key로서 dept_fk(deptno=10)이 외래키-부모 column으로 참조되고 있으므로 삭제할 수 없음*/
delete from dept_fk where deptno=10;

/* alter table 테이블명 disable constraint 제약조건명 */
alter table emp_fk
disable constraint empfk_deptno_fk;

/* 제약 조건이 비활성화된 상태에서 부모테이블 삭제  */
alter empfk_deptno_fk disable;

alter table emp_fk
disable constraint empfk_deptno_fk;

/* 제약 조건이 비활성화된 상태에서 부모 테이블 삭제 */
delete from dept_fk where deptno=10;

alter table emp_fk
enable constraint empfk_depto_fk;

/* 참조하는 자식테이블 데이터부터 먼저 삭제 */
delete from emp_fk where deptno=10;
delete from dept_fk where deptno=10;

/* 제약조건 생성시 on delete 옵션 추가*/
select * from user_constraints
where table_name=upper('emp_fk');

/* emp_fk테이블의 foreign key 제약 조건 삭제 */
alter table emp_fk
drop constraint empfk_deptno_fk;

/* 참조되는 부모 테이블의 칼럼값 삭제시 참조하는 모든 자식 테이블의
 * 해당 칼럼 값이 삭제
 * alter table 테이블명
 * add constraint 제약조건명
 * foreign key(지우고자 하는 칼럼)
 * references 부모테이블(부모칼럼)
 * on delete cascade; -- 참조하는 자식 테이블의 행삭제*/

alter table emp_fk
add constraint empfk_deptno_fk
foreign key(deptno)
references dept_fk(deptno)
on delete cascade;

select * from dept_fk;
select * from emp_fk;
rollback

alter table emp_fk
add constraint empfk_deptno_fk
foreign key(deptno)
references dept_fk(deptno)
on delete set null;

/* 제약조건 생성시 on delete 옵션 추가 */
select * from user_constraint
whre table_name = upper('emp_fk')
;

/* on delete set null 적용 후 부모테이블의 값만 삭제*/
delete from dept_fk where deptno=20;

/* check 제약 조건 */
create table table_check(
id varchar2(20) constraint tbl_id_pk primary key,
pwd varchar2(20) constraint tbl_pwd_ck check(length(pwd)>3),
tel varchar2(20)
);

/* 값 입력 */
insert into table_check
values('hong','1234','010-111-1234')
;

select * from table_check;

/* ORA-02290: check constraint (SCOTT.TBL_PWD_CK) violated 
 * check 조건 위반 -> 비밀번호 3자리 초과 조건 위반 */
insert into table_check
values('kim','123','010-111-1234')
;
select * from user_constraints;
select 