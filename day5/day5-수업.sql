
use bookstore;

-- 교안4




/*
	distinct
*/

-- 주문 고객목록
select custid from orders;

-- 주문이 있는 고객만 출력! 목록!
select distinct custid from orders;


-- 판매가격 목록
SELECT saleprice FROM orders;
SELECT DISTINCT saleprice FROM orders;

-- order by no
SELECT saleprice, custid FROM orders
	order by 2 desc;
SELECT custid, saleprice FROM orders
	order by 2 desc;



-- 주문한 사람 숫자!
select count(*) from orders;
select count(custid) from orders;
select custid from orders;

-- 주문이 있는 고객의 숫자
select DISTINCT count(custid) from orders;

SELECT count(DISTINCT custid) FROM orders;






/*
 * lec 11
 */
 
-- 도서를 이름순으로 검색하시오.
SELECT * FROM Book
ORDER BY bookname;







/*
	CASE
*/

-- 다중조건
SELECT CASE 10  -- column
		  WHEN 10 THEN '십'
		  WHEN 50 THEN '오십'
		  WHEN 100 THEN '일백'
       ELSE '기타'END
		AS '결과';

SELECT IF (100 > 300, '크다', '작다');

SELECT IF (price > 10000, '크다', '작다') from book;

select price from book;

SELECT bookname, 
	   CASE price
		  WHEN 7000 THEN '싸다'
		  WHEN 8000 THEN '괜잖다'
       ELSE '비싸다'END
		AS '결과' from book;


-- LIMIT
select * from orders
limit 2;

select * from book
limit 2, 2;


select * from orders
limit 2, 3
;










-- 교안5 내장함수

select 100*100, 100/100, 100+100, 100-100, 100%6;
desc book;
select 1.2 * price,			-- not null!!!
	price / 10,
    price - 100,
    price % 100
	from book;

select (price / 2) * 100 from book;
-- 논리 값: True (1), False (0)
select 100 > 1000;
select (100 > 1000) = True ;
select (100 > 1000) = 1 ;

select (100 > 1000) <> True ;
select (100 > 1000) != True ;


-- 논리연산:
-- 논리 값: True (1), False (0)
select True and False;
select True and True;
-- 비교식과 가장 많이 쓰인다.!!!
select (100 > 1000) and (100 > 20);  -- 동시만족!
select (100 > 1000) or (100 > 20);  -- 하나만 만족!
select not (100 > 1000) and (100 > 20);

select * from book
	where (price > 7000) and (price < 15000);





/* 내장함수 : null에 민감!!! */
--  북스토어의 도서 판매 건수를 구하시오.

SELECT	COUNT(*)      -- null
FROM     	 Orders;
desc orders;
SELECT	COUNT(*), COUNT(custid), COUNT(saleprice)
FROM     	 Orders;


--  고객이 주문한 도서의 총 판매액을 구하시오.
SELECT	SUM(saleprice) FROM	Orders;
desc orders;
SELECT	SUM(orderdate) FROM	Orders;
desc book;
SELECT	SUM(bookname) FROM	book;
select * from book;
select 100 + '10.1';





-- "예": 내장함수와 Alias 사용
-- 고객이 주문한 도서의 총 판매액을 '총매출' 로 구하시오.

SELECT	SUM(saleprice) AS 총매출
FROM	Orders;


-- 2의 1,2,3 제곱 값을 구하시오.
select power(2,1),power(2,2),power(2,3);



/* 문자열 다루기 */
-- 문자열 결합
SELECT CONCAT("도서명: ", bookname)
FROM book;

-- 문자열 결합.
select bookname, publisher from book;


select '하나' + '둘'; -- oracle 계열!

select concat('하나', '둘', '셋');

-- "00출판사에서 출간한 책 'ㅁㅁㅁ'"
-- select publisher '에서 출간한 책: ' bookname from book;

select publisher, '에서 출간한 책: ', bookname 
from book;

select concat( publisher, '에서 출간한 책: ', bookname)
from book;



-- "예" – 공백 제거 함수
-- TRIM() - 문자열 좌우 공백 제거
SELECT '           안녕하세요     ';
SELECT TRIM('             안녕하세요        ');
-- 문자열 좌우 문자 제거 (BOTH)
SELECT TRIM(BOTH '안' FROM '안녕하세요안');
-- 문자열 좌측 공백 제거 (LEADING)
SELECT TRIM(LEADING FROM ' 안녕하세요 ');

-- 문자열 좌측 문자 제거 (LEADING)
SELECT TRIM(LEADING '안' FROM '안녕하세요안');
-- 문자열 우측 공백 제거 (TRAILING)
SELECT TRIM(TRAILING FROM ' 안녕하세요 ');


-- 문자열 우측 문자 제거 (TRAILING)\
SELECT TRIM(TRAILING '요' FROM '요안녕하세요');


-- LTRIM
SELECT LTRIM(' 안녕하세요 ');

-- RLTRIM
SELECT RTRIM(' 안녕하세요 ');


/* 대소문자 */
SELECT UPPER('sql로 시작하는 하루');
SELECT UPPER('A에서 z까지 !');
SELECT LOWER('A에서 z까지 !');
SELECT UPPER(bookname) from book;



