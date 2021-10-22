/*
 글번호 | 작성자 | 타이틀 | 작성일 | 클릭수
 
 -페이지 당 50개 -
 
이전 | 1 | 2 | 3 | 4 | 5 | 다음

*/

-- 데이터 중 순서대로 일부만 조회하기
-- 조회되는 데이터에 넘버링을 해서 원하는 갯수만큼 조회
-- 넘버링하는 가상의 컬럼을 오라클에서 제공해 줌.
-- ROWNUM : 1부터 시작해야 해. 결과집합에 넣고 번호를 붙이기 때문에 시작하는 애가 없으면 안만들어짐.
-- ROWNUM의 결과를 별칭을 줘서 서브질의를 만들어 가상의 테이블을 만들어 미리 번호를 부여하고 잘라낸다면 가능


-- 급여 순으로 6번째부터 10번째까지 사원조회
-- 정렬 -> 번호 -> 뽑아오기

SELECT -- 3. 6 ~ 10번 뽑아오기
    *
FROM 
    (
        SELECT ROWNUM rno, e.* -- 2. 번호 붙이기
        FROM 
            (
                SELECT * -- 1. 급여 순으로 정렬
                FROM emp
                ORDER BY sal ASC
            ) e
    )
WHERE 
    rno BETWEEN 6 AND 10
;

-- ** 번호 붙이고 정렬하지 않도록 주의
SELECT -- 3. 6 ~ 10번 뽑아오기
    *
FROM 
    (
        SELECT ROWNUM rno, e.* -- 1. 번호 붙이기
        FROM emp e
        ORDER BY sal ASC -- 2. 급여 순으로 정렬
    )
WHERE 
    rno BETWEEN 6 AND 10
;

/*
    킹덤 취업.
    자기 정보 입력하면 입사 성공!
    
*/
-- emp 테이블에 자신의 데이터를 입력하세요.
-- 사원번호는 1001번부터 순차적으로 자동으로 만들어내는 서브질의를 사용해서 처리.
-- 부서번호도 dept 테이블에 있는 걸로 입력
-- hiredate는 오늘 날짜

INSERT 
INTO emp (
    empno,
    ename,
    job,
    hiredate,
    sal,
    deptno
)
VALUES 
(
    (SELECT NVL(MAX(empno) + 1, 1001) FROM emp),
    '맹지연',
    'MANAGER',
    to_char(trunc(sysdate,'dd'), 'yyyy/mm/dd hh24:mi:ss'),
    2000,
    20
);


/*
    서브 질의 중 특별히 FROM 절 내에 놓이는 서브질의를
        '인라인 뷰'라고 부른다.
        
    VIEW
        - 물리적으로 데이터베이스에 만들어져 있지는 않지만
            접근해서 테이블처럼 사용할 수 있는 개체
        - 원하는 데이터만 조회 가능
        - 보안에 유리
        - 복잡한 질의의 결과를 뷰로 만들어 놓으면 다시 안만들어도 됨
        - DB관리자가 만들어서 관리. 권한 필요.
        
        => 따라서 뷰를 만들때는 서브질의가 들어간다.
        
            단순뷰 | 뷰를 만들 때 하나의 테이블을 이용해서 만드는 경우
                     DML 명령어 사용가능(INSERT, UPDATE, DELETE, SELECT) - 뷰에서 데이터를 수정하면 테이블에도 적용됨.
            
            복합뷰 | 2개 이상 / 수정불가
*/

CREATE OR REPLACE VIEW emp_view1
AS
    SELECT
        empno, ename, deptno
    FROM
        emp1
;

SELECT *
FROM emp_view
;


CREATE OR REPLACE VIEW emp_view
AS
    SELECT deptno dno, COUNT(*) cnt, MAX(sal) max, MIN(sal) min, SUM(sal) sum, AVG(sal) avg
    FROM emp
    GROUP BY deptno
;

SELECT *
FROM emp_view1
;

UPDATE
    emp_view1
SET
    deptno = 40
WHERE
    empno = 7369
;

SELECT * FROM emp1;

UPDATE -- 에러
    emp_view
SET
    avg = 10000
WHERE  dno = 10
;



/*
    제약조건
        - 입력되는 데이터가 틀린 데이터가 입력되지 못하도록 막는 기능하는 것
        - 데이터베이스의 이상현상을 줄일목적으로 사용
        
        종류 ] 
            기본키 제약조건   : PRIMARY KEY. PK
                                UNIQUE + NOT NULL
            유일키 제약조건   : 다른 행의 데이터와 중복해서 입력할 수 없는 제약조건. UK
                                UNIQUE
            NOT NULL 제약조건 : 컬럼에 입력되는 데이터가 반드시 있어야하는 제약조건.
            CHECK 제약조건    : 입력되는 데이터가 정의된 도메인 중 하나여야만 하는 제약조건.
            
        참고 ]
            DEFAULT : 데이터를 입력할 때 별도로 해당컬럼을 지적하지 않는 경우
                        기본값으로 채원주는 속성..?
        
        형식 ]
            
*/


