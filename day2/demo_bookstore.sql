/* 이름: demo_bookstore.sql */
/* 설명 */
 
/* root 계정으로 접속, bookstore 데이터베이스 생성, user1 계정 생성 */
/* MySQL Workbench에서 초기화면에서 +를 눌러 root connection을 만들어 접속한다. */
DROP DATABASE IF EXISTS  bookstore;
DROP USER IF EXISTS  user1@localhost;

-- create user user1@localhost identified WITH mysql_native_password  by '012345';
create database bookstore;
grant all privileges on user1.* to user1@localhost with grant option;
commit;

/* madang DB 자료 생성 */
/* 이후 실습은 MySQL Workbench에서 초기화면에서 +를 눌러 bookstore connection을 만들어 접속하여 사용한다. */
 
USE bookstore;

CREATE TABLE Book (
  bookid      INTEGER PRIMARY KEY,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       INTEGER 
);

CREATE TABLE  Customer (
  custid      INTEGER PRIMARY KEY,  
  name        VARCHAR(40),
  address     VARCHAR(50),
  phone       VARCHAR(20)
);

CREATE TABLE Orders (
  orderid INTEGER PRIMARY KEY,
  custid  INTEGER ,
  bookid  INTEGER ,
  saleprice INTEGER ,
  orderdate DATE,
  FOREIGN KEY (custid) REFERENCES Customer(custid),
  FOREIGN KEY (bookid) REFERENCES Book(bookid)
);

INSERT INTO Book VALUES(1, '철학의 역사', '정론사', 7000);
INSERT INTO Book VALUES(2, '3D 모델링 시작하기', '한비사', 13000);
INSERT INTO Book VALUES(3, 'SQL 이해', '새미디어', 22000);
INSERT INTO Book VALUES(4, '텐서플로우 시작', '새미디어', 35000);
INSERT INTO Book VALUES(5, '인공지능 개론', '정론사', 8000);
INSERT INTO Book VALUES(6, '파이썬 고급', '정론사', 6000);
INSERT INTO Book VALUES(7, '객체지향 Java', '튜링사', 20000);
INSERT INTO Book VALUES(8, 'C++ 중급', '튜링사', 13000);
INSERT INTO Book VALUES(9, 'Secure 코딩', '정보사', 7500);
INSERT INTO Book VALUES(10, 'Machine learning', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '010-1234-1010');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '010-1223-3456');  
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '010-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 텍사스', '010-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

INSERT INTO Orders VALUES (1, 1, 1, 6000, STR_TO_DATE('2021-02-01','%Y-%m-%d')); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, STR_TO_DATE('2021-02-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, STR_TO_DATE('2021-02-03','%Y-%m-%d')); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, STR_TO_DATE('2021-02-04','%Y-%m-%d')); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, STR_TO_DATE('2021-02-05','%Y-%m-%d'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, STR_TO_DATE('2021-02-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, STR_TO_DATE( '2021-02-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, STR_TO_DATE('2021-02-08','%Y-%m-%d')); 
INSERT INTO Orders VALUES (9, 2, 10, 7000, STR_TO_DATE('2021-02-09','%Y-%m-%d')); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, STR_TO_DATE('2021-02-10','%Y-%m-%d'));

/*
 * 
 */
-- 여기는 3장에서 사용되는 Imported_book 테이블
CREATE TABLE Imported_Book (
  bookid      INTEGER,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       INTEGER 
);

INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);
commit;