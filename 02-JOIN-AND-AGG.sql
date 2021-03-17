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