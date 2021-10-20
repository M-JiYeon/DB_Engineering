-- 중복 결과 하나로 표현하기
-- 사원들의 부서번호를 조회하세요. 단 각 부서마다 한번만 출력되게 하세요.
select
    DISTINCT deptno, ename
from
    emp
ORDER BY
    deptno
;


/*
    quiz ]
        급여가 800, 950 아닌 사원들의 
        사원이름, 급여를 조회하세요.
        다중값 비교연산자를 사용하세요.
*/

SELECT
    ename 사원이름, sal 급여
FROM
    emp
WHERE
--    sal != 800
--    AND sal <> 950
--    NOT sal IN (800, 950)
    sal NOT IN (800, 950)
;

/*
    NULL 데이터 처리함수
        NVL(컬럼이름, 대체값)
        NVL2(컬럼이름, 연산식, 대체값)
*/

/*
    참고 ]
        집합연산자
            ==> 완벽한 두개 이상의 SELECT 질의 명령을 이용해서
                그 결과를 다시 만들어내는 방법
                
            형식 ]
                SELECT
                    ....
                UNION : 중복결과 한번만 표현 ( | UNION ALL : 중복결과 표현 | INTERSECT | MINUS )
                SELECT
                    .....
*/
insert into 
    emp(empno, ename, job, mgr, sal, deptno)
VALUES(8000, 'CLERK', 'CLERK', 2450, 2450, 10)
;


SELECT
    ename 사원이름, sal 급여
FROM
    emp
WHERE
    deptno = 10
UNION ALL
SELECT
    job, mgr
FROM
    emp
WHERE
    deptno = 10
;



/*
    ex 1]
        커미션이 없는 사원들의 
            사원이름, 직급, 입사일을 조회하세요
*/
SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM
    emp
WHERE
    comm IS NULL
;
/*
    사원들의 사원이름, 직급, 입사일을 조회하는데
    급여가 많은 사원이 먼저 출력되도록하고 급여가 같으면
    이름으로 오름차순 정렬해서 출력하세요..
*/
SELECT
    ename 사원이름, job 직급, hiredate 입사일, sal 급여
FROM
    emp
ORDER BY
    sal DESC, ename ASC
;

/*
    20번 부서의 사원들 중 
    급여가 3000 또는 800인 사원들의
    사원이름, 부서번호, 급여를 조회하세요.
*/

SELECT
    ename 사원이름, deptno 부서번호, sal 급여
FROM
    emp
WHERE
    deptno = 20
    AND 
    (
        sal = 3000
        OR
        sal = 800
    )
    -- sal IN (3000, 800)
;

-- 테이블 추가
@C:\db\script\educationmanagement.sql
@C:\db\script\personmanagement.sql
@C:\db\script\salesmanagement.sql
@C:\db\script\videoshop.sql

SELECT
    empno, ename, sal * 1.15 급여
FROM
    emp
ORDER BY
    급여
;


select stu_no, stu_name, stu_dept, stu_weight-5 as target
from student
order by stu_dept, target;

select
    power(3, 2) "3의 2제곱"
from
    dual
;

SELECT
    UPPER('aBcdEf gH') 대문자,
    LOWER('aBcdEf gH') 소문자,
    999
FROM 
    dual
;

-- 사원들의 이름과 직급을 조회하는데 '이름 - 직급'의 형식으로 조회하고 각단어의 첫글자만 대문자로..
-- 참고 ] '이름 - 직급' 라는 데이터는 3개의 데이터를 결합해서 만들어야 한다.
SELECT
    CONCAT(
        CONCAT(ename, ' - '), 
        job
    ) 사원
FROM
    emp
;

SELECT
    SUBSTR('abcd efg hij', 5, 5) "잘라낸 문자열"
FROM
    dual
;

SELECT
    ename, LENGTH(ename) 이름문자수
FROM
    emp
;

SELECT
    INSTR('abcd ab ab', 'a', 2, 2) a위치
    -- INSTR(문자데이터, 찾을문자[, 검색시작위치, 빈도수])
FROM
    dual
;

-- 사원들의 이름을 조회해서 10글자로 표현하는데 남는 공간에 '*'로 표시하세요.
SELECT
    LPAD(ename, 10, '*') 왼쪽, RPAD(ename, 10, '#') 오른쪽
    -- LPAD(데이터, 길이, 채울문자)
FROM
    emp
;

SELECT
    SYSDATE 현재시각
FROM
    DUAL
;

SELECT
    SYSDATE - 10  -- 날자.시간
FROM
    dual
;

-- 충남대학교 개교이후 몇개월이 지났는지 조회하세요.
SELECT
    FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('1952/05/25', 'YYYY/MM/DD'))) 개교이후개월수
FROM
    dual
;

SELECT
    NEXT_DAY('2021/10/19', 2) 담주월요일
FROM
    dual
;

-- 오늘에서 3개월 더한 날짜
SELECT ADD_MONTHS(SYSDATE, 3) FROM dual;

-- 내년 2월의 마지막 일 조회
SELECT LAST_DAY('2022/02/01') FROM dual;

SELECT ROUND(SYSDATE, 'HH') 반올림, TRUNC(SYSDATE, 'HH') 버림 FROM DUAL;

/*
    날짜 데이터 표시형식
        구분문자중 /, -, , 등은 오라클이 자동으로 인식해서 형변환해준다.
        
        년도 - YYYY
        월 - MM
        일 - DD
        시 - HH | HH24
        분 - MI
        초 - SS
*/

