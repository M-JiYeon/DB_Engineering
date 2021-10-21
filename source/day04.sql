CREATE TABLE color(
    cno NUMBER(3)
        CONSTRAINT CLR_NO_PK PRIMARY KEY, -- 제약조건
    /*
        cno라는 컬럼을 숫자타입으로 3자리까지 입력할 수 있도록 하고
        제약조건은 기본키 제약조건을 주고 그 이름은 CLR_NO_PK를 사용.
        제약조건의 이름은 안줘도 되긴 하는데 무결성 제약조건을 위배했을 때 찾기 쉽게 하려고 붙여줌.
        
        제약조건은 데이터베이스 사전에 등록.
        따라서 동일한 이름은 존재하지 않는다.
        만약 제약조건이름을 기술하지 않으면 오라클이 자동으로 만들어서 부여.
    */
    cname VARCHAR2(50) 
        CONSTRAINT CLR_NAME_NN NOT NULL
        CONSTRAINT CLR_NAME_UK UNIQUE,
    ccode VARCHAR2(7 CHAR) DEFAULT '#000000'
        CONSTRAINT CLR_CODE_UK UNIQUE
);

CREATE TABLE kcolor(
    kcno NUMBER(3)
        CONSTRAINT KCLR_NO_PK PRIMARY KEY,
    kcname VARCHAR2(50) 
        CONSTRAINT KCLR_NAME_NN NOT NULL
        CONSTRAINT KCLR_NAME_UK UNIQUE,
    ccode VARCHAR2(7 CHAR) DEFAULT '#000000'
        CONSTRAINT KCLR_CODE_UK UNIQUE
);
/*
    테이블 만들기
    형식 ] 
        CREATE TABLE 테이블이름 (
            컬럼이름 데이터타입[(길이)][DEFAULT 데이터]
                [
                CONSTRAINT 제약조건이름 제약조건
                CONSTRAINT 제약조건이름 제약조건
                CONSTRAINT 제약조건이름 제약조건
                .......
                ],
            컬럼이름 데이터타입[(길이)][DEFAULT 데이터]
                [CONSTRAINT 제약조건이름 제약조건..]
            ,
            ......
        );
*/

/*
    데이터 추가하기
        INSERT 명령
        
            형식 1]
                INSERT INTO
                    테이블 이름
                VALUES(
                    데이터들 모두...
                );
                
            형식 2]
                INSERT INTO
                    테이블 이름(컬럼이름, 컬럼이름2, ... , 컬럼이름N) -- 컬럼 기술X. DEFAULT | NULL로 채워져
                VALUES(
                    데이터1, 데이터2, ... , 데이터N
                );
*/

INSERT INTO
    color(cno, cname)
VALUES(
    (SELECT NVL(MAX(cno)+1, 1) FROM color),
    'black'
);

INSERT INTO
    color
VALUES(
    (SELECT NVL(MAX(cno)+1, 1) FROM color),
    'red', '#FF0000'
);

INSERT INTO
    color
VALUES(
    (SELECT NVL(MAX(cno)+1, 1) FROM color),
    'green', '#00FF00'
);

INSERT INTO
    color
VALUES(
    (SELECT NVL(MAX(cno)+1, 1) FROM color),
    'blue', '#0000FF'
);

INSERT INTO
    kcolor(kcno, kcname)
VALUES(
    (SELECT NVL(MAX(kcno)+1, 1) FROM kcolor),
    '검정'
);

INSERT INTO
    kcolor
VALUES(
    (SELECT NVL(MAX(kcno)+1, 1) FROM kcolor),
    '빨강', '#FF0000'
);

INSERT INTO
    kcolor
VALUES(
    (SELECT NVL(MAX(kcno)+1, 1) FROM kcolor),
    '초록', '#00FF00'
);

INSERT INTO
    kcolor
VALUES(
    (SELECT NVL(MAX(kcno)+1, 1) FROM kcolor),
    '파랑', '#0000FF'
);

DELETE FROM kcolor;

-- 테이블을 설걔할 때는 한 행의 데이터만 선택할 수 있도록 조치를 해야하는데
-- 그 방법이 기본키를 주는 방법이다.

CREATE TABLE NO1(
    no number
);

INSERT INTO NO1 VALUES(1);

DROP TABLE NO1;

/*
    JOIN : 두 개 이상의 테이블에서 원하는 데이터를 꺼내오는 명령
    아무것도 거르지 않은 조인 - cross join. 모두 조인.
    SELF  JOIN : 테이블의 결과의 모든 결과 집합 안에서 데이터를 추려내는 방법
    INNER JOIN
    OUTER JOIN 
*/

SELECT * FROM color, kcolor;

-- 사원들의 사원이름, 상사번소, 상사이름 조회(SELF JOIN)
-- 결과 집합에 없는 데이터를 추가하는 조인 (OUTER JOIN)

SELECT 
    *--e.ename 사원이름, e.mgr 상사번호, s.ename 상사이름
