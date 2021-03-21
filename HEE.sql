SELECT * FROM test;



---------------
--DDL
---------------

--내가 가진 table 확인
SELECT * FROM tab;
 --테이블의 구조 확인
DESC test;  
--테이블 삭제
DROP TABLE test;
SELECT * FROM tab;
--휴지통
PURGE RECYCLEBIN;--삭제된 테이블은 휴지통으로 들어간다

SELECT * FROM tab;

--CREATE TABLE
CREATE TABLE book (--컬럼 명세
    book_id NUMBER(5),  --5자리 숫자
    title VARCHAR(50) ,  --50글자 가변문자
    author VARCHAR2(10),    --10글자 가변문자열
    pub_date DATE DEFAULT SYSDATE   --기본값으로 현재 시간사용
);
DESC book;


--서브 쿼리를 활용한 테이블 생성
--hr,employees 테이블을 기반으로 일부 데이터를 추출
--새 테이블 생성
SELECT * FROM employees WHERE job_id like 'IT %';
CREATE TABLE it_emps AS (
    SELECT * FROM employees WHERE job_id like 'IT %'
);

SELECT * FROM it_emps;
CREATE TABLE emp_summary AS (
    SELECT employee_id
        first_name || ' ' || last_name full_name,
        hire_date, salary
    FROM hr.employees
    );
DESC emp_summary;
SELECT * FROM emp_summary;

-- author 테이블
DESC book;
CREATE TABLE author(
        author_id NUMBER(10),
        author_name VARCHAR(100) NOT NULL, 
        author_desc VARCHAR(500)
        PRIMARY KEY (author_id) --author_id컬럼을 pk로
        );
DESC author;
        
--book테이블에 author 테이블 연결을 위해
--book테이블의 author 컬럼을 삭제 :DROP COLUMN
ALTER TABLE book
DROP COLUMN author;
DESC book;


--author테이블 참조를 위한 author_id 컬럼을 book에 추가
ALTER TABLE book
ADD (author_id NUMBER(10));
DESC book;

--book 테이블의 pk로 사용할 book_id도 NUMBER(10)으로 변경
ALTER TABLE book
MODIFY (book_id NUMBER(10));
DESC book;

--제약조건의 추가 : ADD CONSTRATINT
--book 테이블의 book_id를 PRIMARY KEY 제약조건 부여
ALTER TABLE book
ADD CONSTRAINT pk_book_id PRIMARY KEY(book_id);
DESC book;


--FOREIGN KEY 추가
--book 테이블의 author_id가 며쇅dml author_id참조
ALTER TABLE book
ADD CONSTRAINT
    fk_author_id FOREIGN KEY (author_id)
        REFERENCES author(author_id);
DESC book;

--COMMENT
COMMENT ON TABLE book IS 'Book Information';
COMMENT ON TABLE author IS 'Author Information';

--테이블 커멘트 확인
SELECT * FROM user_tab_comments;
SELECT comments FROM user_tab_comments
WHERE table_name = 'BOOK';

-- Data Dictionary
--Oracle은 내부에서 발생하는 모든 정로를 Data Dictionary에 담아두고 있다
--계정별로 USER_(일반사용자), ALL_(전체 사용자), DBA_(관리자 전용) 접근 범위를 제한하고 있따
--모든 딕셔너리 확인
SHOW user;
SELECT * FROM dictionary;

--DBA 딕셔너리 확인
--dba로 로그인  필요

--사용자 DB 객체 dictionary USER_OBJECTS
SELECT * FROM user_objects;
SELECT object_name, object_type FROM user_objects;
SELECT *FROM user_objects WHERE OBJECT_NAME = 'BOOK';

--제약조건 확인 dictionary USER_CONSTRAINTS
SELECT * FROM user_constraints;
--제약조건이 걸린 컬럼확인
SELECT * FROM user_cons_columns;


