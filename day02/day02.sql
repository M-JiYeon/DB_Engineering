SELECT 
    ename ����̸�, sal ���޿�, TO_CHAR(sal * 1.15, '99,999,999.99') �λ�޿�1,
    TO_CHAR(sal * 1.15, '00,000,000.00') �λ�޿�2
FROM emp;

-- (nullif(A, B), '�� ����) A / B�� ������ NULL ��ȯ �ٸ��� A��ȯ

SELECT NVL(NULLIF('A', 'A'), 'B') FROM dual;

/*
    ����ó�� �Լ�
        DECODE(�÷� �̸�, ������1(����), ���๮1,
                         ������2, ���๮2,
                         ... ,
                         ������N, ���๮N,
                         ������ ��� ���๮)
*/

-- ������ 'SALSEMAN'�̸� �޿� 10% �λ�
-- ������ 'CLERK'�̸� �޿� 15% �λ�
-- ������ 'MANAGER'�̸� �޿� 1% �λ�
-- �������� ���� �޿�(�λ� X)
SELECT 
    ename ����̸�, job ����, sal �����޿�,
    DECODE(job, 'SALESMAN', sal * 1.1,
                'CLERK', sal * 1.5,
                'MANAGER', sal * 1.01,
                sal) �λ�޿�
FROM emp;

SELECT 
    ename ����̸�, job ����, sal �����޿�,
    CASE WHEN job = 'SALESMAN' THEN sal * 1.1
         WHEN job = 'CLERK' THEN sal * 1.5
         WHEN job = 'MANAGER' THEN sal * 1.01
         ELSE sal
    END �λ�޿�
FROM emp;

SELECT 
    ename ����̸�, job ����, sal �����޿�,
    CASE job WHEN 'SALESMAN' THEN sal * 1.1
             WHEN 'CLERK' THEN sal * 1.5
             WHEN 'MANAGER' THEN sal * 1.01
             ELSE sal
    END �λ�޿�
FROM emp;

-- �޿��� 10% �λ� �� 1200���� ���� ����� ��ȸ
SELECT ename, sal * 1.1
FROM emp
WHERE (sal * 1.1) < 1200
;

SELECT * 
FROM emp
WHERE 1 = 1 -- where���� ��ȯ�Ǵ� ���� �����̸� ��. ��� ������ ����
;

-- �޿��� 10% �λ��� 1200���� ���� ����� ��ȸ
SELECT ename, sal * 1.1
FROM emp
WHERE
    -- SAL * 1.1 < 1200
    TO_CHAR(sal) LIKE '1%'
;

/*
    EX 1]
        ����� �̸��� 'M' ������ ���ڷ� �����ϴ� �������
        �̸�, ����, �޿��� ��ȸ�ϼ���.
        ���� - M���� �����ϴ� ��� ���� ����
*/
SELECT ename ����̸�, job ����, sal �޿�
FROM emp
WHERE ename < 'M%'
;

/*
    EX 2]
        �Ի����� 1981�� 9�� 8�� �� �����
        �̸�, ����, �Ի����� ��ȸ�ϼ���.
*/
SELECT ename ����̸�, job ����, hiredate �Ի���
FROM emp
WHERE hiredate = '1981/09/08'
;

/*
    EX 3]
        ������� �̸��� 'M'������ ���ڷ� �����ϴ� ����� ��
        �޿��� 1000 �̻��� �������
        ����̸�, ����, �޿��� ��ȸ�ϼ���. 
*/
SELECT ename ����̸�, job ����, sal �޿�
FROM emp
WHERE ename > 'M%' and sal >=1000
;

/*
    EX 4]
        ������ 'MANAGER'�� �ƴ� �������
        ����̸�, ����, �Ի����� ��ȸ�ϼ���.
        �����ڷ� ó���ϼ���.
*/
SELECT ename ����̸�, job ����, hiredate �Ի���
FROM emp
WHERE job NOT IN('MANAGER')
;

/*
    EX 5]
        ����� �̸��� 'C' ������ ���ڷ� �����ϰ� 'M' ������ ���ڷ� �����ϴ� �������
        ����̸�, ����, �Ի����� ��ȸ�ϼ���.
        
        BETWEEN ������ ���
*/
SELECT ename ����̸�, job ����, hiredate �Ի���
FROM emp
WHERE ename BETWEEN 'C%' AND 'M%'
;

/*
    EX 6]
        ����� �̸��� 'S' �� �����ϰ�
        �̸��� ���ڼ��� 5������ �������
        ����̸�, ������ ��ȸ�ϼ���.
*/
SELECT ename ����̸�, job ����
FROM emp
WHERE ename like 'S%' AND LENGTH(ename) = 5
;

/*
    EX 7]
        �Ի����� 3���� �������
        ����̸�, �Ի����� ��ȸ�ϼ���.
*/
SELECT ename ����̸�,  hiredate �Ի���
FROM emp
WHERE TO_CHAR(hiredate, 'DD') = '03'
;

/*
    EX 8]
        ����̸��� ���ڼ��� 4 �Ǵ� 5 ������ �������
        ����̸�, �Ի����� ��ȸ�ϼ���.
*/
SELECT ename ����̸�, hiredate �Ի���
FROM emp
WHERE LENGTH(ename) = 4 OR LENGTH(ename) = 5
;

/*
    EX 9]
        �Ի�⵵�� 81�� 82���� ������� 
        ����̸�, �Ի���, �޿��� ��ȸ�ϼ���.
*/
SELECT ename ����̸�, hiredate �Ի���, sal �޿�
FROM emp
WHERE TO_CHAR(hiredate, 'YYYY') LIKE '%81' OR 
      TO_CHAR(hiredate, 'YYYY') LIKE '%82'
;

/*
    EX 10]
        �̸��� 'S'�� ������ �������
        �̸�, �޿�, Ŀ�̼��� ��ȸ�ϼ���.
        ��, Ŀ�̼��� 100�� ���ϰ� ���� ����� 100 �� �����ϼ���.
*/
SELECT ename �̸�, sal �޿�, NVL(comm+100, 100) Ŀ�̼�
FROM emp
WHERE ename LIKE '%S'
;

/*
    BONUS 1]
        ������� �̸��� ��ȸ�ϴµ�
        ����� �ι�° ���ڸ� �����ְ� 
        ������ ���ڴ� '*' ��µǰ� ��ȸ�ϼ���.
        
        �� ]
            ����̸� | ����̸�
            SMITH   | *M***
            KING    | *I**
*/
SELECT ename || ' | ' || 
       CONCAT(,�μ�2)  "����̸� | ����̸�"
FROM emp
;

/*
    BONUS 2]
        �Էµ� �̸��� ������������ ������
        
        �Է¸���             |     ��¸���
        abcde@naver.com     |     *****@*****.com
        efgh@danawa.co.kr   |     ****@******.co.kr
        
 ��ȭ       
        
        abcde@naver.com     |     a****@*a***.com
        efgh@danawa.co.kr   |     ****@******.co.kr
*/
SELECT 
FROM emp
WHERE
;



