-------------

--DB 객체 
-------------

--VIEW : 한개 혹은 복수 개의 테이블을 기반으로 함, 실제 데이터는 갖고 있지 않다
--VIEW 생성을 위해서는 CREATE VIEW 권한이 필요
--system으로 로그인
GRANT CREATE VIEW TO C##HEE; --C##에게 VIEW 생성

--simple VIEW
--단일 테이블 혹은 뷰를 기반으로 생성
--제약조건 위반이 없다면 INSERT, UPDATE, DELETE가능
--employees 테이블로부터 department_id가 10인 사람들만 VIEW로 생성
CREATE OR REPLACE VIEW emp_10
    AS SELECT employee_id, first_name, last_name, salary
        FROM hr.employees;
        
        SELECT * FROM emp_10;
    CREATE OR REPLACE VIEW view_emp_10
    AS SELECT * FROM emp_10;--기반 테이블 emp_10
    
DESC view_emp_10;
--VIEW는 테이블처럼 조회 할 수 있다
--실제 데이터는 기반 테이블에서 가지고 온다
SELECT * FROM view_emp_10;