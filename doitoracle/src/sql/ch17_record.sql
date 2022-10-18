/*---- 레코드(다른타입의 데이타형을 묶어놓은자료구조) ------*/
/* type 타입면 is record(타입1,타입2,...);*/
declare
  type REC_DEPT is record(
   deptno number(2) not null := 99,
   dname dept.dname%type,
   loc dept.loc%type
  );
  /* 변수명 타입 */
dept_rec REC_DEPT;  
begin
	dept_rec.deptno :=99;
	dept_rec.dname := 'DATABASE';
	dept_rec.loc := 'SEOUL';
	DBMS_OUTPUT.PUT_LINE('deptno : '||dept_rec.deptno);
	DBMS_OUTPUT.PUT_LINE('dname : '||dept_rec.dname);
	DBMS_OUTPUT.PUT_LINE('loc : '||dept_rec.loc);
end; 

/* --------- 레코드 타입을 사용한 insert ----------------- */
create table dept_record
as
select * from dept;

select * from dept_record;

/* 입력 */
declare
  type REC_DEPT is record(
   deptno number(2) not null := 99,
   dname dept.dname%type,
   loc dept.loc%type
  );
  dept_rec REC_DEPT;
begin
	dept_rec.deptno :=99;
	dept_rec.dname :='DATABASE';
	dept_rec.loc :='SEOUL';
	
	insert into dept_record
	values dept_rec;
end;
/


select * from dept_record;

/* 수정 */
declare
  type REC_DEPT is record(
   deptno number(2) not null := 99,
   dname dept.dname%type,
   loc dept.loc%type
  );
  
  dept_rec REC_DEPT;
begin
	dept_rec.deptno :=50;
	dept_rec.dname :='DB';
	dept_rec.loc :='SEOUL';
	
	update dept_record
	   set row = dept_rec /* row - 해당행의 모든 열 적용*/
	 where deptno = 99; 
end;
/
  
select * from dept_record;


/* 조회 */
declare
 type REC_DEPT is record(
   deptno dept.deptno%type,
   dname  dept.dname%type,
   loc    dept.loc%type
 );
 type REC_EMP is record(
   empno emp.empno%type,
   ename emp.ename%type,
   dinfo  REC_DEPT /* 중첩레코드 */
 );
 emp_rec REC_EMP;
begin
	select e.empno, e.ename, d.deptno, d.dname, d.loc
	  into emp_rec.empno,emp_rec.ename,
	       emp_rec.dinfo.deptno,
	       emp_rec.dinfo.dname,
	       emp_rec.dinfo.loc
	  from emp e, dept d
	 where e.deptno = d.deptno
	   and e.empno = 7788;
	   
	dbms_output.put_line('EMPNO :'||emp_rec.empno);   
	dbms_output.put_line('ENAME :'||emp_rec.ename);   
	dbms_output.put_line('DEPTNO :'||emp_rec.dinfo.deptno);   
	dbms_output.put_line('DNAME :'||emp_rec.dinfo.dname);   
	dbms_output.put_line('LOC :'||emp_rec.dinfo.loc);   
end;
/