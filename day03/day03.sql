/* 
    ���� 1]
        ������� ����̸�, ����, �μ��̸� ��ȸ
        10�� �μ��� ������
        20�� �μ��� ���ߺ�
        30�� �μ��� �ѹ���
        �� �ܴ̿� ��η� ǥ��
*/

SELECT ename ����̸�, job ����, 
    CASE deptno WHEN 10 THEN '������'
                WHEN 20 THEN '���ߺ�'
                WHEN 30 THEN '�ѹ���'
                ELSE '���'
    END �μ��̸�
FROM emp ;

SELECT ename ����̸�, job ����, 
    DECODE(deptno, 10, '������', 
                   20, '���ߺ�',
                   30, '�ѹ���',
                       '���'
    ) �μ��̸�
FROM emp
ORDER BY deptno;

/*
    ���� 2]
        ������� ����̸�, �޿�, Ŀ�̼� ��ȸ
        ��, Ŀ�̼��� ���� ����� 'Ŀ�̼� ����'���� ǥ��
*/

SELECT ename ����̸�, sal �޿�, NVL(TO_CHAR(comm), 'Ŀ�̼Ǿ���') Ŀ�̼�
FROM emp ;

SELECT 
    ename ����̸�, sal �޿�, 
    DECODE(comm, NULL, 'Ŀ�̼Ǿ���', 
                        TO_CHAR(comm)
    ) Ŀ�̼�
FROM emp ;

-- �׷� �Լ�


-- 20�� �μ� ������ ������ ����/�� ���� ������� ��� ��ȸ. (�̸�, ����, �μ���ȣ)
SELECT 
    ename, job, deptno
FROM
    emp
WHERE 
    job IN( -- �� ���ԵǾ� �ִ� ���
        SELECT -- 20�� �μ� ������� ����
            DISTINCT job
        FROM 
            emp
        WHERE 
            deptno = 20
    );

-- ������� ��ձ޿�, �ִ�޿�, �ּұ޿�, �޿� �հ�, ����� ��ȸ
SELECT ROUND(AVG(sal),2) ��ձ޿�, MAX(sal) �ִ�޿�, MIN(sal) �ּұ޿�, SUM(sal) �޿��հ�, COUNT(*)�����
FROM emp;

-- ������� �̸�, �޿�, ȸ����ձ޿� ��ȸ
SELECT ename, sal, 
    (
        SELECT 
            ROUND(AVG(sal),2) 
        FROM 
            emp
    ) ��ձ޿�
FROM emp;

SELECT
    ename, sal, a
FROM 
    emp,
    (
        SELECT -- �ζ��� ��(�������ǰ� from ���ȿ� �� �ִ� ���)
            ROUND(AVG(sal),2) a
        FROM 
            emp
    )
;

-- ������� ����̸�, �޿�, ȸ����ձ޿�, �ִ�޿�, �ּұ޿��� ��ȸ

SELECT ename, sal, -- ����
    (
        SELECT 
            ROUND(AVG(sal),2), MAX(sal), MIN(sal)
        FROM 
            emp
    ) ��ձ޿�
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


SELECT  -- ����Ʈ ��
    ename, LENGTHB(ename) ����Ʈ��
FROM
    emp ;

SELECT
    LENGTHB('ȫ�浿'), LENGTHB('ȣ'), LENGTHB('ȫ') FROM dual;
    
-- �μ��� �μ��̸�, �μ� �ִ�޿�, �μ� �ּ� �޿�, �μ� ��ձ޿�
-- �μ��� ���
SELECT 
    deptno dno, MAX(sal) max, MIN(sal) min, ROUND(AVG(sal), 2) avg, COUNT(*) cnt
FROM 
    emp
GROUP BY 
    deptno;

SELECT
    dname �μ��̸�, max �ִ�޿�, min �ּұ޿�, avg �μ���ձ޿�, cnt �μ�����
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
    �μ����� ���� ���� �μ��� ���� ������� 
    ����̸�, ����, �μ���ȣ, �޿��� ��ȸ
*/
-- �μ� �� �ο�
SELECT deptno dno, COUNT(*) cnt
FROM emp
GROUP BY deptno;

-- �μ����� ���� ���� �μ���ȣ
-- �μ���ȣ ����. �μ��� �� ���̺���. cnt�� �μ��� �� ���̺��� ���� ���� ���� ����.
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

