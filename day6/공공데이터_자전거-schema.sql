/*
 * 37차시
 */

CREATE schema if not exists seoul_data;

use seoul_data;

/* 1. 테이블 생성 */

-- 2020/12월 공공자전거 테이블
CREATE TABLE IF NOT EXISTS `bicycle_202012` (
  `자전거번호` varchar(12),
  `대여일시` datetime,
  `대여소번호` int,
  `대여소명` varchar(100),
  `대여거치대` int DEFAULT NULL,
  `반납일시` datetime,
  `반납대여소번호` int,
  `반납대여소명` varchar(100),
  `반납거치대` int DEFAULT NULL,
  `이용시간` int DEFAULT NULL,
  `이용거리` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*
CREATE TABLE `bicycle_rent` (
  `ID` varchar(12),            -- 자전거번호
  `LD_TIME` datetime,          -- 대여일시
  `ST_ID` int,				         -- 대여소번호
  `ST_NAME` varchar(100),		   -- 대여소명
  `LD_RACK` int DEFAULT NULL,	 -- 대여거치대
  `RT_TIME` datetime,		       -- 반납일시
  `RT_STID` int,				       -- 반납대여소번호
  `RT_ST` varchar(100),		     -- 반납대여소이름 
  `RT_RACK` int DEFAULT NULL,  -- 반납거치대
  `U_TIME` int DEFAULT NULL,	 -- 이용시간 
  `U_DIST` double DEFAULT NULL -- 이용거리
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
*/


/* 2. 202101 테이블 */

CREATE TABLE IF NOT EXISTS `bicycle_202101` (
  `자전거번호` varchar(12),
  `대여일시` datetime,
  `대여소번호` int,
  `대여소명` varchar(100),
  `대여거치대` int DEFAULT NULL,
  `반납일시` datetime,
  `반납대여소번호` int,
  `반납대여소명` varchar(100),
  `반납거치대` int DEFAULT NULL,
  `이용시간` int DEFAULT NULL,
  `이용거리` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

