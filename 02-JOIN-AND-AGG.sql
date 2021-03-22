------------
--JOIN
--------
DESC employees;
DESC departments;

--�� ���̺�κ��� ��� �����͸� �ҷ��� ���
-- CROSS JOIN : īƼ�� ���δ�Ʈ
-- �� ���̺��� ���� ������ ��� ���ڵ��� ��
SELECT employees.employee_id, employees.department_id,
    departments.department_id, departments.department_name
FROM employees, departments
ORDER BY employees.employee_id;

--�Ϲ������δ� �̷� ����� ������ ������
--ù ��° ���̺��� department_id ������ �� ��° ���̺��� department_id�� ��ġ
SELECT employees.employee_id, employees.first_name, employees.department_id,
    departments.department_id, departments.department_name
    FROM employees, departments
WHERE employees.department_id = departments.department_id;  --�� ���̺��� ���� ���� ������ �ο�
--INNER JOIN, Equi JOIN

--Į������ ��ȣ���� ���ϱ� ���� ���̺��.���̺� Į����
--���̺� ����(alias)�� �ٿ��ָ� ���ϰ� ��밡���ϴ�
SELECT employee_id, first_name, -- �÷����� �Ҽ��� ��Ȯ�ϸ� ���̺� ���� ������� �ʾƵ� �ȴ� 
    emp.department_id, 
    dept.department_id,
    department_name
FROM employees emp, departments dept --��Ī�� �ο��� ���̺��� ���
WHERE emp.department_id = dept.department_id;
--pk, ek -> index�� ���δ� (�˻��� ������)
--JOIN���� ���� ��� -> ������ �̷� (����)
--INNER JOIN : ������ // Theta Join�� �Ϻδ�  Equi-Join (��ǻ� ���ٰ� �����)
--Natural Join�� Equi-Join�� �Ϻ�

-----
-- INNER JOIN : Simple Join 
-----
SELECT * FROM employees; -- 107

SELECT first_name,
    emp.department_id,
    dept.department_id
    department_name
FROM employees emp, departments dept --���̺� ��Ī
WHERE emp.department_id = dept.department_id; --106

--JOIN���� ���� ����� �����ΰ�?
--�μ��� ��ӵ��� ���� ���
SELECT first_name, department_id
FROM employees
WHERE department_id is null;

SELECT first_name,
    department_id
    department_name
FROM employees  JOIN departments
                 USING (department_id);  --JOIN�� Į���� ���
                 
                 
--JOIN ON
SELECT first_name,
    emp.department_id,
    department_name
FROM employees emp JOIN departments dept
            ON (emp.department_id = dept.department_id);  --ON -> JOI���� WHERE�� // �ߺ��� �������Ǹ� �۵� ����
            

--Natural Join
--�� ���̺� ������ �� �� �ִ� ���� �ʵ尡 ���� ���(���� �ʵ尡 ��Ȯ�Ҷ�)
SELECT first_name, department_id, department_name
FROM employees NATURAL JOIN departments;

-----------
--Theta Join
-----------
--������ ������ ����ϵ� JOIN ������ = ������ �ƴ� ����� ����
SELECT * FROM jobs WHERE job_id = 'AD_ASST';
SELECT first_name, salary FROM employees emp, jobs j;
WHERE j.job_id = 'AD_ASST' AND
        salary_BETWEEN j.min_salary AND j.max_salary;

-------------
--OUTER JOIN
-------------
/*
���� �����ϴ� ¦�� ���� Ʃ�õ� null�� �����ؼ� ��¿� ������Ű�� JOIN
��� ���ڵ带 ����� ���̺��� ��ġ�� ���� LEFT, RIGHT, FULL OUTER JOIN���� ����
ORACLE�� ���, null�� ��µǴ� �����ʿ� (+)�� ���δ�
*/
--INNER JOIN ���� -106
--LEFT OUTER JOIN : ORACLE ver
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id (+);--LEFT OUTER JOIN


-- LEFT OUTER JOIN : ANSI SQL
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp LEFT OUTER JOIN departments dept -- emp ���̺��� ��� ���ڵ�� ��¿� ����
                    ON emp.department_id = dept.department_id;

--RIGHT OUTER JOIN : Oracle
SELECT first_name,
    emp.department_id,
    dept.department_id
    department_name