-- ���� ��
SELECT ename ����̸�, job ����, deptno �μ���ȣ, sal �޿�
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
    �μ� ��ձ޿����� ���� �޴� ������� 
    �����ȣ, ����̸�, �μ���ȣ, �޿�, �μ���ձ޿� ��ȸ
*/
-- �μ� �� ��� �޿�
SELECT deptno dno, ROUND(AVG(sal), 2) avg_sal
FROM emp
GROUP BY deptno;

-- ����
SELECT empno �����ȣ, ename ����̸�, deptno �μ���ȣ, sal �޿�, avg_sal �μ���ձ޿�
FROM emp, 
    (
        SELECT deptno dno, ROUND(AVG(sal), 2) avg_sal
        FROM emp
        GROUP BY deptno
    )
WHERE deptno = dno AND sal < avg_sal;

-- ���� �� / ���ŷο� ����
SELECT 
    empno �����ȣ, ename ����̸�, deptno �μ���ȣ, sal �޿�,
    (
        SELECT ROUND(AVG(sal), 2)
        FROM emp
        WHERE deptno = e.deptno
    ) �μ���ձ޿�
FROM emp e
WHERE 
    sal < (
            SELECT AVG(sal)
            FROM emp
            WHERE deptno = e.deptno
            )
;

-- ���� ��
SELECT 
    empno �����ȣ, ename ����̸�, deptno �μ���ȣ, sal �޿�, ROUND(avg, 2) ��ձ޿�
FROM 
    emp, 
    ( -- �μ���ȣ�� �μ��� ��ձ޿��� ����ϴ� ������ ���̺��� �����
        SELECT deptno dno, AVG(sal) avg
        FROM emp
        GROUP BY deptno
    )
WHERE 
    deptno = dno -- ��������
    AND sal < avg
;

/*
    �� �μ��� �ּ� �޿����� 
    ����̸�, �μ���ȣ, �޿�, �μ��ּұ޿� ��ȸ
*/

-- �� �μ� �� �ּ� �޿� �׼�
SELECT deptno dno, MIN(sal) min_sal
FROM emp
GROUP BY deptno;

-- ����
SELECT ename ����̸�, deptno �μ���ȣ, sal �޿�, min_sal �μ��ּұ޿�
FROM emp, 
    (
        SELECT deptno dno, MIN(sal) min_sal
        FROM emp
        GROUP BY deptno
    )
WHERE sal = min_sal; -- �ּ� �޿���


/*
    ����� �ּұ޿��ڰ� ���� �μ��� �������
    ����̸�, �μ��̸�, �μ��޿��հ�, �μ��ִ�޿�, �μ��ּұ޿�, �μ���ձ޿�
    �� ��ȸ�ϼ���.
*/

-- �ּұ޿��ڰ� ���� �μ�
SELECT deptno dno
FROM emp
WHERE sal = ( SELECT MIN(sal) FROM emp );

-- �ּұ޿��ڰ� ���� �μ��� �μ��޿��հ�, �μ��ִ�޿�, �μ��ּұ޿�, �μ���ձ޿�
SELECT deptno dno2, SUM(sal) sum, MAX(sal) max, MIN(sal) min, ROUND(AVG(sal), 2) avg
FROM emp
WHERE deptno = 
    (
        SELECT deptno dno
        FROM emp
        WHERE sal = ( SELECT MIN(sal) FROM emp )      
    )
GROUP BY deptno;

-- ����
SELECT ename ����̸�, dname �μ��̸�, sum �μ��޿��հ�, max �μ��ִ�޿�, min �μ��ּұ޿�, avg �μ���ձ޿�
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
    �μ��� �޿��հ谡 ���� ���� �μ��� ���� �������
    ����̸�, �޿�, �μ���ȣ ��ȸ
*/
-- �μ� �� �޿��հ�
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
    �� �μ����� ���� ���� �޿��� ������ ��ȸ
    (�μ���ȣ, �ּұ޿�)
*/

SELECT deptno �μ���ȣ, MIN(sal) �ּұ޿�
FROM emp
GROUP BY deptno;

/*
    �μ��� Ŀ�̼� �޴� ��� ���� ��ȸ
*/
SELECT deptno �μ���ȣ, COUNT(comm) "Ŀ�̼� �޴� ��� ��"
FROM emp
GROUP BY deptno;


/*
    �� ���޺��� �޿��հ�, ��ձ޿� ��ȸ
*/
SELECT job ����, SUM(sal) �޿��հ�, ROUND(AVG(sal), 2) ��ձ޿�
FROM emp
GROUP BY job;


