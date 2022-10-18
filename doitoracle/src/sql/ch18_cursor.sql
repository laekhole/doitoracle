/* ch18, cursor - exception */
/* 커서 */
declare
 v_dept_row dept%rowtype;/* detpno,dname,loc */
begin
	select deptno, dename, loc
	  into v_dept_row
	 where deptno =40;
	dbms_output.put_line('deptno: '||v_dept_row.deptno); 
	dbms_output.put_line('dname: '||v_dept_row.dname);
	dbms_output.put_line('loc: '||v_dept_row.loc);
end;
/

/* ---   단일행 커서 저장 -----*/
declare
 --커서데이터 입력받을 변수 선언
 v_dept_row dept%rowtype;
 --1.명시적 커서 선언
 cursor c1 is select deptno,dname,loc 
              from dept where deptno=40;              
begin
	--2. 커서open
	open c1;
	--3. fetch
	fetch c1 into v_dept_row;
	
	dbms_output.put_line('deptno :'||v_dept_row.deptno);
	dbms_output.put_line('dname :'||v_dept_row.dname);
	dbms_output.put_line('loc :'||v_dept_row.loc);
    
	--4. 커서 close
	close c1;
end;
/

/** ---- 여러행 커서 --------*/
declare
 --커서데이터 입력받을 변수 선언
 v_dept_row dept%rowtype;
 --1.명시적 커서 선언
 cursor c1 is select deptno,dname,loc 
              from dept;              
begin
	--2. 커서open
	open c1;
	--3. fetch
    
	loop
		fetch c1 into v_dept_row;
		
		-- %notfound속성으로 반복 빠져나오기
		exit when c1%notfound;
		
		dbms_output.put('deptno :'||v_dept_row.deptno);
		dbms_output.put('dname :'||v_dept_row.dname);
		dbms_output.put_line('loc :'||v_dept_row.loc);
    end loop;
    
 	--4. 커서 close
	close c1;
end;
/

/* for loop */
declare
 --1.명시적 커서 선언
 cursor c1 is select deptno,dname,loc 
              from dept;              
begin
	
	for c1_rec in c1 loop
		dbms_output.put('deptno :'||c1_rec.deptno);
		dbms_output.put('dname :'||c1_rec.dname);
		dbms_output.put_line('loc :'||c1_rec.loc);
    end loop;
    
end;
/