FROM employees emp, departments dept
WHERE emp.department_id (+) = dept.department_id;--departments ���̺��� ��� ����� ���


--RIGHT OUTER JOIN : ANSI SQL
SELECT first_name,
    emp.department_id,
    dept.department_id
    department_name
FROM employees emp RIGHT OUTER JOIN departments dept
                ON emp.department_id = dept.department_id;
                
--FULL OUTER JOIN : ���� ���̺� ��� ��¿� ����
/*
SELECT first_name,
    emp.department_id
    dept.department_id
    department_name
FROM employees emp, departments dept
WHERE emp.department_id (+) = dept.department_id(+);
*/

SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp FULL OUTER JOIN departments dept
                ON emp.department_id = dept.department_id;
                
                
--SELF JOIN : �ڽ��� FK�� �ڽ��� PK�� �����ϴ� ����� JOIN
-- �ڽ��� �� �� ȣ���ϹǷ� aloas ����� �� �ۿ� ���� JOIN 
SELECT emp.employee_id, emp.first_name,  --��� ����
    emp.manager_id,
    man.first_name
FROM employees  emp, employees man;
WHERE emp.manager_id = man.employee_id;


--ANSI SQL
SELECT emp.employee_id, emp.first_name,
        emp.manager_id,
        man.first_name
    FROM employees emp JOIN employees man
                    ON emp.manager_id = man.employee_id;
                    
                    
--------------------
--Aggregation(����)
--------------------
--�������� ���� �����Ͽ� �ϳ��� ������� ����
--count : ���� ���� �Լ�
--employees ���̺��� �� ���� ���ڵ带 ������ �ִ°�
SELECT count(*) FROM employees; --*�� ��ü ���ڵ� ī��Ʈ�� ����(���� ���� null�� �־ ����)
SELECT count (commission_pct) FROM employees; --Ư�� �÷��� ����ϸ� null�� ���� ���迡�� ����
SELECT count(*) FROM employees WHERE commission_pct in not null; -- ���� �Ͱ� ���� �ǹ�

--�հ� �Լ� : SUM
--�޿��� �� ��?
SELECT SUM(salary) FROM employees;

--��� �Լ� : AVG
--��� �޿� ����
SELECT AVG(salary) FROM employees;

--������� �޴� ��� Ŀ�̼� ����
SELECT AVG(commission_pct) FROM employees; --null �����ʹ� ���迡�� ����
SELECT AVG(nvl(commission_pct, 0)) FROM employees;

--null�� ���Ե� ����� null ���� ������ ������ �ƴ����� �����ϰ� ����

--salary�� �ּڰ�, �ִ�, ��հ�, �߾Ӱ�
SELECT MIN(salary), MAX(salary), AVG(salary), MEDIAN(salary)
FROM employees;

--���� ���ϴ� ����
--�μ��� ���̵�, �޿��� ����� ����ϰ���
SELECT department_id, AVG(salarty) FROM employees; --ERROR

--���࿡ �μ��� ��� ������ ���Ϸ���?
--�μ��� Group�� ������ �����͸� ������� ���� �Լ� ����
SELECT department_id, ROUND(AVG(salary), 2)
FROM employees
GROUP BY department_id
ORDER BY department_id;

--���� �Լ��� ����� SELECT �÷� ��Ͽ��� 
--���迡 ������ �ʵ�, �����Լ��� �� �� �ִ�

--�μ��� ��� �޿��� ������������ ���
SELECT department_id, ROUND(AVG(salary), 2) sal_avg --alias����ϴ°� ���� ���
FROM employees
GROUP BY department_id
ORDER BY sal_avg DESC;

--�μ��� ��� �޿��� ���� ��� �޿��� 2000�̻��� �μ��� ���
SELECT department_id, AVG(salary)
FROM employees
WHERE AVG(salary) >= 20000    --�� ���������� AVG(salary)�� ������� ���� ���� -> ����
GROUP BY department_id;
--Error : ���� �۾��� �Ͼ�� ���� WHERE���� ����Ǳ� ����



SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id--�׷���
    HAVING AVG(salary) >= 7000      --HAVING : Group by�� ������ �ο��Ҷ� ���
    ORDER BY department_id;