/*
    �Ի� �⵵ ���� ��ձ޿��� �޿��հ� ��ȸ
    �⵵, ��ձ޿�, �޿��հ�
*/
SELECT 
    TO_CHAR(hiredate, 'YYYY') �⵵, 
    ROUND(AVG(sal), 2) ��ձ޿�, SUM(sal) �޿��հ�
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');


/*
    �� �⵵�� �Ի�� �� ��ȸ
*/
SELECT 
    TO_CHAR(hiredate, 'YYYY') �Ի�⵵, COUNT(*) �Ի����
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');


/*
    ��� �̸��� ���ڼ��� 4���� �Ǵ� 5������ ����� �� ��ȸ
*/
SELECT LENGTH(ename) �̸����ڼ�, COUNT(*) �����
FROM emp
GROUP BY LENGTH(ename)
HAVING LENGTH(ename) IN (4,5);


/*
    1981�⵵�� �Ի��� �������
    ���� �� �����
*/
SELECT job ����, count(*) �����
FROM emp
WHERE TO_CHAR(hiredate, 'YYYY') = '1981'
GROUP BY job;

-- 1981�� ��� ��
SELECT TO_CHAR(hiredate, 'YYYY') year, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
HAVING TO_CHAR(hiredate, 'YYYY') = '1981'
;


/*
    �̸� ���̰� 4 �Ǵ� 5 ������ ������� �μ� ���� ���� ��ȸ
    ��, ������� �ѻ���� �μ��� �����ϰ� ��ȸ
*/
SELECT deptno �μ�, COUNT(*)�����
FROM emp
WHERE LENGTH(ename) IN (4,5)
GROUP BY deptno
HAVING COUNT(*) <> 1;


/*
    81�⵵ �Ի��� ������� ���� �� �޿� �հ� ��ȸ
    ��, ���� �� ��� �޿��� 1000 �̸��� ������ ��ȸ���� ����.
*/
SELECT job ����, SUM(sal) �޿��հ�, ROUND(AVG(sal))��ձ޿�
FROM emp
WHERE TO_CHAR(hiredate, 'YY') = '81'
GROUP BY job
HAVING NOT AVG(sal) < 1000;


/*
    81�⵵ �Ի��� ������� �̸� ���� �� �޿��հ踦 ��ȸ.
    ��, �հ谡 2000 �̸��� ���� �����ϰ�
    �հ谡 ���� ������ �������� �����ؼ� ��ȸ.
*/
SELECT LENGTH(ename) �̸�����, SUM(sal) �޿��հ�
FROM emp
WHERE TO_CHAR(hiredate, 'YY') = '81'
GROUP BY LENGTH(ename)
HAVING NOT SUM(sal) < 2000
ORDER BY SUM(sal) DESC;

---------------------------------------------------------

/* 
    ���ڿ� ó���Լ�
        1) REPLACE() - ���ڿ��� Ư�� �κ��� �ٸ� ���ڿ��� ��ü�ϴ� �Լ�
*/
SELECT REPLACE ('HongDo Gil Dong', 'D', 'TT') �̸� FROM dual;

/*
        ***
        2) TRIM() - ���ڿ� �߿��� �� �Ǵ� �ڿ� �ִ� ������ ���ڸ� �������ִ� �Լ�
            A) LTRIM()
            B) RTRIM()
*/
SELECT TRIM('          HONG         GIL DONG             ') FROM dual; -- �� ���� ���� ����
SELECT LTRIM('@@@@@@@@@HONG      GIL DONG@@@@@@@', '@') FROM dual; 

/*
        3) ASCII() - ���ڿ� �ش��ϴ� �ƽ�Ű �ڵ带 �˷��ش�.
*/
SELECT ASCII('A') A�ڵ�, ASCII('a') a�ڵ� FROM dual;

/*
        4) CHR() - �ƽ�Ű �ڵ� ���� ���ڷ� ��ȯ���ִ� �Լ�.
*/
SELECT ASCII('a') a�ڵ�, CHR(97) a FROM dual;

/*
        5) TRANSLATE() - REPLACE�� ����� �Լ�
                        ������ ]
                            REPLACE() �� �ٲ� ���� ��ü�� �ٲٴµ�
                            �� �Լ��� ���ڴ����� ��ü.
*/
SELECT 
    TRANSLATE('ABCDABCDABCAD', 'ABCD', '1234') TR,
    REPLACE('ABCDABCDABCAD', 'ABCD', '1234') RE
FROM dual;

