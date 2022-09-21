
/* 
NULL 
*/
select * from customer;


select * from customer;
select * from customer	where custid=5;
    
SELECT 	*
FROM 	customer WHERE 	phone IS NULL;

select count(*) from customer;
select count(username) from customer;
select count(phone) from customer;




-- null인 문자열 결합
select concat('전화번호: ', phone)	-- 문자열 결합 함수
from customer;

-- 컬럼의 null 판단!!!
SELECT 	count(*)
FROM 	customer
WHERE 	phone IS NULL;



-- book의 price가 null인 레코드 추가
select * from book;
INSERT INTO book VALUES(11, 'SQL 기본기 다지기', 'MS출판사', null);

select * from book;
SELECT * FROM 	book WHERE 	price IS NULL;
select count(*) from book;
select count(price) from book;
select count(bookname) from book;

SELECT * FROM 	book WHERE 	price IS NULL;
SELECT * FROM 	book WHERE 	price = '';


-- 레코드 11번에 price를 1000원 올려서 출력
SELECT price+1000 FROM BOOK WHERE bookid=11;
SELECT bookid, price+1000 FROM BOOK;

--  price 컬럼에 집계함수를 실행해 보자.
SELECT SUM(price), AVG(price), COUNT(*), COUNT(price)
FROM book;


SELECT    SUM(price), AVG(price), COUNT(*)
FROM     book
WHERE    bookid < 11;

-- IFNULL 널 조건 추가.
-- 이름, 전화번호가 포함된 고객목록 조회하고 전화번호가 없는 고객은 ‘연락처없음’으로 표시하자.
SELECT 	username AS '이름', IFNULL(phone, '연락처없음') '전화번호'
FROM 	Customer;

-- book 테이블 PRICE 가 null 이면 '-' 출력!
select bookname, ifnull(price, '-') from book;
