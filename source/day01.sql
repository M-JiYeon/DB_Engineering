select tname from tab;

select * from emp;

-- 주석 표현
/*멀티라인 주석. sql developer만 가능*/

/* 질의 명령은 명령이 모두 작성된 후에 반드시 ; */

select * from dept;

SELECT empno 사원번호, ename 사원이름, job "직 급", sal AS "급 여"
FROM emp
WHERE job like 'CLERK';

SELECT 
    empno || ' - ' || ename as "사원번호 - 사원이름", deptno 부서번호, '개발부' 부서이름 -- || 결합 연산자 
FROM 
    emp
WHERE 
    deptno = 20;

select '개발부' from dept;

SELECT 
    empno || ' - ' || ename as "사원번호 - 사원이름", 
    e.deptno 부서번호, 
    DECODE(d.deptno, 20, '개발부', '모르는 부서') 부서이름 
FROM 
    emp e, dept d
WHERE 
    e.deptno = d.deptno and e.deptno = 20
ORDER BY hiredate DESC;
    

SELECT deptno dno, dname, loc
FROM dept ;

SELECT empno, ename, e.deptno, dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;
    
SELECT empno, ename, deptno, dname
FROM emp,
     (
        SELECT deptno dno, dname, loc
        FROM dept 
     )
WHERE deptno = dno
;

SELECT empno, ename, deptno, 
    (
        SELECT deptno|| ', ' || dname || ', ' || loc
        FROM dept
        WHERE deptno = 20
    ) ddate
FROM emp
;
-- 1. 
SELECT ename, job, hiredate
FROM emp
WHERE ename like 'smith';

-- 2. 
SELECT ename 사원이름, job 직급, sal 급여
FROM emp
WHERE job like 'MANAGER';

-- 3. 
SELECT ename 사원이름, job 급여, sal 급여
FROM emp
WHERE sal >= 1500;

-- 4.
SELECT empno 사원번호, ename 사원이름, job 직급, hiredate 입사일
FROM emp
WHERE hiredate like '82%';

-- 5.
SELECT empno 사원번호, ename 사원이름, deptno 부서번호, job 직급
FROM emp
WHERE deptno != 10;

-- 6.
SELECT empno 사원번호, ename 사원이름, job 직급, (sal-500) 급여
FROM emp
WHERE sal > 2000;

-- 7.
SELECT empno 사원번호, ename 사원이름, job 직급, deptno 부서번호, sal*12+nvl(comm, 0) 연봉
FROM emp
WHERE deptno = 30;


    