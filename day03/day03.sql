/* 
    문제 1]
        사원들의 사원이름, 직급, 부서이름 조회
        10번 부서는 영업부
        20번 부서는 개발부
        30번 부서는 총무부
        그 이외는 운영부로 표현
*/

SELECT ename 사원이름, job 직급, 
    CASE deptno WHEN 10 THEN '영업부'
                WHEN 20 THEN '개발부'
                WHEN 30 THEN '총무부'
                ELSE '운영부'
    END 부서이름
FROM emp ;

SELECT ename 사원이름, job 직급, 
    DECODE(deptno, 10, '영업부', 
                   20, '개발부',
                   30, '총무부',
                       '운영부'
    ) 부서이름
FROM emp
ORDER BY deptno;

/*
    문제 2]
        사원들의 사원이름, 급여, 커미션 조회
        단, 커미션이 없는 사원은 '커미션 없음'으로 표현
*/

SELECT ename 사원이름, sal 급여, NVL(TO_CHAR(comm), '커미션없음') 커미션
FROM emp ;

SELECT 
    ename 사원이름, sal 급여, 
    DECODE(comm, NULL, '커미션없음', 
                        TO_CHAR(comm)
    ) 커미션
FROM emp ;

-- 그룹 함수


-- 20번 부서 사원들과 동일한 직급/을 가진 사원들을 모두 조회. (이름, 직급, 부서번호)
SELECT 
    ename, job, deptno
FROM
    emp
WHERE 
    job IN( -- 이 포함되어 있는 사원
        SELECT -- 20번 부서 사원들의 직급
            DISTINCT job
        FROM 
            emp
        WHERE 
            deptno = 20
    );

-- 사원들의 평균급여, 최대급여, 최소급여, 급여 합계, 사원수 조회
SELECT ROUND(AVG(sal),2) 평균급여, MAX(sal) 최대급여, MIN(sal) 최소급여, SUM(sal) 급여합계, COUNT(*)사원수
FROM emp;

-- 사원들의 이름, 급여, 회사평균급여 조회
SELECT ename, sal, 
    (
        SELECT 
            ROUND(AVG(sal),2) 
        FROM 
            emp
    ) 평균급여
FROM emp;

SELECT
    ename, sal, a
FROM 
    emp,
    (
        SELECT -- 인라인 뷰(서브질의가 from 절안에 들어가 있는 경우)
            ROUND(AVG(sal),2) a
        FROM 
            emp
    )
;

-- 사원들의 사원이름, 급여, 회사평균급여, 최대급여, 최소급여를 조회

SELECT ename, sal, -- 에러
    (
        SELECT 
            ROUND(AVG(sal),2), MAX(sal), MIN(sal)
        FROM 
            emp
    ) 평균급여
FROM emp;

SELECT 
    ename, sal, avg, max, min
FROM 
    emp, (
        SELECT 
            ROUND(AVG(sal),2) avg, MAX(sal) max, MIN(sal) min
        FROM 
            emp
    );


SELECT  -- 바이트 수
    ename, LENGTHB(ename) 바이트수
FROM
    emp ;

SELECT
    LENGTHB('홍길동'), LENGTHB('호'), LENGTHB('홍') FROM dual;
    
-- 부서별 부서이름, 부서 최대급여, 부서 최소 급여, 부서 평균급여
-- 부서별 통계
SELECT 
    deptno dno, MAX(sal) max, MIN(sal) min, ROUND(AVG(sal), 2) avg, COUNT(*) cnt
FROM 
    emp
GROUP BY 
    deptno;

SELECT
    dname 부서이름, max 최대급여, min 최소급여, avg 부서평균급여, cnt 부서원수
FROM
    dept, 
    (
        SELECT 
            deptno dno, MAX(sal) max, MIN(sal) min, ROUND(AVG(sal), 2) avg, COUNT(*) cnt
        FROM 
            emp
        GROUP BY 
            deptno
    )   
WHERE
    deptno = dno;
    
    
/*
    부서원이 제일 적은 부서에 속한 사원들의 
    사원이름, 직급, 부서번호, 급여를 조회
*/
-- 부서 별 인원
SELECT deptno dno, COUNT(*) cnt
FROM emp
GROUP BY deptno;

-- 부서원이 제일 적은 부서번호
-- 부서번호 선택. 부선원 수 테이블에서. cnt가 부선원 수 테이블에서 가장 작은 수와 같은.
SELECT dno
FROM 
    (
        SELECT deptno dno, COUNT(*) cnt
        FROM emp
        GROUP BY deptno
    ) dno_table
WHERE 
    cnt = (
        (
            SELECT MIN(COUNT(*)) cnt
            FROM emp
            GROUP BY deptno
        )
    )
;

