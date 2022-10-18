/* 자료형 변환 함수 */
/* ORA-01722: invalid number 문자열과 숫자 +연산 오류 */
select 'abcd' + empno, empno
  from EMp
 where ename ='SCOTT';

 /* 숫자형 문자열 인 경우 +연산가능 */
select empno, ename, empno+'500'/* '500'이 숫자형 문자열 */
  from emp
 where ename ='SCOTT'
 ;
 
/* 날짜 -> 문자열로 변환 함수 */
select to_char(sysdate,'yyyy/MM/DD hh24:MI:SS') as 현재날짜시간
  from dual;
  
select sysdate,
	   to_char(sysdate,'yyyy') as year,
       to_char(sysdate,'MM') as MM,
       to_char(sysdate,'MON') as MON,/*JUN, JUL*/
       to_char(sysdate,'MONTH') as MONTH,/* JUNE, JULY */
       to_char(sysdate,'DD') as DD,/* 월 날짜*/
       to_char(sysdate,'DDD') as DDD,/*년의 날짜*/       
       to_char(sysdate,'DY') as DY,/* 요일 수 */
       to_char(sysdate,'DAY') as DAY,/* 요일 수요일*/
       to_char(sysdate,'WW') as week,/* 년중 주 수 */
       to_char(sysdate,'W') as week /* 월중 주 수*/

  from dual;
  
/* 지역화 코드 출력 */
select sysdate,
       to_char(sysdate,'MM') as MM,
       to_char(sysdate,'DD') as DD,
       to_char(sysdate,'DY','NLS_DATE_LANGUAGE=KOREAN') as DY,/* 요일 수 */
       to_char(sysdate,'DY','NLS_DATE_LANGUAGE=JAPANESE') as DY,/* 요일 수 */
       to_char(sysdate,'DY','NLS_DATE_LANGUAGE=ENGLISH') as DY,/* 요일 수 */
       to_char(sysdate,'DAY','NLS_DATE_LANGUAGE=KOREAN') as DAY,/* 요일 수요일*/
       to_char(sysdate,'DAY','NLS_DATE_LANGUAGE=JAPANESE') as DAY,/* 요일 수요일*/
       to_char(sysdate,'DAY','NLS_DATE_LANGUAGE=ENGLISH') as DAY/* 요일 수요일*/
  from dual;  
  
/* TO_CHAR(날짜시간, 시간포맷) */
select sysdate,
       to_char(sysdate,'HH24:MI:SS'),
       to_char(sysdate,'HH12:MI:SS AM'),
       to_char(sysdate,'HH:MI:SS P.M.')
  from dual;
       
  
/* 통화(currency) */
select sal,
       to_char(sal, '$999,999'),
       to_char(sal, 'L999,999'),
       to_char(sal, '999,999.00'),
       to_char(sal, '000,999,999.00'),
       to_char(sal, '000999999.99'),
       to_char(sal, '999,999,00')
  from emp;
  
/* 문자 -> 숫자변환 함수 */  
select 1300 - '1500', '1300' + 1500 from dual;  
/* ,가 포함되어서 숫자로 변환 불가 - 오류 */
select '1,300' - '1,500' from dual;

/* to_number(숫자형문자열, 검증포맷)*/
select to_number('1,300','999,999') - to_number('1,500','999,999') 
 from dual;
 
 
/* 문자 -> 날짜변환 함수 */
select to_date('2018-07-14','yyyy-mm-dd')
 from dual;
 
select to_date('20180714','yyyy-mm-dd')
 from dual;
 
/* where 조건에서 날짜 비교 */ 
select * from emp where hiredate > '1981/06/01';
select * from emp where hiredate > to_date('1981/06/01','yyyy/mm/dd');

/* 포맷 */
select to_date('49/12/10','yy/mm/dd'),
       to_date('49/12/10','RR/mm/dd'),
       to_date('50/12/10','yy/mm/dd'),
       to_date('50/12/10','RR/mm/dd'),
       to_date('51/12/10','yy/mm/dd'),
       to_date('51/12/10','RR/mm/dd')
  from dual;
 
/* null인 경우 값 처리 
 * nvl함수()
 * */
select empno, ename, sal, comm, sal+comm, nvl(comm,0), sal+nvl(comm,0)
  from emp;
  
/* nvl2(값, 정상 ,null인 경우 값)
 * */ 
select empno, ename, comm, nvl2(comm,'O','X'),
       nvl2(comm,sal*12+comm ,sal*12)
  from emp; 
 
/* decode(칼럼,첫번째조건,첫번째값,두번째조건,두번째값,...,DEFAULT), case */
select empno, ename, job, sal,
       decode(job, 'MANAGER',SAL*1.1,
                   'SALESMAN',SAL*1.05,
                   'ANALYST',SAL,
                   SAL*1.03)
   from emp;
   
/* decode(), 급여가 1000미만이면 1, 급여가 1000초과 2000미만 2, 
 * 2000초과 3000미만 3, 3000초과 5 */   
select empno, trunc(sal/1000), sal,
       decode(trunc(sal/1000),0,1,1,2,2,3,5)
  from emp order by sal;   
 
 
/* case 값 WHEN 조건 THEN 값1 WHEN 조건2 THEN 값2...ELSE 디폴트값 END AS 칼럼명 */
select empno, ename,
       job,sal,
       case job
       when 'MANAGER' THEN SAL*1.1
       WHEN 'SALESMAN'THEN SAL*1.05
       WHEN 'ANALYST' THEN SAL
       ELSE SAL*1.03
       END AS UPSAL
FROM EMP;       

/* case WHEN 조건1 THEN 값1 WHEN 조건2 THEN 값2,.. ELSE 디폴트 END AS 칼럼명 */
select empno, ename,
       job,sal,
       case 
       when job= 'MANAGER' THEN SAL*1.1
       WHEN job='SALESMAN'THEN SAL*1.05
       WHEN job='ANALYST' THEN SAL
       ELSE SAL*1.03
       END AS UPSAL
FROM EMP;    

select empno, ename, comm, 
       case
        when comm is null then '해당사항 없음'
        when comm = 0 then '수당없음'
        when comm > 0 then '수당:'||comm
        end  as comm_text
   from emp;
   
   
/* 급여(sal)이 1000미만이면 'a'등급, 1000이상 2000미만이면 'b',
 * 2000이상 3000미만 'c' 3000이상이면 's' 으로 출력 */   
select empno,
       ename,
       sal,
       case 
       when sal < 1000 then 'a'
       when sal >= 1000 and sal<2000 then 'b'
       when sal >= 2000 and sal<3000 then 'c'
       else 's'
       end as "등급"
 from emp;


select empno,
       ename,
       sal,
       case trunc(sal/1000)
       when 0 then 'a'
       when 1 then 'b'
       when 2 then 'c'
       else 's'
       end as "등급"
 from emp;

 
 
 
 
 
 
 
 

  
  
  

       
  

 
 
 
 
 
 