/*
    데이터베이스 모델링
        1. 요구사항분석에서 기술된 명사들만 도출해낸다.
        
        2. ER Model을 만든다.(정규화 - 제1 정규화, 제2 정규화, 제3 정규화)
        
        3. ER Diagram 작성
        
        4. 테이블 명세서
*/

/*
    요구사항 분석
        
        요구사항 : 
            
            사원은 사원번호를 가진다.
            사원이 입사할 때는 입사일 0시 0분 0초를 입사시간으로 한다.
            사원 정보는 
                사원의 이름, 직급, 상사, 입사일, 급여, 커미션, 소속부서를 입력한다.
            
            부서 정보는
                10번 부서는 부서이름이 ...이고 부서위치는 ㅇㅇㅇ이다,
                20번 부서는 ....
                30번 부서는 ....
                40번 부서는 ....
                
            사원은 오직 하나의 부서에 반드시 소속되어야 한다.
            
            사원의 직급은 사장, 부장, 과장, 대리, 주임, 평사원을 사용
            
            급여 등급은
                급여 등급은 최소급여 200만 이상 최대 급여 300만은 1등급
                ....
                                    3001 이상       999 이하는 5등급
                                    
            보너스 지급은
                지급대상의 이름, 직급, 급여, 커미션을 기록한다.
*/


/*
    데이터베이스 설계
        1. 개념적 설계
        2. 논리적 설계 
        3. 물리적 설계 - 테이블 이름, 속성이름, 타입, 
*/


----------------------------------------------------------------------------
-- create sal_grade table
CREATE TABLE sal_grade(
    grade NUMBER(2)
        CONSTRAINT SALGRD_GRD_PK PRIMARY KEY,
    losal NUMBER(10),
    hisal NUMBER(10),
    CONSTRAINT SALGRD_LO_UK UNIQUE(losal)
);

-- losal NOT NULL 제약조건 변경
ALTER TABLE sal_grade
MODIFY
    losal CONSTRAINT SALGRD_LO_NN NOT NULL
;

-- hisal UNIQUE 제약조건 추가
ALTER TABLE sal_grade
ADD
    CONSTRAINT SALGRD_HI_UK UNIQUE(hisal)
;


-- create k_dept table
CREATE TABLE k_dept(
    deptno NUMBER(2)
        CONSTRAINT KDEPT_NO_PK PRIMARY KEY,
    dname VARCHAR2(10 CHAR)
        CONSTRAINT KDEPT_NAME_NN NOT NULL,
    loc VARCHAR2(10 CHAR)
        CONSTRAINT KDEPT_LOC_NN NOT NULL
);


-- create k_emp tanle
CREATE TABLE k_emp(
    empno NUMBER(4)
        CONSTRAINT KEMP_NO_PK PRIMARY KEY,
    ename VARCHAR2(10 CHAR)
        CONSTRAINT KEMP_NAME_NN NOT NULL,
    job VARCHAR2(10 CHAR)
        CONSTRAINT KEMP_JOG_NN NOT NULL
        CONSTRAINT KEMP_JOG_CK 
            CHECK(job IN ('사장', '부장', '과장', '대리', '주임', '평사원')
                ),
    mgr NUMBER(4)
        CONSTRAINT KEMP_MGR_FK REFERENCES k_emp(empno),
    hiredate DATE DEFAULT SYSDATE
        CONSTRAINT KEMP_HDATE_NN NOT NULL,
    sal NUMBER(10)
        CONSTRAINT KEMP_SAL_NN NOT NULL,
    comm NUMBER(10),
    deptno NUMBER(2)
--        CONSTRAINT KEMP_DNO_FK REFERENCES k_dept(deptno)
        CONSTRAINT KEMP_DNO_NN NOT NULL,
    CONSTRAINT KEMP_DNO_FK FOREIGN KEY(deptno) REFERENCES k_dept(deptno)
);


INSERT INTO
    k_dept
    SELECT
        *
    FROM
        dept
;

INSERT INTO
    sal_grade
VALUES(
    (SELECT NVL(MAX(grade)+1, 1) FROM sal_grade),
    2000000, 3000000
);

INSERT INTO
    sal_grade
VALUES(
    (SELECT NVL(MAX(grade)+1, 1) FROM sal_grade),
    3000001, 5000000
);

INSERT INTO
    sal_grade
VALUES(
    (SELECT NVL(MAX(grade)+1, 1) FROM sal_grade),
    7000001, 10000000
);

INSERT INTO
    sal_grade(grade, losal)
VALUES(
    (SELECT NVL(MAX(grade)+1, 1) FROM sal_grade),
    10000001
);


INSERT INTO
    k_emp(empno, ename, job, hiredate, sal, comm, deptno)
VALUES(
    1001, '전은석', '사장', TRUNC(sysdate, 'dd'), 2000001, 1, 10
)
;

INSERT INTO
    k_emp(empno, ename, job, hiredate, sal, comm, deptno)
VALUES(
    1002, '맹지연', '대리', TRUNC(sysdate, 'dd'), 5000001, 1, 20
)
;





