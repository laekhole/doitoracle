/* 오라클 함수 upper()대문자, lower()소문자, initcap() 첫글자대문자나머지 소문자*/
select 'hello', upper('hello'),upper('Hello'),
       lower('HELLO'), lower('Hello'),
       initcap('hello'),initcap('Hello')
  from dual;
  
select 'hello gildong', 
       initcap('hello gildong'),initcap('hellogildong')
  from dual;
  
/* where절에서 upper, lower사용 */
select * from emp where upper(ename) = upper('scott');
select * from emp where upper(ename) = 'SCOTT';
select * from emp where ename = upper('scott');

/* LOWER */
select * from emp where lower(ename) ='scott';
select * from emp where lower(ename) =lower('Scott');

/* like 와 같이 사용 */
select * from emp where upper(ename) like upper('%scott%');
select * from emp where upper(ename) like upper('%ot%');
select * from emp where lower(ename) like '%scott%';
select * from emp where lower(ename) like '%ot%';

/* 문자열 길이 length, lengthb */
select ename, length(ename), lengthb(ename) from emp;
select '안녕하세요',length('안녕하세요'), lengthb('안녕하세요') 
  from dual;

select length('한글'), lengthb('한글') from dual;

/* 문자열 길이 where절에서 사용 */
select empno,ename,length(ename) 
  from emp where length(ename) >=5;
  

/* substr()함수 문자열 추출 */
select job, substr(job,1,2), substr(job,3,2), substr(job,5)
  from emp;
/* 음수는 뒤에서 부터 시작 */
select job, substr(job,-length(job)), 
      substr(job,-length(job),2), substr(job,-3)
  from emp;
  
/* instr() 문자열내의 해당 패턴의 시작 위치 번호 */  
select instr('HELLO, ORACLE!', 'L')  as instr_1,
       /* INSTR(문자열,패턴, 시작인덱스번호) */
       instr('HELLO, ORACLE!', 'L', 5)  as instr_2,
       /* INSRT(문자열, 패턴, 시작인덱스, 두번째 발견패턴)*/
        instr('HELLO, ORACLE!', 'L',2,2)  as instr_3,
        instr('HELLO, ORACLE!', 'F') as instr_4
 FROM DUAL;

 /* instr() where에서 사용 */
select * from emp where instr(ename,'S') > 0;
select * from emp where ename like '%S%';

/* replace(문자열,찾는문자열(old), 대체할문자열(new)) */
select '010-1234-5678' as replace_before,
       replace('010-1234-5678','-',' ') as replace_1,
       replace('010-1234-5678','-') as replace_2
  from dual;

/* lpad(대상문자열,전체길이,채울패턴), rpad(대상문자열,전체길이,채울패턴)*/
select 'Oracle',
        lpad('Oracle', 10, '#') as lpad_1,
        rpad('Oracle', 10, '#') as rpad_1,
        lpad('Oracle', 10) as lpad_2,
        length(lpad('Oracle', 10)) as lpad_2_length,
        length(rpad('Oracle', 10)) as rpad_2_length,
        length(trim(lpad('Oracle', 10))) as lpad_2_trim,
        length(trim(rpad('Oracle', 10))) as rpad_2_trim
   from dual;
   
/* rpad()함수를 사용하여 개인정보 뒷자리 마스킹 */
select rpad('971225-',14,'*') as rpad_jmno,
       rpad('010-1234-',13,'*') as rpad_phone
  from dual;

/* 문자열 합치기 a||b, 함수 concat(a,b) */
select empno||ename,
       concat(empno,ename)
  from emp
 where ename =upper('scott');
/* 두개이상의 문자열 합치기 */  
select empno||':'||ename,
       concat(concat(empno,':'),ename)
  from emp
 where ename =upper('scott'); 

/*특정 패턴을 지는 trim, ltrim, rtrim */
/* trim([삭제옵션(선택)leading|trailing|both] [삭제할 문자(선택)] from [타겟문자(필수)])*/
/* trim([삭제옵션(선택)leading|trailing|both] from [타겟문자(필수)])*/
 select'['||trim(' _ _Oracle_ _ ')||']' as trim,
       '['||trim(leading from ' _ _Oracle_ _ ')||']' as trim_leading,
       '['||trim(trailing from ' _ _Oracle_ _ ')||']' as trim_trailing,
       '['||trim(both from ' _ _Oracle_ _ ')||']' as trim_both       
  from dual;
  
/* trim([leading|trailing|both] [삭제할 문자(선택)] from [타겟문자(필수)])*/ 
 select '['||trim('_' from '_ _Oracle_ _')||']' as trim,
        '['||trim('_' from ' _ _Oracle_ _ ')||']' as trim,/*양쪽 안지워 짐*/
        '['||trim(leading '_' from '_ _Oracle_ _')||']' as trim_leading, 
        '['||trim(trailing '_' from '_ _Oracle_ _')||']' as trim_trailing,
        '['||trim(both '_' from '_ _Oracle_ _')||']' as trim_both        
  from dual;

/* ltrim([원본 문자열(필수)],[삭제할 문자집합(선택)])|rtrim([원본 문자열(필수)],[삭제할 문자집합(선택)])*/
select '['||trim(' _Oracle_ ')||']' as trim,
       '['||ltrim(' _Oracle_ ')||']' as ltrim,
       '['||ltrim('<_Oracle_>','_<')||']' as trim_2,
       '['||rtrim(' _Oracle_ ')||']' as rtrim,
       '['||rtrim('<_Oracle_>','>_')||']' as rtrim_2
  from dual;
  
  
  
  
  
 
 
   

 
 
        