FROM 
    emp e, emp s
WHERE 
    e.mgr = s.empno(+) -- KING은 있는데 KING의 상사는 없어. 상사 테이블에 + NULL 때문에 안나온 줄을 NULL로 채워
;

-- 사원들의 사원번호, 사원이름, 급여, 급여등급 조회 / NON EQUI JOIN
SELECT 
    empno 사원번호, ename 사원이름, sal 급여, grade 급여등급
FROM
    emp, salgrade
WHERE
    sal BETWEEN losal AND hisal
;


/*
    참고 ]
        조인조건과 일반조건은 같이 나열해도 무방.
*/

-- 사원들중 10번 부서 사원들의 사원번호, 사원이름, 급여, 급여등급 조회
SELECT 
    empno 사원번호, ename 사원이름, deptno 부서번호, sal 급여, grade 급여등급
FROM 
    emp, salgrade
WHERE 
    sal BETWEEN losal AND hisal 
    AND deptno = 10
;

/*
    직급이 'MANAGER'인 사원들의 
        사원이름, 직급, 입사일, 급여, 부서이름을 조회
*/

SELECT ename 사원이름, job 직급, TO_CHAR(hiredate, 'YYYY-MM-DD') 입사일, sal 급여, dname 부서이름
FROM emp e, dept d
WHERE 
    e.deptno = d.deptno 
    AND job = 'MANAGER'
;

/*
    급여가 가장 낮은 사원의 
        사원이름, 직급, 입사일, 급여, 부서이름, 부서위치를 조회
*/

SELECT MIN(sal) min
FROM emp ;

SELECT ename 사원이름, job 직급, TO_CHAR(hiredate, 'YYYY-MM-DD') 입사일, sal 급여, dname 부서이름, loc 부서위치
FROM 
    emp e, dept d,
    (   
        SELECT MIN(sal) min
        FROM emp
    )
WHERE  
    e.deptno = d.deptno 
    AND sal = min
;

/*
    사원이름이 5글자인 사원들의 
        사원이름, 직급, 입사일, 급여, 급여등급을 조회 
*/
SELECT ename 사원이름, job 직급, TO_CHAR(hiredate, 'YYYY-MM-DD') 입사일, sal 급여, grade 급여등급
FROM emp, salgrade
WHERE 
    sal BETWEEN losal AND hisal
    AND LENGTH(ename) = 5
;

/*
    입사년도가 81년이고, 직급이 'MANAGER'인 사원들의 
        사원이름, 직급, 입사일, 급여, 급여등급, 부서이름, 부서위치를 조회
*/

SELECT ename 사원이름, job 직급, TO_CHAR(hiredate, 'YYYY-MM-DD') 입사일, sal 급여, grade 급여등급, dname 부서이름, loc 부서위치
FROM emp e, salgrade, dept d
WHERE 
    sal BETWEEN losal AND hisal
    AND e.deptno = d.deptno
    AND TO_CHAR(hiredate, 'YY') = 81 
    AND job = 'MANAGER'
;

/*
    사원들의 
        사원이름, 직급, 급여, 상사이름, 급여등급을 조회
*/

SELECT e.ename 사원이름, e.job 직급, e.sal 급여, s.ename 상사이름, grade 급여등급
FROM emp e, emp s, salgrade
WHERE
    e.sal BETWEEN losal AND hisal
    AND e.mgr = s.empno(+)
;

/*
    사원들의 
        사원이름, 직급, 급여, 상사이름, 급여등급, 부서위치를 조회
    단, 회사 평균급여보다 많은 사원들만 조회
*/

SELECT e.ename 사원이름, e.job 직급, e.sal 급여, s.ename 상사이름, grade 급여등급, loc 부서위치
FROM emp e, emp s, salgrade, dept d
WHERE
    e.sal BETWEEN losal AND hisal
    AND e.mgr = s.empno(+)
    AND e.deptno = d.deptno
    AND e.sal > (
                SELECT AVG(sal)
                FROM emp
                )
;

/*
    사원들 중 상사의 급여가 3000 이상인 사원들의
        사원이름, 상사번호, 상사이름, 상사급여를 조회
    단, 상사가 없는 직원은 상사의 정보에 '상사없음'으로 표시
*/

SELECT 
    e.ename 사원이름, 
    NVL(TO_CHAR(s.empno), '상사없음') 상사번호, 
    NVL(TO_CHAR(s.ename), '상사없음') 상사이름, 
    NVL(TO_CHAR(s.sal), '상사없음') 상사급여
FROM emp e, emp s
WHERE
    e.mgr = s.empno(+)
    AND e.sal >= 3000
;

------------------------------- -----
-- student 테이블에서 '진현무' 학생의
-- 학번, 이름, 학년, 수강가능과목이름을 조회하세요.
SELECT stu_no 학번, stu_name 이름, stu_grade 학년, sub_name 수강가능과목 
FROM student, subject
WHERE
    stu_dept = sub_dept
    AND sub_grade = stu_grade  
    AND stu_name = '진현무'