-- 문제 답
SELECT ename 사원이름, job 직급, deptno 부서번호, sal 급여
FROM emp
WHERE
    deptno = (
        SELECT dno
        FROM 
            (
                SELECT deptno dno, COUNT(*) cnt
                FROM emp
                GROUP BY deptno
            ) dno_table
        WHERE 
            cnt = 
                (
                    (
                    SELECT MIN(COUNT(*)) cnt
                    FROM emp
                    GROUP BY deptno
                    )
                )
    )
;

/*
    부서 평균급여보다 적게 받는 사원들의 
    사원번호, 사원이름, 부서번호, 급여, 부서평균급여 조회
*/
-- 부서 별 평균 급여
SELECT deptno dno, ROUND(AVG(sal), 2) avg_sal
FROM emp
GROUP BY deptno;

-- 정답
SELECT empno 사원번호, ename 사원이름, deptno 부서번호, sal 급여, avg_sal 부서평균급여
FROM emp, 
    (
        SELECT deptno dno, ROUND(AVG(sal), 2) avg_sal
        FROM emp
        GROUP BY deptno
    )
WHERE deptno = dno AND sal < avg_sal;

-- 제시 답 / 번거로운 버전
SELECT 
    empno 사원번호, ename 사원이름, deptno 부서번호, sal 급여,
    (
        SELECT ROUND(AVG(sal), 2)
        FROM emp
        WHERE deptno = e.deptno
    ) 부서평균급여
FROM emp e
WHERE 
    sal < (
            SELECT AVG(sal)
            FROM emp
            WHERE deptno = e.deptno
            )
;

-- 제시 답
SELECT 
    empno 사원번호, ename 사원이름, deptno 부서번호, sal 급여, ROUND(avg, 2) 평균급여
FROM 
    emp, 
    ( -- 부서번호와 부서의 평균급여만 기억하는 가상의 테이블을 만들어
        SELECT deptno dno, AVG(sal) avg
        FROM emp
        GROUP BY deptno
    )
WHERE 
    deptno = dno -- 조인조건
    AND sal < avg
;

/*
    각 부서별 최소 급여자의 
    사원이름, 부서번호, 급여, 부서최소급여 조회
*/

-- 각 부서 별 최소 급여 액수
SELECT deptno dno, MIN(sal) min_sal
FROM emp
GROUP BY deptno;

-- 정답
SELECT ename 사원이름, deptno 부서번호, sal 급여, min_sal 부서최소급여
FROM emp, 
    (
        SELECT deptno dno, MIN(sal) min_sal
        FROM emp
        GROUP BY deptno
    )
WHERE sal = min_sal; -- 최소 급여자


/*
    사원중 최소급여자가 속한 부서의 사원들의
    사원이름, 부서이름, 부서급여합계, 부서최대급여, 부서최소급여, 부서평균급여
    를 조회하세요.
*/

-- 최소급여자가 속한 부서
SELECT deptno dno
FROM emp
WHERE sal = ( SELECT MIN(sal) FROM emp );

-- 최소급여자가 속한 부서의 부서급여합계, 부서최대급여, 부서최소급여, 부서평균급여
SELECT deptno dno2, SUM(sal) sum, MAX(sal) max, MIN(sal) min, ROUND(AVG(sal), 2) avg
FROM emp
WHERE deptno = 
    (
        SELECT deptno dno
        FROM emp
        WHERE sal = ( SELECT MIN(sal) FROM emp )      
    )
GROUP BY deptno;

-- 정답
SELECT ename 사원이름, dname 부서이름, sum 부서급여합계, max 부서최대급여, min 부서최소급여, avg 부서평균급여
FROM 
    emp e, dept d,
    (
        SELECT deptno dno2, SUM(sal) sum, MAX(sal) max, MIN(sal) min, ROUND(AVG(sal), 2) avg
        FROM emp
        WHERE deptno = 
                (
                    SELECT deptno dno
                    FROM emp
                    WHERE sal = ( SELECT MIN(sal) FROM emp )      
                )
        GROUP BY deptno
    )
WHERE e.deptno = d.deptno AND e.deptno = dno2;


/*
    부서별 급여합계가 가장 높은 부서에 속한 사원들의
    사원이름, 급여, 부서번호 조회
*/
-- 부서 별 급여합계
SELECT deptno dno, SUM(sal) sum
FROM emp
GROUP BY deptno;

SELECT deptno, MAX(sum) max
FROM emp, 
    (
        SELECT deptno dno, SUM(sal) sum
        FROM emp
        GROUP BY deptno
    )

;
    
SELECT ename, sal, deptno
FROM emp, 
    (
        SELECT dno, MAX(sum) max
        FROM (
            SELECT deptno dno, SUM(sal) sum
            FROM emp
            GROUP BY deptno
        )
    )
