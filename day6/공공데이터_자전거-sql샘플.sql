/*
 * 37차시 실습
 */
-- 스크마 생성
use seoul_data;

/* 1. bicycle_202012 테이블 생성 */

-- 2020/12월 공공자전거 테이블
-- bicycle_202012

/* 2. 데이터 들여오기 */

-- SELECT @@max_allowed_packet / 1024 / 1024;

desc bicycle_202012;


-- 전체 개수
select count(*) from bicycle_202012;

select * from bicycle_202012 limit 50;

-- 대여소 개수
-- 대여소 번호, 대여소 이름 개수
select count('대여소번호')         -- count(`대여소번호`) 
from bicycle_202012;

select count(*), count('대여소번호'), count('대여소명'), count('이용거리')
from bicycle_202012;

-- 한글 컬럼 이름.
select count( distinct '대여소번호')
from bicycle_202012;

select count( distinct `대여소번호`)
from bicycle_202012;

select count(*), count(`대여소번호`), count(`대여소명`), count(`이용거리`)
from bicycle_202012;


select count(distinct `대여소번호`) '대여소번호', 
	   count(distinct `대여소명`) '대여소명' from bicycle_202012;




-- 자전거 번호별 대여횟수
select `자전거번호`,
		count(`자전거번호`) '대여한 숫자'
from bicycle_202012
group by 1	-- `자전거번호`
order by 2 desc
;



-- 대여소별 대여한 자전거 숫자
select `대여소명`,
	count(distinct `자전거번호`) '수량'
from bicycle_202012
group by 1
order by 2 desc
;

-- 자전거별 이용(이용시간) 횟수, 총 이용시간
-- 자전거번호
select `자전거번호`,
	count(`이용시간`) 횟수,
    (sum(`이용시간`) / 60 ) 시간
from bicycle_202012
group by `자전거번호`
order by 3 desc
;











/*
 * 38 차시 실습 
    - 데이터 종류, 지표 등 살펴보기
 */

USE seoul_data;


/*
 BICYCLE_RENTAL 뷰 생성
 */

-- BICYCLE_202012 의 모든 컬럼을 대상으로 뷰 생성
CREATE OR REPLACE VIEW BICYCLE_RENTAL
AS 
	SELECT * FROM BICYCLE_202012;

DESC BICYCLE_RENTAL;



--
SELECT * FROM BICYCLE_RENTAL limit 10;


-- 뷰에서 대여소 개수, 전체 레코드 수
-- 2095	1185907
SELECT  COUNT(DISTINCT 대여소번호 ) `대여소숫자`
	, COUNT(*) 레코드수
FROM  BICYCLE_RENTAL;






-- 자전거 수량

SELECT `대여소번호` from bicycle_rental;


-- 대여소별 사용한 자전거 수량 
-- 대여소번호 기준
SELECT `대여소번호`,
	`대여소명`, 
    COUNT(DISTINCT `자전거번호`) `수량`
FROM BICYCLE_RENTAL
GROUP BY 1, 2
ORDER BY 3 DESC;






-- 대여소별 사용한 자전거 
-- 대여소번호 기준






-- 대여소별 이용량(시간)이 많은 곳.
-- 대여소번호, 대여소명 기준
SELECT  대여소번호
	, 대여소명
	-- , COUNT(이용시간)
    , sum(이용시간)
FROM  BICYCLE_RENTAL
GROUP BY  1,2
ORDER BY  3 DESC ;



-- 월별 이용시간 집계
-- 총이용시간, 평균, 최소, 최대, 평균 이용거리
SELECT DATE_FORMAT(대여일시,'%Y-%m') MONTHLY,
		SUM(이용시간) 합계,
        AVG(이용시간) 평균,
		MIN(이용시간) 최소,
        MAX(이용시간) 최대,
        AVG(이용거리) 평균거리
FROM BICYCLE_RENTAL
GROUP BY MONTHLY
ORDER BY 1;



-- 자전거별 월별 이용시간 집계
-- 자전거번호, 월별



/* 대여횟수 */
-- 월별 대여횟수
-- 월간 기준



-- 월 기준 대여소별 대여횟수
-- 월간, 대여소명 기준
SELECT DATE_FORMAT(대여일시,'%Y-%m') MONTHLY
	, 대여소명
    , COUNT(대여일시) 횟수
FROM BICYCLE_RENTAL
GROUP BY MONTHLY, 대여소명
ORDER BY 1;


-- 일별+대여소 이용량
-- 대여일시, 대여소명 기준
SELECT 	DATE_FORMAT( 대여일시, "%Y%m%d") AS 대여일시, 
		대여소명,
		COUNT(자전거번호) 수량, 
        AVG(이용시간) 평균시간,
        AVG(이용거리) 평균거리
FROM  BICYCLE_RENTAL
GROUP BY 대여일시, 대여소명
ORDER BY  1 ASC;



/* bicycle202101 */
show tables;


select count(*) from bicycle_202012;

select count(*) from bicycle_202101;


-- BICYCLE_RENTAL 뷰 생성

CREATE OR REPLACE VIEW BICYCLE_RENTAL
AS 
	SELECT * FROM BICYCLE_202012
    
    UNION
    ALL
    
  	SELECT * FROM BICYCLE_202101
;

select count(*) from bicycle_rental;


DESC BICYCLE_RENTAL;



-- 월별 이용시간 집계
-- 총이용시간, 평균, 최소, 최대, 평균 이용거리
SELECT DATE_FORMAT(대여일시,'%Y-%m') MONTHLY,
		SUM(이용시간) 합계,
        AVG(이용시간) 평균,
		MIN(이용시간) 최소,
        MAX(이용시간) 최대,
        AVG(이용거리) 평균거리
-- FROM bicycle_202012                      -- 2.6sec
-- FROM bicycle_202101                      -- 1.7sec
from bicycle_rental                         -- 9.3sec
GROUP BY MONTHLY
ORDER BY 1;


-- 대여소별 이용시간이 평균보다 높은 곳.
-- 1.
SELECT AVG(이용시간) FROM BICYCLE_RENTAL;

-- 2.
SELECT  대여소번호
	, 대여소명
	, COUNT(*) 횟수
FROM  BICYCLE_RENTAL
WHERE 이용시간 >= ( SELECT AVG(이용시간) FROM BICYCLE_RENTAL)
GROUP BY  1,2
ORDER BY  3 DESC ;


-- 요일별 평균 이용시간
SELECT
	CASE DAYOFWEEK(대여일시)
		WHEN 1 THEN "Sun"
		WHEN 2 THEN "Mon"
		WHEN 3 THEN "Tue"
		WHEN 4 THEN "Wed"
		WHEN 5 THEN "Thu"
		WHEN 6 THEN "Fri"
		WHEN 7 THEN "Sat"
	  END AS 요일
    , AVG(이용시간) AS 시간
FROM BICYCLE_RENTAL
-- WHERE 이용시간 >= ( SELECT AVG(이용시간) FROM BICYCLE_RENTAL)
GROUP BY  1
;





























