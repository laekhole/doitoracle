/* transaction commit; rollback*/

create table dept_tcl as select * from dept;
/* create table은 DB에 바로 반영됨 DDL
 * 트랜잭션 안에 안 들어가는 명령어 */
select * from dept_tcl;

insert into dept_tcl values(50, 'DATABASE', 'SEOUL');
update dept_tcl set loc = 'BUSAN' where deptno=40;
delete from dept_tcl where dname = 'RESEARCH';

select * from dept_tcl;

/*메모리에서 작업한 내용을 DB에 영구 저장*/
commit

insert into dept_tcl values(60,'WEB','PANGYO');
update dept_tcl set loc = 'JEJU' where deptno=40;
delete from dept_tcl where dname = 'DATABASE';
select * from dept_tcl;
/* ROLLBACK : 앞전 commit 시점 이후 insert,update,delete
 * 작업 내용을 이전 commit 시점으로 되돌림*/
ROLLBACK