WHERE 
;

/* 
    각 부서별로 가장 적은 급여가 얼마인지 조회
    (부서번호, 최소급여)
*/

SELECT deptno 부서번호, MIN(sal) 최소급여
FROM emp
GROUP BY deptno;

/*
    부서별 커미션 받는 사람 수를 조회
*/
SELECT deptno 부서번호, COUNT(comm) "커미션 받는 사람 수"
FROM emp
GROUP BY deptno;


/*
    각 직급별로 급여합계, 평균급여 조회
*/
SELECT job 직급, SUM(sal) 급여합계, ROUND(AVG(sal), 2) 평균급여
FROM emp
GROUP BY job;


/*
    입사 년도 별로 평균급여와 급여합계 조회
    년도, 평균급여, 급여합계
*/
SELECT 
    TO_CHAR(hiredate, 'YYYY') 년도, 
    ROUND(AVG(sal), 2) 평균급여, SUM(sal) 급여합계
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');


/*
    각 년도별 입사원 수 조회
*/
SELECT 
    TO_CHAR(hiredate, 'YYYY') 입사년도, COUNT(*) 입사원수
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');


/*
    사원 이름의 글자수가 4글자 또는 5글자인 사원의 수 조회
*/
SELECT LENGTH(ename) 이름글자수, COUNT(*) 사원수
FROM emp
GROUP BY LENGTH(ename)
HAVING LENGTH(ename) IN (4,5);


/*
    1981년도에 입사한 사원들의
    직급 별 사원수
*/
SELECT job 직급, count(*) 사원수
FROM emp
WHERE TO_CHAR(hiredate, 'YYYY') = '1981'
GROUP BY job;

-- 1981년 사원 수
SELECT TO_CHAR(hiredate, 'YYYY') year, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
HAVING TO_CHAR(hiredate, 'YYYY') = '1981'
;


/*
    이름 길이가 4 또는 5 글자인 사원들을 부서 별로 수를 조회
    단, 사원수가 한사람인 부서는 제외하고 조회
*/
SELECT deptno 부서, COUNT(*)사원수
FROM emp
WHERE LENGTH(ename) IN (4,5)
GROUP BY deptno
HAVING COUNT(*) <> 1;


/*
    81년도 입사한 사람들의 직급 별 급여 합계 조회
    단, 직급 별 평균 급여가 1000 미만인 직급은 조회에서 제외.
*/
SELECT job 직급, SUM(sal) 급여합계, ROUND(AVG(sal))평균급여
FROM emp
WHERE TO_CHAR(hiredate, 'YY') = '81'
GROUP BY job
HAVING NOT AVG(sal) < 1000;


/*
    81년도 입사한 사원들의 이름 길이 별 급여합계를 조회.
    단, 합계가 2000 미만인 경우는 제외하고
    합계가 높은 순으로 내림차순 정렬해서 조회.
*/
SELECT LENGTH(ename) 이름길이, SUM(sal) 급여합계
FROM emp
WHERE TO_CHAR(hiredate, 'YY') = '81'
GROUP BY LENGTH(ename)
HAVING NOT SUM(sal) < 2000
ORDER BY SUM(sal) DESC;

---------------------------------------------------------

/* 
    문자열 처리함수
        1) REPLACE() - 문자열의 특정 부분을 다른 문자열로 대체하는 함수
*/
SELECT REPLACE ('HongDo Gil Dong', 'D', 'TT') 이름 FROM dual;

/*
        ***
        2) TRIM() - 문자열 중에서 앞 또는 뒤에 있는 지정한 문자를 삭제해주는 함수
            A) LTRIM()
            B) RTRIM()
*/
SELECT TRIM('          HONG         GIL DONG             ') FROM dual; -- 앞 뒤의 공백 제거
SELECT LTRIM('@@@@@@@@@HONG      GIL DONG@@@@@@@', '@') FROM dual; 

/*
        3) ASCII() - 문자에 해당하는 아스키 코드를 알려준다.
*/
SELECT ASCII('A') A코드, ASCII('a') a코드 FROM dual;

/*
        4) CHR() - 아스키 코드 값을 문자로 반환해주는 함수.
*/
SELECT ASCII('a') a코드, CHR(97) a FROM dual;

/*
        5) TRANSLATE() - REPLACE와 비슷한 함수
                        차이점 ]
                            REPLACE() 는 바꿀 문자 전체를 바꾸는데
                            이 함수는 문자단위로 대체.
*/
SELECT 
    TRANSLATE('ABCDABCDABCAD', 'ABCD', '1234') TR,
    REPLACE('ABCDABCDABCAD', 'ABCD', '1234') RE
FROM dual;

