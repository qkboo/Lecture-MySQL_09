
/* 
 * 데이터 Top 50, Top 10 집계
*/

-- 대여소 숫자
-- 기존 202012 테이블: 2095	1185907
SELECT  COUNT(DISTINCT 대여소번호 ) 대여소숫자
	, COUNT(*) 레코드수
FROM  V_BICYCLE_RENTAL;


-- 자전거 수량
SELECT COUNT(DISTINCT 자전거번호) 수량
FROM V_BICYCLE_RENTAL
;

-- 대여소별 이용량이 많은 곳.
SELECT  대여소번호
	, 대여소명
	, COUNT(*)
FROM  V_BICYCLE_RENTAL
GROUP BY  1,2
ORDER BY  3 DESC ;


-- 대여소별 이용시간이 평균보다 높은 곳.
SELECT  AVG(이용시간) 평균
FROM  V_BICYCLE_RENTAL;

SELECT  대여소번호
	, 대여소명
    , AVG(이용시간) 평균
	, COUNT(*) 횟수
FROM  V_BICYCLE_RENTAL
WHERE 이용시간 >= 25
GROUP BY  1,2
ORDER BY  3 ;

-- 서브쿼리
SELECT  대여소번호
	, 대여소명
    , AVG(이용시간) 평균
	, COUNT(*) 횟수
FROM  V_BICYCLE_RENTAL
WHERE 이용시간 >= ( SELECT AVG(이용시간) FROM V_BICYCLE_RENTAL)
GROUP BY  1,2
ORDER BY  3 ;





-- 2. 요일별 평균 이용시간
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
WHERE 이용시간 >= ( SELECT AVG(이용시간) FROM BICYCLE_RENTAL)
GROUP BY  1
;

SELECT DATE_FORMAT(대여일시,'%Y-%m') MONTHLY
	, CASE DATE_FORMAT( 대여일시, '%p')
		WHEN 'AM' THEN "오전"
		WHEN 'PM' THEN "오후"
	  END AMPM
    , AVG(이용시간) AS 시간
FROM BICYCLE_RENTAL
WHERE 이용시간 >= ( SELECT AVG(이용시간) FROM BICYCLE_RENTAL)
GROUP BY  1
;



-- ifnull 활용
SELECT  IFNULL(대여소명,'소계')
	,  IFNULL(자전거번호,'소계')
    , SUM(이용시간)
FROM BICYCLE_RENTAL
WHERE DATE_FORMAT(대여일시,'%Y-%m-%d') BETWEEN "2020-12-01" AND  "2020-12-05"
GROUP BY 대여소명, 자전거번호 WITH ROLLUP
;




/* 이용량 Top10 */


-- 대여소별 이용량이 많은 곳에 대한 top10
-- 1 대여소별 순위
SELECT  대여소번호 
	, 대여소명
	, COUNT(*) 수량
    , ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) RNK
FROM  BICYCLE_RENTAL
GROUP BY  1,2
;

-- 2 대여소별 순위에서 TOP10
SELECT * 
FROM (
	SELECT  대여소번호 
		, 대여소명
		, COUNT(*) 수량
		, ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) RNK
	FROM  BICYCLE_RENTAL
	GROUP BY  1,2
) A
WHERE RNK <= 10;
;


-- 월 기준 대여소별 이용량이 많은 곳에 대한 top10
SELECT DATE_FORMAT(대여일시,'%Y-%m') MONTHLY
	, 대여소명
    , COUNT(*) 횟수
    , ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) RNK
FROM BICYCLE_RENTAL
GROUP BY MONTHLY, 대여소명
;




/*---------------------------------------
 * 대여소 이용량 집계
 *---------------------------------------*/

-- 대여소별 이용량 집계
SELECT 	대여소번호,
		대여소명,
		COUNT(*) 횟수 
		-- COUNT(자전거번호) 횟수, 
FROM  BICYCLE_RENTAL
GROUP BY 대여소번호,대여소명
;


-- 대여소별 이용량이 많은 곳에 대한 top10
-- 1. 순위
SELECT 	대여소번호,
		대여소명,
		COUNT(*) 횟수,
        ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) RNK
FROM  BICYCLE_RENTAL
GROUP BY 대여소번호,대여소명
;

-- 2 대여소별 순위에서 TOP10
SELECT * 
FROM (
	SELECT  대여소번호 
		, 대여소명
		, COUNT(*) 수량
		, ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) RNK
	FROM  BICYCLE_RENTAL
	GROUP BY  1,2
) A
WHERE RNK <= 10;
;




-- 대여소별 자전거 수량
SELECT 대여소번호
	, 대여소명
	, COUNT(DISTINCT 자전거번호) 수량
FROM BICYCLE_RENTAL
GROUP BY 대여소번호,대여소명
ORDER BY 3 DESC
;


-- 총이용시간별 대여소 등급
SELECT  대여소번호
	, 대여소명
	, COUNT(DISTINCT 자전거번호) 수량
	, SUM(이용시간) AS 총시간
    , CASE 
          WHEN (SUM(이용시간) >= 80000) THEN '최우수'
          WHEN (SUM(이용시간)  >= 15000) THEN '우수'
          WHEN (SUM(이용시간)  >= 8000 ) THEN '일반'
          ELSE '기타'
       END AS '등급'
FROM BICYCLE_RENTAL
GROUP BY 대여소번호, 대여소명
ORDER BY 4 DESC
;