-- 형변환함수
-- 사원들의 입사일을 '0000년 00월 00일' 의 형식으로 조회하세요.
SELECT
    ename, TO_CHAR(hiredate, 'YYYY') || '년 ' || TO_CHAR(hiredate, 'MM') || '월 '  
    || TO_CHAR(hiredate, 'dd') || '일' 입사일
FROM
    emp
;

-- 급여를 15% 인상해서 소수 두째자리까지 조회하세요. 예 ] 123.10

/*
    숫자를 문자로 표현할때 사용되는 문자
        0   - 무효숫자는 표시
        9   - 무효숫자도 표현하지 않는다.
        ,
        .
*/
SELECT
    ename 사원이름, sal 원급여, 
    TO_CHAR(sal * 1.15, '99,999,999.99') 인상급여1,
    TO_CHAR(sal * 1.15, '00,000,000.00') 인상급여2
FROM
    emp
;


SELECT
    NVL(NULLIF('A', 'a'), 'B')
FROM
    DUAL
;

/*
    DECODE
        조건 처리함수
        형식 ]
            DECODE(컬럼이름, 데이터1, 실행문1,
                            데이터2, 실행문2,
                            데이터3, 실행문3,
                            ....
                            데이터N, 실행문N
                    실행문)
*/


/*
    직급이 'SALESMAN' 이면 급여의 10%
            'CLERK'이면 급여의 15%
            'MANAGER'면 급여의 1%
            인상하고 이외의 경우는 기존 급여로 조회하세요.
*/

SELECT
    ename 사원이름, job 직급, sal 원급여,
    DECODE(job, 'SALESMAN', sal * 1.1,
                'CLERK', sal * 1.15,
                'MANAGER', sal * 1.01,
            sal
    ) 변경후급여
FROM
    emp
;

SELECT
    ename 사원이름, job 직급, sal 원급여,
    CASE WHEN job = 'SALESMAN' THEN sal * 1.1
         WHEN job = 'CLERK' THEN sal * 1.15
         WHEN job = 'MANAGER' THEN sal * 1.01
        ELSE sal
    END 변경후급여1,
    CASE job WHEN'SALESMAN' THEN sal * 1.1
         WHEN 'CLERK' THEN sal * 1.15
         WHEN 'MANAGER' THEN sal * 1.01
        ELSE sal
    END 변경후급여2
FROM
    emp
;

SELECT
    ename 이름, 
    CASE when ename > 'S' THEN CONCAT('Mr.',ename) 
        ELSE '--- ' || ename || ' ---'
    END 수정된이름
FROM
    emp
;

-- 급여를 10% 인상후 1200 보다 낮은 사원들 조회
SELECT
    ENAME, SAL* 1.1
FROM
    EMP
WHERE
--  SAL * 1.1 < 1200
    TO_CHAR(sal) LIKE '1%'
;

SELECT
    *
FROM
    EMP
WHERE
    1 = 2
;


--------------------------------------------------------------------------------
/*
    EX 1]
        사원의 이름이 'M' 이전의 문자로 시작하는 사원들의
            이름, 직급, 급여를 조회하세요.
        참고 - M으로 시작하는 사원 포함 안함
*/

/*
    EX 2]
        입사일이 1981년 9월 8일 인 사원의
            이름, 직급, 입사일을 조회하세요.
*/

/*
    EX 3]
        사원들중 이름이 'M'이후의 문자로 시작하는 사원들 중
        급여가 1000 이상인 사원들의
            사원이름, 직급, 급여
        를 조회하세요. 
*/

/*
    EX 4]
        직급이 'MANAGER'가 아닌 사원들의
            사원이름, 직급, 입사일을 조회하세요.
        연산자로 처리하세요.
*/

/*
    EX 5]
        사원의 이름이 'C' 이후의 문자로 시작하고 'M' 이전의 문자로 시작하는 사원들의
        사원이름, 직급, 입사일을 조회하세요.
        
        BETWEEN 연산자 사용
*/


/*
    EX 6]
        사원의 이름이 'S' 로 시작하고
        이름의 문자수가 5글자인 사원들의
            사원이름, 직급
        을 조회하세요.
*/

/*
    EX 7]
        입사일이 3일인 사원들의
            사원이름, 입사일을 조회하세요.
*/

/*
    EX 8]
        사원이름의 글자수가 4 또는 5 글자인 사원들의
        사원이름, 입사일을 조회하세요.
*/

/*
    EX 9]
        입사년도가 81년 82년인 사원들의 
        사원이름, 입사일, 급여를 조회하세요.
*/

/*
    EX 10]
        이름이 'S'로 끝나는 사원들의
            이름, 급여, 커미션
        을 조회하세요.
        단, 커미션은 100을 더하고 없는 사람도 100 을 지급하세요.
*/

/*
    BONUS 1]
        사원들의 이름을 조회하는데
        결과를 두번째 문자만 보여주고 
        나머지 문자는 '*' 출력되게 조회하세요.
        
        예 ]
            사원이름 | 출력이름
            SMITH   | *M***
            KING    | *I**
*/

/*
    BONUS 2]
        입력된 이메일을 보여주려고 한다.
        다음형식으로 보여지도록 하세요.
        
        입력메일            |   출력메일
        abcde@naver.com    |    *****@*****.com
        efgh@danawa.co.kr  |    ****@******.co.kr
        
        
        abcde@naver.com    |    a****@*a***.com
        
*/
