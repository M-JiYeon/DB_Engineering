select tname from tab;

select * from emp;

-- �ּ� ǥ��
/*��Ƽ���� �ּ�. sql developer�� ����*/

/* ���� ����� ����� ��� �ۼ��� �Ŀ� �ݵ�� ; */

select * from dept;

SELECT empno �����ȣ, ename ����̸�, job "�� ��", sal AS "�� ��"
FROM emp
WHERE job like 'CLERK';

SELECT 
    empno || ' - ' || ename as "�����ȣ - ����̸�", deptno �μ���ȣ, '���ߺ�' �μ��̸� -- || ���� ������ 
FROM 
    emp
WHERE 
    deptno = 20;

select '���ߺ�' from dept;

SELECT 
    empno || ' - ' || ename as "�����ȣ - ����̸�", 
    e.deptno �μ���ȣ, 
    DECODE(d.deptno, 20, '���ߺ�', '�𸣴� �μ�') �μ��̸� 
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
SELECT ename ����̸�, job ����, sal �޿�
FROM emp
WHERE job like 'MANAGER';

-- 3. 
SELECT ename ����̸�, job �޿�, sal �޿�
FROM emp
WHERE sal >= 1500;

-- 4.
SELECT empno �����ȣ, ename ����̸�, job ����, hiredate �Ի���
FROM emp
WHERE hiredate like '82%';

-- 5.
SELECT empno �����ȣ, ename ����̸�, deptno �μ���ȣ, job ����
FROM emp
WHERE deptno != 10;

-- 6.
SELECT empno �����ȣ, ename ����̸�, job ����, (sal-500) �޿�
FROM emp
WHERE sal > 2000;

-- 7.
SELECT empno �����ȣ, ename ����̸�, job ����, deptno �μ���ȣ, sal*12+nvl(comm, 0) ����
FROM emp
WHERE deptno = 30;


    