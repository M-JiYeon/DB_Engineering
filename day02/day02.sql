SELECT 
    ename 사원이름, sal 원급여, TO_CHAR(sal * 1.15, '99,999,999.99') 인상급여1,
    TO_CHAR(sal * 1.15, '00,000,000.00') 인상급여2
FROM emp;

-- (nullif(A, B), '널 값‘) A / B가 같으면 NULL 반환 다르면 A반환

SELECT NVL(NULLIF('A', 'A'), 'B') FROM dual;

/*
    조건처리 함수
        DECODE(컬럼 이름, 데이터1(조건), 실행문1,
                         데이터2, 실행문2,
                         ... ,
                         데이터N, 실행문N,
                         나머지 경우 실행문)
*/

-- 직급이 'SALSEMAN'이면 급여 10% 인상
-- 직급이 'CLERK'이면 급여 15% 인상
-- 직급이 'MANAGER'이면 급여 1% 인상
-- 나머지는 기존 급여(인상 X)
SELECT 
    ename 사원이름, job 직급, sal 기존급여,
    DECODE(job, 'SALESMAN', sal * 1.1,
                'CLERK', sal * 1.5,
                'MANAGER', sal * 1.01,
                sal) 인상급여
FROM emp;

SELECT 
    ename 사원이름, job 직급, sal 기존급여,
    CASE WHEN job = 'SALESMAN' THEN sal * 1.1
         WHEN job = 'CLERK' THEN sal * 1.5
         WHEN job = 'MANAGER' THEN sal * 1.01
         ELSE sal
    END 인상급여
FROM emp;

SELECT 
    ename 사원이름, job 직급, sal 기존급여,
    CASE job WHEN 'SALESMAN' THEN sal * 1.1
             WHEN 'CLERK' THEN sal * 1.5
             WHEN 'MANAGER' THEN sal * 1.01
             ELSE sal
    END 인상급여
FROM emp;

-- 급여를 10% 인상 후 1200보다 낮은 사람들 조회
SELECT ename, sal * 1.1
FROM emp
WHERE (sal * 1.1) < 1200
;

SELECT * 
FROM emp
WHERE 1 = 1 -- where절은 반환되는 값이 논리값이면 됨. 결과 집합은 없어
;

-- 급여를 10% 인상후 1200보다 낮은 사원들 조회
SELECT ename, sal * 1.1
FROM emp
WHERE
    -- SAL * 1.1 < 1200
    TO_CHAR(sal) LIKE '1%'
;

/*
    EX 1]
        사원의 이름이 'M' 이전의 문자로 시작하는 사원들의
        이름, 직급, 급여를 조회하세요.
        참고 - M으로 시작하는 사원 포함 안함
*/
SELECT ename 사원이름, job 직급, sal 급여
FROM emp
WHERE ename < 'M%'
;

/*
    EX 2]
        입사일이 1981년 9월 8일 인 사원의
        이름, 직급, 입사일을 조회하세요.
*/
SELECT ename 사원이름, job 직급, hiredate 입사일
FROM emp
WHERE hiredate = '1981/09/08'
;

/*
    EX 3]
        사원들중 이름이 'M'이후의 문자로 시작하는 사원들 중
        급여가 1000 이상인 사원들의
        사원이름, 직급, 급여를 조회하세요. 
*/
SELECT ename 사원이름, job 직급, sal 급여
FROM emp
WHERE ename > 'M%' and sal >=1000
;

/*
    EX 4]
        직급이 'MANAGER'가 아닌 사원들의
        사원이름, 직급, 입사일을 조회하세요.
        연산자로 처리하세요.
*/
SELECT ename 사원이름, job 직급, hiredate 입사일
FROM emp
WHERE job NOT IN('MANAGER')
;

/*
    EX 5]
        사원의 이름이 'C' 이후의 문자로 시작하고 'M' 이전의 문자로 시작하는 사원들의
        사원이름, 직급, 입사일을 조회하세요.
        
        BETWEEN 연산자 사용
*/
SELECT ename 사원이름, job 직급, hiredate 입사일
FROM emp
WHERE ename BETWEEN 'C%' AND 'M%'
;

/*
    EX 6]
        사원의 이름이 'S' 로 시작하고
        이름의 문자수가 5글자인 사원들의
        사원이름, 직급을 조회하세요.
*/
SELECT ename 사원이름, job 직급
FROM emp
WHERE ename like 'S%' AND LENGTH(ename) = 5
;

/*
    EX 7]
        입사일이 3일인 사원들의
        사원이름, 입사일을 조회하세요.
*/
SELECT ename 사원이름,  hiredate 입사일
FROM emp
WHERE TO_CHAR(hiredate, 'DD') = '03'
;

/*
    EX 8]
        사원이름의 글자수가 4 또는 5 글자인 사원들의
        사원이름, 입사일을 조회하세요.
*/
SELECT ename 사원이름, hiredate 입사일
FROM emp
WHERE LENGTH(ename) = 4 OR LENGTH(ename) = 5
;

/*
    EX 9]
        입사년도가 81년 82년인 사원들의 
        사원이름, 입사일, 급여를 조회하세요.
*/
SELECT ename 사원이름, hiredate 입사일, sal 급여
FROM emp
WHERE TO_CHAR(hiredate, 'YYYY') LIKE '%81' OR 
      TO_CHAR(hiredate, 'YYYY') LIKE '%82'
;

/*
    EX 10]
        이름이 'S'로 끝나는 사원들의
        이름, 급여, 커미션을 조회하세요.
        단, 커미션은 100을 더하고 없는 사람도 100 을 지급하세요.
*/
SELECT ename 이름, sal 급여, NVL(comm+100, 100) 커미션
FROM emp
WHERE ename LIKE '%S'
;

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
SELECT ename || ' | ' || 
       CONCAT(,인수2)  "사원이름 | 출력이름"
FROM emp
;

/*
    BONUS 2]
        입력된 이메일 다음형식으로 보여줘
        
        입력메일             |     출력메일
        abcde@naver.com     |     *****@*****.com
        efgh@danawa.co.kr   |     ****@******.co.kr
        
 심화       
        
        abcde@naver.com     |     a****@*a***.com
        efgh@danawa.co.kr   |     ****@******.co.kr
*/
SELECT 
FROM emp
WHERE
;



