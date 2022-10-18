select file_name, tablespace_name,  bytes/1024/1024 
from dba_data_files;

select * from dba_data_files;

/* tablespace에 물리적인 파일 공간 추가하기 */
alter tablespace users 
add datafile  'C:\\ORACLEXE\\APP\\ORACLE\\ORADATA\\XE\\USERS2.DBF' 
size 100m;


select tablespace_name,  sum(bytes/1024/1024) 
from dba_data_files
group by tablespace_name
;

/* 패스워드 만료 처리 */
alter user scott password expire;

/* scott 유저에서 테이블 생성 */

col1 varchar2(20),
col2 varchar2(20)
);

/* 객체 권한
 * grant 권한 on 객체 to 유저명 */
grant select on temp01 to hr
grant insert on temp01 to hr

select * from temp01;

grant delete on temp01 to hr

/* 권한 회수
 * revoke 권한 on 객체 from 유저명 */
revoke select on temp01 from hr;

/* 한 번에 여러 권한 부여 */
grant select, insert, delete on temp01 to hr;

/* 한번에 여러 권환 회수 */
revoke insert, delete on temp01 from hr;

/* Role 
 * connect - alter session, create */

	declare
v_empno number(4) : = 7788;
v_ename varchar2(20):='JOHN';
v_dname varchar2(20):='ACCOUNTING';
v_grade number:=5;
begin
	select empno, ename, dname, grade
	  from emp, dept, salgrade
	 where emp.deptno = dept.deptno
           and sal between losal and hisal
           and empno=v_empno
dbms_output.put_line('--사원번호 : '||v_empno);
dbms_output.put_line('--사원명 : '||v_ename);
dbms_output.put_line('--부서명 : '||v_dname);
dbms_output.put_line('--급여등급 : '||v_grade);
end;

