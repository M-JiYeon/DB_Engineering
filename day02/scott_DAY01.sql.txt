select tname from tab;


SELECT * FROM dept;
select * from emp;


/*
    SQL에서 주석 표현은 '--'로 표현한다.
    
    자바의 멀티라인 주석도 SQLDEVELOPER에서는 사용가능하다.
*/

-- 여기는 주석

/*
    질의명령은 명령이 모두 작성된 후에 반드시 ';'
    붙여서 명령이 끝났음을 알려줘야 한다.
*/

/*
    quiz 1]
        직급이 'CLERK'인 사원들의
            사원번호, 사원이름, 직 급, 급 여
        를 조회하세요.
        결과는 위의 형식의 별칭으로 표시되게 하세요.
        참고 ]
            EMP테이블에서 컬럼이름은
                EMPNO   - 사원번호
                ENAME   - 사원이름
                JOB     - 직급
                SAL     - 급여
                DEPTNO  - 부서번호
*/
SELECT
    empno AS "사원번호", ename 사원이름, job "직 급", sal "급 여"
FROM
    emp
WHERE
    job = 'CLERK'
;

/*
    QUIZ 2]
        20번 부서 사원들의 
            사원번호 - 사원이름, 부서번호, 부서이름을 조회하세요.
        단, 부서이름은 '개발부'로 표시하세요.
        
        사원번호 - 사원이름     |   부서번호    | 부서이름
        --------------------------------------------------
        7369 - SMITH          |     20       |  개발부
*/

SELECT SYSDATE 오늘   FROM EMP;

SELECT '개발부' FROM DEPT;

SELECT
    '개발부'
FROM
    dept
;

SELECT
    empno ||' - ' || ename as "사원번호 - 사원이름", 
    deptno 부서번호, 
    '개발부' 부서이름
FROM
    emp
WHERE
    deptno = 20
;

SELECT
    empno ||' - ' || ename as "사원번호 - 사원이름", 
    e.deptno 부서번호, 
    DECODE(d.deptno, 20, '개발부',
            '모르는부서') 부서이름
FROM
    emp e, dept d
WHERE
    e.deptno = d.deptno
    AND e.deptno = 20
;

-- quiz 3]
--     2번문제의 결과를 이름순으로 오름차순 정렬하세요.
SELECT
    empno ||' - ' || ename as "사원번호 - 사원이름", 
    deptno 부서번호, 
    '개발부' 부서이름
FROM
    emp
WHERE
    deptno = 20
ORDER BY
    ename DESC
;


SELECT
    empno ||' - ' || ename as "사원번호 - 사원이름", 
    deptno 부서번호, 
    '개발부' 부서이름
FROM
    emp
WHERE
    deptno = 20
ORDER BY
    hiredate DESC
;

SELECT
    empno, ename, e.deptno, dname
FROM
    emp e, dept d
WHERE
    e.deptno = d.deptno
;


SELECT deptno dno, dname, loc FROM dept;

SELECT
    empno, ename, deptno, dname
FROM
    emp,
    (
        SELECT
            deptno dno, dname, loc
        FROM
            dept
    )
WHERE
    deptno = dno
;

SELECT
    empno, ename, deptno, 
    (
        SELECT
            deptno || ', ' || dname || ', ' || loc
        FROM
            dept
        WHERE
            deptno = 20
    ) ddate
FROM
    emp e
;


/*
    오라클에서 자주 사용되는 데이터 타입
        문자데이터
            char        - 최대 4kbyte 고정길이형 데이터 타입
            varchar2    - 최대 4kbyte 가변길이형 데이터 타입
        숫자데이터
            number      - 숫자데이터
        날짜데이터
            date        - 날짜데이터
        
        clob            - 4GB 까지 저장가능한 문자열 데이터
        blob            - 4GB 까지 저장가능한 바이너리 데이터
        
        
        데이터 형변환은 이 경우만 가능하다.
        
        숫자데이터   <----------->    문자데이터    <----------->   날짜데이터
        
        
-------------------------------------------------------------------------------

-- 1. emp 테이블에 있는 데이터 중
--      사원이름이 'smith'인 사원의 
--      사원이름, 직급, 입사일을 조회하세요.

/*
    2. 직급이 'MANAGER'인 사원들의
        사원이름, 직급, 급여를 조회하세요.
*/

/*
    3. 급여가 1500 보다 많은 사원들의
        사원이름, 직급, 급여
        를 조회하세요.
*/

/*
    4. 입사일이 1982년도에 입사한 사원들의
        사원번호, 사원이름, 직급, 입사일
        을 조회하세요.
*/

/*
    5. 부서번호가 10번이 아닌 사원들의 
        사원번호, 사원이름, 부서번호, 직급을 조회하세요.
*/

/*
    6. 급여가 2000을 초과하는 사원들의
        사원번호, 사원이름, 직급, 급여를 조회하세요.
        단, 급여는 500을 빼서 조회하세요.
*/

/*
    7. 30번부서 사원들의
        사원번호, 사원이름, 직급, 부서번호, 연봉을 조회하세요.
        단, 연봉은 
            급여 * 12 + 커미션
        으로 계산하고 커미션이 없는 사원은 0으로 계산하세요.
*/
        
*/