/* 추출 */

-- 안녕하세요 문자열에서 2번 인덱스에서 3개 문자를 추출
select substring('안녕하세요', 2,3);
select substring(bookname, 4, 3) from book;

-- 안.녕.하.세.요 문자열에서 . 를 만난후 2번째 까지 
select substring_index('안.녕.하.세.요', '.', 2);

-- 안.녕.하.세.요 문자열에서 . 를 만난후 뒤에서 -3번째 까지 
select substring_index('안.녕.하.세.요', '.', -3);

SELECT LEFT('안녕하세요', 3);

SELECT CASE UPPER( LEFT(bookname, 1) ) 
			WHEN '3' then '삼삼삼'
			WHEN '철' then 'IRON'
			ELSE '---' end
from book;

SELECT RIGHT('안녕하세요', 3);







/* 결합 */
SELECT  concat('홍길동', '모험');
SELECT  '홍길동', '모험';
SELECT  '홍길동' + '모험'; -- 연산안됨.
SELECT concat('도서명: ', bookname),
		concat('가격: ', price),
		concat(bookname, ' 가격: ', price)
	from book;






SELECT  concat_ws(',', '홍길동', '모험');
SELECT CONCAT_WS(":", bookname, publisher) FROM book;
SELECT bookname, ":", publisher FROM book;
SELECT CONCAT(bookname, ":", publisher) FROM book;

-- customer 의 name과 phone을 ':' 로 묶어 보자
SELECT GROUP_CONCAT(username, ":", phone)  "전화" FROM customer;
SELECT CONCAT_WS(':', username, phone) AS '전화' FROM customer;












SELECT LENGTH('Hello');
SELECT CHAR_LENGTH('Hello');
SELECT CHARACTER_LENGTH('Hello');

SELECT LENGTH('안녕하세요');
SELECT CHAR_LENGTH('안녕하세요');
SELECT CHARACTER_LENGTH('안녕하세요');




 /*
  * 날짜 연산
  */
select day('2021-8-31');
select month('2021-8-31');
select year('2021-8-31');
select hour('2021-8-31'); -- 시간
select last_day('2022-9-3');

select hour('2021-8-31 12:02:32'); -- YYYY MM DD hh:mm:ss
select minute('2021-8-31 12:02:32');

-- orders
select month(orderdate), day(orderdate) from orders;
-- '월/일' 형식
select concat(month(orderdate),'/', day(orderdate))
 from orders;

-- 현재 날짜/시간 함수
SELECT NOW(),SYSDATE(),CURRENT_TIMESTAMP;
SELECT CURTIME(), CURRENT_TIME;

select concat( month(NOW()),'/', day(NOW()));

select hour(current_time);

SELECT NOW(), NOW() + 1; -- 산술연산자는 정수/실수!
SELECT sum(NOW()), NOW() + 1;






-- 날짜 시간 증감 함수
SELECT ADDDATE('2021-8-31', INTERVAL 5 DAY),
	ADDDATE('2021-8-31', INTERVAL 1 MONTH);
-- now()
SELECT ADDDATE(now(), INTERVAL -5 DAY),
	ADDDATE(now(), INTERVAL -1 MONTH),
    ADDDATE(now(), INTERVAL -3 YEAR);
    
    
    
    
SELECT ADDTIME('2021-01-01 23:59:59', '1:1:1'), ADDTIME('09:00:00', '2:10:10');

-- "예" 날짜/시간 사이의 차이
SELECT DATEDIFF('2022-01-01', NOW());
SELECT TIMEDIFF('23:23:59', '2:1:1');

-- SUB -> 연도 --> 10일 더해서 -> 날짜
-- 날짜/시간 생성
SELECT MAKEDATE(2021, 364); -- DATE 형식!
SELECT DATE_FORMAT(MAKEDATE(2021, 55),'%Y.%m.%d');
-- CONCAT 으로도 많이 씀!!
SELECT MAKETIME(11, 11, 10); # hh:mm:ss




SELECT QUARTER('2021-04-04'); # 2




/* 03. 자료형 변환 함수 */

USE BOOKSTORE;

-- 데이터 형식 변환 함수

-- 구매 테이블 에서 평균 구매 개수를 구한다.
SELECT saleprice from orders;
SELECT AVG(saleprice) AS '평균 구매 가격' FROM orders;

-- 구매 가격을 정수로 출력 
SELECT CAST(AVG(saleprice) AS SIGNED INTEGER) 
       AS '평균 구매 가격' FROM orders;
SELECT CONVERT(AVG(saleprice), SIGNED INTEGER) AS '평균 구매 가격'
 FROM orders;

-- 데이터 형식 변환 함수
--  CAST( ) 함수에 다양한 구분자($, /, %, @)를 날짜 형식으로 사용할 수 있다.
SELECT CAST('2021$09$20' AS DATE) AS '날짜';
SELECT CAST('2021/09/20' AS DATE) AS '날짜';
SELECT CAST('2021%09%20' AS DATE) AS '날짜';
SELECT CAST('2021@09@20' AS DATE) AS '날짜';
SELECT CAST('2020-10-19 12:35:29.123' AS DATETIME)
       AS 'DATETIME';





