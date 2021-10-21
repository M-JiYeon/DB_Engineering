CREATE TABLE color(
    cno NUMBER(3)
        CONSTRAINT CLR_NO_PK PRIMARY KEY, -- ��������
    /*
        cno��� �÷��� ����Ÿ������ 3�ڸ����� �Է��� �� �ֵ��� �ϰ�
        ���������� �⺻Ű ���������� �ְ� �� �̸��� CLR_NO_PK�� ���.
        ���������� �̸��� ���൵ �Ǳ� �ϴµ� ���Ἲ ���������� �������� �� ã�� ���� �Ϸ��� �ٿ���.
        
        ���������� �����ͺ��̽� ������ ���.
        ���� ������ �̸��� �������� �ʴ´�.
        ���� ���������̸��� ������� ������ ����Ŭ�� �ڵ����� ���� �ο�.
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
    ���̺� �����
    ���� ] 
        CREATE TABLE ���̺��̸� (
            �÷��̸� ������Ÿ��[(����)][DEFAULT ������]
                [
                CONSTRAINT ���������̸� ��������
                CONSTRAINT ���������̸� ��������
                CONSTRAINT ���������̸� ��������
                .......
                ],
            �÷��̸� ������Ÿ��[(����)][DEFAULT ������]
                [CONSTRAINT ���������̸� ��������..]
            ,
            ......
        );
*/

/*
    ������ �߰��ϱ�
        INSERT ���
        
            ���� 1]
                INSERT INTO
                    ���̺� �̸�
                VALUES(
                    �����͵� ���...
                );
                
            ���� 2]
                INSERT INTO
                    ���̺� �̸�(�÷��̸�, �÷��̸�2, ... , �÷��̸�N) -- �÷� ���X. DEFAULT | NULL�� ä����
                VALUES(
                    ������1, ������2, ... , ������N
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
    '����'
);

INSERT INTO
    kcolor
VALUES(
    (SELECT NVL(MAX(kcno)+1, 1) FROM kcolor),
    '����', '#FF0000'
);

INSERT INTO
    kcolor
VALUES(
    (SELECT NVL(MAX(kcno)+1, 1) FROM kcolor),
    '�ʷ�', '#00FF00'
);

INSERT INTO
    kcolor
VALUES(
    (SELECT NVL(MAX(kcno)+1, 1) FROM kcolor),
    '�Ķ�', '#0000FF'
);

DELETE FROM kcolor;

-- ���̺��� ������ ���� �� ���� �����͸� ������ �� �ֵ��� ��ġ�� �ؾ��ϴµ�
-- �� ����� �⺻Ű�� �ִ� ����̴�.

CREATE TABLE NO1(
    no number
);

INSERT INTO NO1 VALUES(1);

DROP TABLE NO1;

/*
    JOIN : �� �� �̻��� ���̺��� ���ϴ� �����͸� �������� ���
    �ƹ��͵� �Ÿ��� ���� ���� - cross join. ��� ����.
    SELF  JOIN : ���̺��� ����� ��� ��� ���� �ȿ��� �����͸� �߷����� ���
    INNER JOIN
    OUTER JOIN 
*/

SELECT * FROM color, kcolor;

-- ������� ����̸�, ������, ����̸� ��ȸ(SELF JOIN)
-- ��� ���տ� ���� �����͸� �߰��ϴ� ���� (OUTER JOIN)

SELECT 
    *--e.ename ����̸�, e.mgr ����ȣ, s.ename ����̸�
FROM 
    emp e, emp s
WHERE 
    e.mgr = s.empno(+) -- KING�� �ִµ� KING�� ���� ����. ��� ���̺� + NULL ������ �ȳ��� ���� NULL�� ä��
;

-- ������� �����ȣ, ����̸�, �޿�, �޿���� ��ȸ / NON EQUI JOIN
SELECT 
    empno �����ȣ, ename ����̸�, sal �޿�, grade �޿����
FROM
    emp, salgrade
WHERE
    sal BETWEEN losal AND hisal
;


/*
    ���� ]
        �������ǰ� �Ϲ������� ���� �����ص� ����.
*/

-- ������� 10�� �μ� ������� �����ȣ, ����̸�, �޿�, �޿���� ��ȸ
SELECT 
    empno �����ȣ, ename ����̸�, deptno �μ���ȣ, sal �޿�, grade �޿����
FROM 
    emp, salgrade
WHERE 
    sal BETWEEN losal AND hisal 
    AND deptno = 10
;

/*
    ������ 'MANAGER'�� ������� 
        ����̸�, ����, �Ի���, �޿�, �μ��̸��� ��ȸ
*/

SELECT ename ����̸�, job ����, TO_CHAR(hiredate, 'YYYY-MM-DD') �Ի���, sal �޿�, dname �μ��̸�
FROM emp e, dept d
WHERE 
    e.deptno = d.deptno 
    AND job = 'MANAGER'
;

/*
    �޿��� ���� ���� ����� 
        ����̸�, ����, �Ի���, �޿�, �μ��̸�, �μ���ġ�� ��ȸ
*/

SELECT MIN(sal) min
FROM emp ;

SELECT ename ����̸�, job ����, TO_CHAR(hiredate, 'YYYY-MM-DD') �Ի���, sal �޿�, dname �μ��̸�, loc �μ���ġ
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
    ����̸��� 5������ ������� 
        ����̸�, ����, �Ի���, �޿�, �޿������ ��ȸ 
*/
SELECT ename ����̸�, job ����, TO_CHAR(hiredate, 'YYYY-MM-DD') �Ի���, sal �޿�, grade �޿����
FROM emp, salgrade
WHERE 
    sal BETWEEN losal AND hisal
    AND LENGTH(ename) = 5
;

/*
    �Ի�⵵�� 81���̰�, ������ 'MANAGER'�� ������� 
        ����̸�, ����, �Ի���, �޿�, �޿����, �μ��̸�, �μ���ġ�� ��ȸ
*/

SELECT ename ����̸�, job ����, TO_CHAR(hiredate, 'YYYY-MM-DD') �Ի���, sal �޿�, grade �޿����, dname �μ��̸�, loc �μ���ġ
FROM emp e, salgrade, dept d
WHERE 
    sal BETWEEN losal AND hisal
    AND e.deptno = d.deptno
    AND TO_CHAR(hiredate, 'YY') = 81 
    AND job = 'MANAGER'
;

/*
    ������� 
        ����̸�, ����, �޿�, ����̸�, �޿������ ��ȸ
*/

SELECT e.ename ����̸�, e.job ����, e.sal �޿�, s.ename ����̸�, grade �޿����
FROM emp e, emp s, salgrade
WHERE
    e.sal BETWEEN losal AND hisal
    AND e.mgr = s.empno(+)
;

/*
    ������� 
        ����̸�, ����, �޿�, ����̸�, �޿����, �μ���ġ�� ��ȸ
    ��, ȸ�� ��ձ޿����� ���� ����鸸 ��ȸ
*/

SELECT e.ename ����̸�, e.job ����, e.sal �޿�, s.ename ����̸�, grade �޿����, loc �μ���ġ
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
    ����� �� ����� �޿��� 3000 �̻��� �������
        ����̸�, ����ȣ, ����̸�, ���޿��� ��ȸ
    ��, ��簡 ���� ������ ����� ������ '������'���� ǥ��
*/

SELECT 
    e.ename ����̸�, 
    NVL(TO_CHAR(s.empno), '������') ����ȣ, 
    NVL(TO_CHAR(s.ename), '������') ����̸�, 
    NVL(TO_CHAR(s.sal), '������') ���޿�
FROM emp e, emp s
WHERE
    e.mgr = s.empno(+)
    AND e.sal >= 3000
;

------------------------------- -----
-- student ���̺��� '������' �л���
-- �й�, �̸�, �г�, �������ɰ����̸��� ��ȸ�ϼ���.
SELECT stu_no �й�, stu_name �̸�, stu_grade �г�, sub_name �������ɰ��� 
FROM student, subject
WHERE
    stu_dept = sub_dept
    AND sub_grade = stu_grade  
    AND stu_name = '������'
;

-- �����ȣ�� 105 ������ ��� �л��� �й�, �̸�, �а�, �г�, �����, ����
SELECT su.sub_name �����, st.stu_no �й�, st.stu_name �̸�, st.stu_dept �а�, st.stu_grade �г�, e.enr_grade ����
FROM student st, subject su, enrol e
WHERE
    st.stu_no = e.stu_no
    AND su.sub_no = e.sub_no
    AND su.sub_no = 105
;

-- ���� ��û ���ؼ� �� �� ������ �̸��� ���� �а�
SELECT sub_no �����ȣ, sub_name �����, sub_prof ������
FROM subject
WHERE 
    sub_no NOT IN 
    (
        SELECT DISTINCT s.sub_no
        FROM subject s, enrol e
        WHERE s.sub_no = e.sub_no
    )
;

-- ��û�� ���� ��ȣ
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
    e.ename ����̸�, e.mgr ����ȣ, NVL(s.ename, '���� �뻧!') ����̸�
FROM
    emp e LEFT OUTER JOIN emp s
ON 
    e.mgr = s.empno
;

SELECT 
    ename ����̸�, deptno �μ���ȣ, dname �μ��̸�
FROM
    emp e NATURAL JOIN dept d
;

SELECT 
    ename ����̸�, deptno �μ���ȣ, dname �μ��̸�
FROM
    emp JOIN dept USING(deptno)
;
 

/*
    SUB QUERY(������, ��������)
        ���� ��� �ȿ� �Ϻ��� ��ȸ ���� ����� ���ԵǴ� ���
        ���ԵǴ� �� ���� ����� �������Ƕ� �Ѵ�. (SELECT)
        
        ��ȸ�Ǵ� ����� ����
            ������ �������� 
                ��ȸ�Ǵ� ����� �������� ��ȸ�Ǵ� ���
            ������ ��������
                ����� ���� ������ ��ȸ�Ǵ� ���
                
                ������ �����ø����� ��ȸ�Ǵ� ���
                ���� �����ڸ� ����ؼ� ó���� �� �ִ�.
                    IN - �� ������ (������ �ʿ� X)
                    ----------------------
                    ANY : SOME - �� ������(�����ڰ� �;� ��)
                    ALL
                    ----------------------
                    EXISTS - �� ��� �ʿ� X
*/

-- 40�� �μ� �Ҽ� ����� ���� ��� ��� ������� ����̸��� ��ȸ
SELECT
    ename ����̸�
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

-- ������ 'SALESMAN'�� ������� �μ��̸��� ��ȸ
SELECT dname �μ��̸�
FROM dept
WHERE deptno IN(
            SELECT deptno
            FROM emp
            WHERE job = 'SALESMAN'
            )
;

SELECT dname �μ��̸�
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
    DML : �޸� �󿡼��� �۾��� �Ѵ�.
            ���� �����ͺ��̽��� ������ ��ų���� ������ ����� �����ؾ� �Ѵ�.
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
    
    -- EXIT : AUTO COMMIT. ������ ���������� �����Ű�� ���� �ڵ� Ŀ��
*/

-- ���̺� �����ϴ� ���
-- NOT NULL�� ������ �ٸ� ���������� ���簡 �ȵ� : �������� �̸� ������ + ?
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

