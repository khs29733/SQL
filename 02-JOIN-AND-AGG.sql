------------
--JOIN
--------
DESC employees;
DESC departments;

--두 테이블로부터 모든 데이터를 불러올 경우
-- CROSS JOIN : 카티젼 프로덕트
-- 두 테이블의 조합 가능한 모든 레코드의 쌍
SELECT employees.employee_id, employees.department_id,
    departments.department_id, departments.department_name
FROM employees, departments
ORDER BY employees.employee_id;

--일반적으로는 이런 결과를 원하지 않을것
--첫 번째 테이블의 department_id 정보와 두 번째 테이블의 department_id를 일치
SELECT employees.employee_id, employees.first_name, employees.department_id,
    departments.department_id, departments.department_name
    FROM employees, departments
WHERE employees.department_id = departments.department_id;  --두 테이블의 연결 정보 조건을 부여
--INNER JOIN, Equi JOIN

--칼럼명의 모호성을 피하기 위해 테이블명.테이블 칼럼명
--테이블에 별명(alias)를 붙여주면 편리하게 사용가능하다
SELECT employee_id, first_name, -- 컬럼명의 소속이 명확하면 테이블 명은 명시하지 않아도 된다 
    emp.department_id, 
    dept.department_id,
    department_name
FROM employees emp, departments dept --별칭을 부여한 테이블의 목록
WHERE emp.department_id = dept.department_id;
--pk, ek -> index를 붙인다 (검색이 빨라짐)
--JOIN절은 관계 대수 -> 수학적 이론 (집합)
--INNER JOIN : 교집합 // Theta Join의 일부는  Equi-Join (사실상 같다고 보면됨)
--Natural Join은 Equi-Join의 일부

-----
-- INNER JOIN : Simple Join 
-----
SELECT * FROM employees; -- 107

SELECT first_name,
    emp.department_id,
    dept.department_id
    department_name
FROM employees emp, departments dept --테이블 별칭
WHERE emp.department_id = dept.department_id; --106

--JOIN되지 않은 사원은 누구인가?
--부서에 배속되지 않은 사원
SELECT first_name, department_id
FROM employees
WHERE department_id is null;

SELECT first_name,
    department_id
    department_name
FROM employees  JOIN departments
                 USING (department_id);  --JOIN할 칼럼을 명시
                 
                 
--JOIN ON
SELECT first_name,
    emp.department_id,
    department_name
FROM employees emp JOIN departments dept
            ON (emp.department_id = dept.department_id);  --ON -> JOI문의 WHERE절 // 중복이 여러번되면 작동 안함
            

--Natural Join
--두 테이블에 조인을 할 수 있는 공통 필드가 있을 경우(공통 필드가 명확할때)
SELECT first_name, department_id, department_name
FROM employees NATURAL JOIN departments;

-----------
--Theta Join
-----------
--임의의 조건을 사용하되 JOIN 조건이 = 조건이 아닌 경우의 조인
SELECT * FROM jobs WHERE job_id = 'AD_ASST';
SELECT first_name, salary FROM employees emp, jobs j;
WHERE j.job_id = 'AD_ASST' AND
        salary_BETWEEN j.min_salary AND j.max_salary;

-------------
--OUTER JOIN
-------------
/*
조건 만족하는 짝이 없는 튜플도 null을 포함해서 출력에 참여시키는 JOIN
모든 레코드를 출력할 테이블의 위치에 따라서 LEFT, RIGHT, FULL OUTER JOIN으로 구분
ORACLE의 경우, null이 출력되는 조건쪽에 (+)를 붙인다
*/
--INNER JOIN 참고 -106
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
FROM employees emp LEFT OUTER JOIN departments dept -- emp 테이블의 모든 레코드는 출력에 참여
                    ON emp.department_id = dept.department_id;

--RIGHT OUTER JOIN : Oracle
SELECT first_name,
    emp.department_id,
    dept.department_id
    department_name
FROM employees emp, departments dept
WHERE emp.department_id (+) = dept.department_id;--departments 테이블의 모든 결과를 출력


--RIGHT OUTER JOIN : ANSI SQL
SELECT first_name,
    emp.department_id,
    dept.department_id
    department_name
FROM employees emp RIGHT OUTER JOIN departments dept
                ON emp.department_id = dept.department_id;
                
--FULL OUTER JOIN : 양쪽 테이블 모두 출력에 참여
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
                
                
--SELF JOIN : 자신의 FK가 자신의 PK를 참조하는 방식의 JOIN
-- 자신을 두 번 호출하므로 aloas 사용할 수 밖에 없는 JOIN 
SELECT emp.employee_id, emp.first_name,  --사원 정보
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