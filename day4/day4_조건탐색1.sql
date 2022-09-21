
/*--------------------------------------------------------
 *                  교안4 - 조건탐색
 * ------------------------------------------------------*/
 
use bookstore;
show tables;
 
desc book;
select 1+1;

-- select .. from
select * from book; -- schema 생략
select * from bookstore.book;
-- test schema / booklibrary
select * from test.booklibrary;

-- all/distinct
select * from book;
select all * from book;
select publisher from book;
select distinct publisher from book;





-- 가격이 20000원 미만인 정보.
select * from book	where price < 20000; -- 저장된 순서.

select * from book	where price < 20000
    order by price;						  -- 인덱스에서 price

-- between : 가격 10000 에서 20000 사이인 정보.
select * from book
	where price between 10000 and 20000;
-- between : 가격 10000 에서 20000 사이인 정보를 도서이름으로 정렬.

select * from book
	where price between 10000 and 20000
    order by bookname  ;
-- between 을 대소비교로 사용.
select * from book	where ( price >= 10000 )
		                   and  ( price <= 20000 );



-- 가격이 22,000원 미만인 도서를 검색하시오.
SELECT	* 
FROM	bookstore.book
WHERE	price < 22000;


select * from orders;
desc orders;
-- 날짜 YYYY/MM/dd, YYYY MM dd
-- 주문일자가 2021-02-01 에서 2021-02-20 인 주문을 출력
SELECT * FROM bookstore.orders
	WHERE orderdate
		between '2021/02/01' AND '2021/02/10';
		-- between '2021-02-01' AND '2021-02-10';

SELECT * FROM bookstore.orders
	WHERE orderdate > '2021-02-01' AND orderdate < '2021-02-10';






/*
	IN 집합연산자
*/
-- 가격이 10000, 15000, 30000원인 도서
select * from book
	-- where price in (10000, 15000, 30000);
	where price not in (10000, 15000, 30000);

-- IN 집합연산자을 or 논리 연산자로 사용 --> 왜??? and는???
select * from book
	where price=10000
		or price=15000
        or price=30000;
-- IN ---> 대소비교?

-- 도서번호가 3,4,5,6 인 주문 목록을 출력
SELECT * 
FROM orders
WHERE bookid IN (3,4,5,6);

SELECT * 
FROM orders
WHERE bookid NOT IN (3,4,5,6);

SELECT * 
FROM orders
WHERE bookid BETWEEN 3 AND 6;

SELECT * 
FROM orders
WHERE bookid > 2 AND bookid <= 6;

-- 문자와 IN 연산자.
-- 도서출판사가 '한비사'인 도서.
select * from book;
select * from book
	where publisher in ('한비사');

select * from book
	where publisher = '한비사';




/*
	패턴 매칭
*/
-- 도서 이름이 '철'로 시작하는 도서
select * from book
	where bookname like '철%';
    
-- 도서 이름에 '사'가 포함된 도서
select * from book
	where bookname like '%사%';
    
-- 도서 이름이 6글자인 도서
select * from book
	where bookname like '______'; -- 6글자.(공백포함)
    
select * from book
	where bookname not like '% %';
select * from book
	where bookname not like '______';    