;

-- 과목번호가 105 수업을 듣는 학생의 학번, 이름, 학과, 학년, 과목명, 성적
SELECT su.sub_name 과목명, st.stu_no 학번, st.stu_name 이름, st.stu_dept 학과, st.stu_grade 학년, e.enr_grade 성적
FROM student st, subject su, enrol e
WHERE
    st.stu_no = e.stu_no
    AND su.sub_no = e.sub_no
    AND su.sub_no = 105
;

-- 수강 신청 안해서 폐강 된 과목의 이름과 교수 학과
SELECT sub_no 과목번호, sub_name 과목명, sub_prof 교수명
FROM subject
WHERE 
    sub_no NOT IN 
    (
        SELECT DISTINCT s.sub_no
        FROM subject s, enrol e
        WHERE s.sub_no = e.sub_no
    )
;

-- 신청한 과목 번호
SELECT DISTINCT s.sub_no
FROM subject s, enrol e
WHERE 
     s.sub_no = e.sub_no
;

/*
    ANSI JOIN
*/

SELECT
    *
FROM
    emp e INNER JOIN  dept d
ON
    e.deptno = d.deptno
;

SELECT
    *
FROM
    emp e JOIN  dept d
ON
    e.deptno = d.deptno
;

SELECT
    ename, sal, e.deptno, dname, grade
FROM emp e
JOIN dept d
ON e.deptno = d.deptno
JOIN salgrade
ON sal BETWEEN losal AND hisal
;

SELECT
    e.ename 사원이름, e.mgr 상사번호, NVL(s.ename, '내가 대빵!') 상사이름
FROM
    emp e LEFT OUTER JOIN emp s
ON 
    e.mgr = s.empno
;

SELECT 
    ename 사원이름, deptno 부서번호, dname 부서이름
FROM
    emp e NATURAL JOIN dept d
;

SELECT 
    ename 사원이름, deptno 부서번호, dname 부서이름
FROM
    emp JOIN dept USING(deptno)
;
 

/*
    SUB QUERY(부질의, 서브질의)
        질의 명령 안에 완벽한 조회 질의 명령이 포함되는 경우
        포함되는 이 질의 명령을 서브질의라 한다. (SELECT)
        
        조회되는 결과로 구분
            단일행 서브질의 
                조회되는 결과가 한행으로 조회되는 경우
            다중행 서브질의
                결과가 여러 행으로 조회되는 경우
                
                다중행 단일컬름으로 조회되는 경우
                다음 연산자를 사용해서 처리할 수 있다.
                    IN - 주 연산자 (연산자 필요 X)
                    ----------------------
                    ANY : SOME - 부 연산자(연산자가 와야 해)
                    ALL
                    ----------------------
                    EXISTS - 비교 대상도 필요 X
*/

-- 40번 부서 소속 사원이 없는 경우 모든 사원들의 사원이름을 조회
SELECT
    ename 사원이름
FROM
    emp
WHERE
    NOT EXISTS(
            SELECT
                empno
            FROM
                emp
            WHERE 
                deptno = 40
    )
;

-- 직급이 'SALESMAN'인 사원들의 부서이름을 조회
SELECT dname 부서이름
FROM dept
WHERE deptno IN(
            SELECT deptno
            FROM emp
            WHERE job = 'SALESMAN'
            )
;

SELECT dname 부서이름
FROM dept
WHERE 
    deptno = ANY (
                SELECT deptno
                FROM emp
                WHERE job = 'SALESMAN'
            )
;

SELECT empno, ename, sal
FROM emp
WHERE
    sal < ALL (
            SELECT sal
            FROM emp
            WHERE
                deptno = 30
            )
;

----------------------------------------------------------------------

/*
    DML : 메모리 상에서만 작업을 한다.
            따라서 데이터베이스에 적용을 시킬려면 별도의 명령을 실행해야 한다.
            COMMIT
            ROLLLBACK
    
    SELECT
    -------------------------------
    INSERT
    UPDATE
    DELETE
    ------------------------------------------------------------------
    
    DDL : AUTO COMMIT
    DCL
    
    -- EXIT : AUTO COMMIT. 접속을 정상적으로 종료시키는 순간 자동 커밋
*/

-- 테이블 복사하는 명령
-- NOT NULL을 제외한 다른 제약조건은 복사가 안됨 : 제약조건 이름 때문에 + ?
CREATE TABLE EMP1
AS
    SELECT
        *
    FROM
        emp
;

CREATE TABLE EMP2
AS
    SELECT
        *
    FROM
        emp
    WHERE
        1 = 2
;

INSERT INTO 
    EMP2 
    SELECT
        *
    FROM
        emp
    WHERE
        ename = 'SMITH'
;

UPDATE 
    emp2
SET
    (sal, comm) = (
                SELECT sal, comm
                FROM emp 
                WHERE ename = 'MARTIN'
                )
;

