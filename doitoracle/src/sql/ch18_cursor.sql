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

/* 파라미터를 사용하는 커서 */
/* cursor 커서명(파라미터 자료형,...) IS  select문... */
declare
   --명시적 커서 선언(declaration)
	cursor c1 (p_deptno dept.deptno%type) is
	  select deptno,dname,loc
	    from dept
	   where  deptno = p_deptno;
  --커서 데이타를 담을 변수 선언
    v_dept_row dept%rowtype;
begin
	 -- open 커서
	 open c1(10);
	 -- fetch 커서
	 loop
	   fetch c1 into v_dept_row;
	   exit when c1%notfound;
	   dbms_output.put_line('10 번부서-deptno'
	           ||v_dept_row.deptno
	           ||'dname-'||v_dept_row.dname
	           ||'loc-'||v_dept_row.loc);
	 end loop;
	 --close 커서
	 close c1;
end;
/

/**-----------------------------------------*/
declare
   --명시적 커서 선언(declaration)
	cursor c1 (p_deptno dept.deptno%type) is
	  select deptno,dname,loc
	    from dept
	   where  deptno = p_deptno;
  --커서 데이타를 담을 변수 선언
    v_dept_row dept%rowtype;
begin
	 -- open 커서
	 open c1(10);
	 -- fetch 커서
	 loop
	   fetch c1 into v_dept_row;
	   exit when c1%notfound;
	   dbms_output.put_line('10 번부서-deptno'
	           ||v_dept_row.deptno
	           ||'dname-'||v_dept_row.dname
	           ||'loc-'||v_dept_row.loc);
	 end loop;
	 --close 커서
	 close c1;
	 -- open 커서
	 open c1(20);
	 -- fetch 커서
	 loop
	   fetch c1 into v_dept_row;
	   exit when c1%notfound;
	   dbms_output.put_line('20 번부서-deptno'
	           ||v_dept_row.deptno
	           ||'dname-'||v_dept_row.dname
	           ||'loc-'||v_dept_row.loc);
	 end loop;
	 --close 커서
	 close c1;
end;
/

 
/*------ 바인딩변수 선언 &변수로 값입력 받기 */
declare
   --명시적 커서 선언(declaration)
	cursor c1 (p_deptno dept.deptno%type) is
	  select deptno,dname,loc
	    from dept
	   where  deptno = p_deptno;
  --커서 데이타를 담을 변수 선언
    v_dept_row dept%rowtype;
    v_deptno dept.deptno%type;
begin
        -- 입력데이타 바인딩변수 선언
        v_deptno := &input_data;
	 -- open 커서
	 open c1(v_deptno);
	 -- fetch 커서
	 loop
	   fetch c1 into v_dept_row;
	   exit when c1%notfound;
	   dbms_output.put_line('10 번부서-deptno'
	           ||v_dept_row.deptno
	           ||'dname-'||v_dept_row.dname
	           ||'loc-'||v_dept_row.loc);
	 end loop;
	 --close 커서
	 close c1;
end;
/