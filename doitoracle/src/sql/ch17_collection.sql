
 
/*  컬렉션 */
declare
 type ITAB_EX is table of varchar2(20) 
 index by PLS_INTEGER;
 
 text_arr ITAB_EX;
 
begin
	text_arr(1) :='1st data';
	text_arr(2) :='2nd data';
	text_arr(3) :='3rd data';
	text_arr(4) :='4th data';
	
	dbms_output.put_line('text_arr(1) : '||text_arr(1));
	dbms_output.put_line('text_arr(2) : '||text_arr(2));
	dbms_output.put_line('text_arr(3) : '||text_arr(3));
	dbms_output.put_line('text_arr(4) : '||text_arr(4));
end;
/

/************* 레코드와 컬렉션 **************************/
declare
  type REC_DEPT is record(
  deptno dept.deptno%type,
  dname dept.dname%type
  );
  type ITAB_EX is table of REC_DEPT  
  index by PLS_INTEGER; -- binary_integer
  dept_arr ITAB_EX;
  idx PLS_INTEGER :=0;
BEGIN
	for i in (select deptno, dname from dept) loop
	   idx := idx+1;
	   dept_arr(idx).deptno :=i.deptno;
	   dept_arr(idx).dname :=i.dname;
	   dbms_output.put_line(dept_arr(idx).deptno||
	     ' : '||dept_arr(idx).dname);
	end loop;
END;
/
/* ---------- 컬렉션 함수들--------------------------- */
declare
type ITAB_EX is table of varchar2(20)
 index by PLS_INTEGER;
 
 text_arr ITAB_EX;
begin
	text_arr(1) :='1st data';
	text_arr(2) :='2nd data';
	text_arr(3) :='3rd data';
	text_arr(50) :='50th data';
	
 dbms_output.put_line('text_arr.COUNT: '||text_arr.COUNT);
 dbms_output.put_line('text_arr.FIRST: '||text_arr.FIRST);
 dbms_output.put_line('text_arr.LAST: '||text_arr.LAST);
 dbms_output.put_line('text_arr.PRIOR(50): '||text_arr.PRIOR(50));
 dbms_output.put_line('text_arr.NEXT(50): '||text_arr.NEXT(50));
		
end;
/