-- Date and Time Data Types
-- 날짜 데이터 형식과 시간 데이터 형식
-- (명시적 형변환)
SELECT CAST('2020-10-19 12:35:29.123' AS DATE)
       AS 'DATE';

SELECT CAST('2020-10-19 12:35:29.123' AS TIME)
       AS 'TIME';

SELECT CAST('2020-10-19 12:35:29.123' AS DATETIME)
       AS 'DATETIME';
-- 암묵적 형 변환: 연산의 결과에 따른 규칙
select "안" + "녕";
select "3mega";

SELECT '100' + '200'; -- 문자와 문자를 더함(정수로 변환한 후 처리) 
SELECT CONCAT('100', '200'); -- 문자와 문자를 연결(문자열 그대로 처리) 
SELECT CONCAT( 100, '200'); -- 정수와 문자를 연결(정수를 문자로 변환하여 처리) 
SELECT 1 > '3mega'; -- 정수인 3으로 변환한 후 비교 
SELECT 4 > '3MEGA'; -- 정수인 3으로 변환한 후 비교 
SELECT 0 = 'mega3'; -- 문자가 0으로 변환됨

-- 
-- 현재시간을 날짜로 
 SELECT CAST(now() AS DATE);


 SELECT CAST("123" AS UNSIGNED);

-- 바로 앞의 SELECT 문에서 조회된 행의 개수를 반환
 SELECT * FROM ORDERS;
 SELECT FOUND_ROWS();




/*
 * 16차시 실습 
 */
USE BOOKSTORE;

-- 현재 날짜시간 조회
SELECT CURRENT_TIMESTAMP;
SELECT NOW();     # 2021-03-07 오후 9:27:21
SELECT SYSDATE(); #2021-03-07 오후 9:27:21
SELECT CURDATE(); #2021-03-07 오전 12:00:00


-- 현재 날짜형식을 출력
SELECT DATE_FORMAT(CURDATE(),'%Y-%M-%d');
SELECT DATE_FORMAT(CURDATE(),'%d-%m, %Y');
SELECT DATE_FORMAT(CURDATE(),'%d-%m, %Y');

-- ORDERDATE 컬럼 를 특정 형식(format)의 문자열로 변환하여 반환하기
SELECT ORDERDATE FROM ORDERS;
SELECT DATE_FORMAT(orderdate,'%Y/%M/%d')
from ORDERS;


/* 데이터 형식 변환 함수 */

-- 문자열 날짜 데이터 형식을 DATE 형식으로
SELECT CAST('2021-02-19 10:11:40' AS DATE)
       AS 'DATE';

-- 문자열 시간 데이터 형식 DATETIME, TIME 형식으로
SELECT CAST('2021-02-19 10:11:40' AS TIME)
       AS 'TIME';

SELECT CAST('2021-02-19 10:11:40' AS DATETIME)
       AS 'DATETIME';


-- CAST 와 $,%,@ 이용 날짜형 생성
SELECT CAST('2021$09$20' AS DATE) AS '날짜' ;
SELECT CAST('2021/09/20' AS DATE) AS '날짜';
SELECT CAST('2021%09%20' AS DATE) AS '날짜';
SELECT CAST('2021@09@20' AS DATE) AS '날짜';


-- ORDERDATE 컬럼
SELECT * FROM ORDERS;
SELECT CAST(ORDERDATE AS DATETIME) FROM ORDERS;


-- 현재시간을 날짜로 
SELECT now(); # YYYY-MM-DD hh:mm:ss 형식
SELECT CAST(now() AS DATE);


-- 날짜 및 시간 더하기/빼기
-- 기준날짜로부터 하루 뒤 날짜 조회
SELECT DATE_ADD("2021-03-07 23:59:59", INTERVAL 1 DAY);

-- 한시간 전 
SELECT NOW(),DATE_ADD(NOW(), INTERVAL -1 MONTH) AS 한달전;
SELECT NOW(),DATE_ADD(NOW(), INTERVAL -1 DAY) AS 하루전;
SELECT NOW(),DATE_ADD(NOW(), INTERVAL -1 HOUR) AS 한시간전;

-- ORDERS 테이블에서 주문일자의 한달 /  하루 이전 날짜 계산
-- SELECT ORDERDATE FROM ORDERS WHERE ORDERDATE >= DATE_ADD(NOW(), INTERVAL -1 MONTH); 
SELECT ORDERDATE, 
	DATE_ADD(ORDERDATE, INTERVAL -1 MONTH),
	DATE_ADD(ORDERDATE, INTERVAL -1 DAY) FROM ORDERS; 

-- ORDERS 테이블에서 주문일자의 하루 전 날짜의 주문을 조회
SELECT CUSTID, ORDERDATE, 
	DATE_ADD(ORDERDATE, INTERVAL -1 DAY) AS 하루전
FROM ORDERS 
WHERE ORDERDATE >= DATE_ADD(ORDERDATE, INTERVAL -1 DAY); 
