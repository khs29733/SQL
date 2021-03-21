/*
사용자 생성
CREATE USER C##NAME IDENTIFIED BY ~;

사용자 삭제 
DROP USER C##이름
DROP USER C##이름 CASCADE-연결된 객체도 모두 삭제
권한을 가지고 있지 않으면 아무일도 못함
*/

--system으로 진행
-- 사용자 정보 확인
--USER_USeRS : 현재 사용자 관련 정보
--ALL_USERS: DB의 모든 사용자 정보
--DBA_USERS: 모든 사용자의 상세 정보(DBA ONLY)

--현재 사용자 확인
SELECT * FROM USER_USERS;
-- 전체 사용자 확인
SELECT * FROM ALL_USERS;

--로그인 권한 부여
GRANT create session To C##HEE; --C##HEE에게 세션 생성 (로그인) 권한을 부여

/*로그인 해서 다음의 쿼리를 수행해 봅니다
CREATE TABLE test(a NUMBER); -- 권한 불충분
*/
GRANT connect, resource TO C##HEE;  --접속과 지원 접근 롤을 C##HEE에게 부여

/* 다시 로그인해서 다음의 쿼리를 수행해 봅시다
CREATE TABLE test(a NUMBER); --테이블이 생성
SELECT * FROM tab;
INSERT INTO test
VALUES(10);
*/

/*보충 설명
Oracle 12이후
    -일반 계정 구분하기 위해 C## 접두어
    -실제 데이터가 저장될 테이블 스페이스 마련해 줘야 한다 - USERS 테이블 스페이스에 공간을 마련해줘야한다
*/
/*C## 없이 계정 생성방법*/
--ALTER SESSION SET "_ORACLE_SCRIPT"= true;
--CREATE USER ~ IDENTIFIED BY 1234;
/* 사용자 데이터 저장 테이블 스페이스 부여*/
ALTER USER C##HEE DEFAULT TABLESPACE USERS --C##HEE 사용자의 저장 공간을 USERS에 마련
    QUOTA unlimited ON USERS; --저장 공간 한도를 무한으로 부여
/*









