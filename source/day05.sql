/*
 �۹�ȣ | �ۼ��� | Ÿ��Ʋ | �ۼ��� | Ŭ����
 
 -������ �� 50�� -
 
���� | 1 | 2 | 3 | 4 | 5 | ����

*/

-- ������ �� ������� �Ϻθ� ��ȸ�ϱ�
-- ��ȸ�Ǵ� �����Ϳ� �ѹ����� �ؼ� ���ϴ� ������ŭ ��ȸ
-- �ѹ����ϴ� ������ �÷��� ����Ŭ���� ������ ��.
-- ROWNUM : 1���� �����ؾ� ��. ������տ� �ְ� ��ȣ�� ���̱� ������ �����ϴ� �ְ� ������ �ȸ������.
-- ROWNUM�� ����� ��Ī�� �༭ �������Ǹ� ����� ������ ���̺��� ����� �̸� ��ȣ�� �ο��ϰ� �߶󳽴ٸ� ����


-- �޿� ������ 6��°���� 10��°���� �����ȸ
-- ���� -> ��ȣ -> �̾ƿ���

SELECT -- 3. 6 ~ 10�� �̾ƿ���
    *
FROM 
    (
        SELECT ROWNUM rno, e.* -- 2. ��ȣ ���̱�
        FROM 
            (
                SELECT * -- 1. �޿� ������ ����
                FROM emp
                ORDER BY sal ASC
            ) e
    )
WHERE 
    rno BETWEEN 6 AND 10
;

-- ** ��ȣ ���̰� �������� �ʵ��� ����
SELECT -- 3. 6 ~ 10�� �̾ƿ���
    *
FROM 
    (
        SELECT ROWNUM rno, e.* -- 1. ��ȣ ���̱�
        FROM emp e
        ORDER BY sal ASC -- 2. �޿� ������ ����
    )
WHERE 
    rno BETWEEN 6 AND 10
;

/*
    ŷ�� ���.
    �ڱ� ���� �Է��ϸ� �Ի� ����!
    
*/
-- emp ���̺� �ڽ��� �����͸� �Է��ϼ���.
-- �����ȣ�� 1001������ ���������� �ڵ����� ������ �������Ǹ� ����ؼ� ó��.
-- �μ���ȣ�� dept ���̺� �ִ� �ɷ� �Է�
-- hiredate�� ���� ��¥

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
    '������',
    'MANAGER',
    to_char(trunc(sysdate,'dd'), 'yyyy/mm/dd hh24:mi:ss'),
    2000,
    20
);


/*
    ���� ���� �� Ư���� FROM �� ���� ���̴� �������Ǹ�
        '�ζ��� ��'��� �θ���.
        
    VIEW
        - ���������� �����ͺ��̽��� ������� ������ ������
            �����ؼ� ���̺�ó�� ����� �� �ִ� ��ü
        - ���ϴ� �����͸� ��ȸ ����
        - ���ȿ� ����
        - ������ ������ ����� ��� ����� ������ �ٽ� �ȸ��� ��
        - DB�����ڰ� ���� ����. ���� �ʿ�.
        
        => ���� �並 ���鶧�� �������ǰ� ����.
        
            �ܼ��� | �並 ���� �� �ϳ��� ���̺��� �̿��ؼ� ����� ���
                     DML ��ɾ� ��밡��(INSERT, UPDATE, DELETE, SELECT) - �信�� �����͸� �����ϸ� ���̺��� �����.
            
            ���պ� | 2�� �̻� / �����Ұ�
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

UPDATE -- ����
    emp_view
SET
    avg = 10000
WHERE  dno = 10
;



/*
    ��������
        - �ԷµǴ� �����Ͱ� Ʋ�� �����Ͱ� �Էµ��� ���ϵ��� ���� ����ϴ� ��
        - �����ͺ��̽��� �̻������� ���ϸ������� ���
        
        ���� ] 
            �⺻Ű ��������   : PRIMARY KEY. PK
                                UNIQUE + NOT NULL
            ����Ű ��������   : �ٸ� ���� �����Ϳ� �ߺ��ؼ� �Է��� �� ���� ��������. UK
                                UNIQUE
            NOT NULL �������� : �÷��� �ԷµǴ� �����Ͱ� �ݵ�� �־���ϴ� ��������.
            CHECK ��������    : �ԷµǴ� �����Ͱ� ���ǵ� ������ �� �ϳ����߸� �ϴ� ��������.
            
        ���� ]
            DEFAULT : �����͸� �Է��� �� ������ �ش��÷��� �������� �ʴ� ���
                        �⺻������ ä���ִ� �Ӽ�..?
        
        ���� ]
            
*/


/*
    �����ͺ��̽� �𵨸�
        1. �䱸���׺м����� ����� ���鸸 �����س���.
        
        2. ER Model�� �����.(����ȭ - ��1 ����ȭ, ��2 ����ȭ, ��3 ����ȭ)
        
        3. ER Diagram �ۼ�
        
        4. ���̺� ����
*/

/*
    �䱸���� �м�
        
        �䱸���� : 
            
            ����� �����ȣ�� ������.
            ����� �Ի��� ���� �Ի��� 0�� 0�� 0�ʸ� �Ի�ð����� �Ѵ�.
            ��� ������ 
                ����� �̸�, ����, ���, �Ի���, �޿�, Ŀ�̼�, �ҼӺμ��� �Է��Ѵ�.
            
            �μ� ������
                10�� �μ��� �μ��̸��� ...�̰� �μ���ġ�� �������̴�,
                20�� �μ��� ....
                30�� �μ��� ....
                40�� �μ��� ....
                
            ����� ���� �ϳ��� �μ��� �ݵ�� �ҼӵǾ�� �Ѵ�.
            
            ����� ������ ����, ����, ����, �븮, ����, ������ ���
            
            �޿� �����
                �޿� ����� �ּұ޿� 200�� �̻� �ִ� �޿� 300���� 1���
                ....
                                    3001 �̻�       999 ���ϴ� 5���
                                    
            ���ʽ� ������
                ���޴���� �̸�, ����, �޿�, Ŀ�̼��� ����Ѵ�.
*/


/*
    �����ͺ��̽� ����
        1. ������ ����
        2. ���� ���� 
        3. ������ ���� - ���̺� �̸�, �Ӽ��̸�, Ÿ��, 
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

-- losal NOT NULL �������� ����
ALTER TABLE sal_grade
MODIFY
    losal CONSTRAINT SALGRD_LO_NN NOT NULL
;

-- hisal UNIQUE �������� �߰�
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
            CHECK(job IN ('����', '����', '����', '�븮', '����', '����')
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
    1001, '������', '����', TRUNC(sysdate, 'dd'), 2000001, 1, 10
)
;

INSERT INTO
    k_emp(empno, ename, job, hiredate, sal, comm, deptno)
VALUES(
    1002, '������', '�븮', TRUNC(sysdate, 'dd'), 5000001, 1, 20
)
;





