-- 1. data import 를 통해 외부 csv 덤프
/*
 * 03. 실습 테이블 생성하고 data 입력 
 * pet.csv
 */

use lectures;
show tables;

select * from pet;


-- 품종이 cat 인 데이터
SELECT * FROM pet WHERE species = 'dog';

SELECT * FROM pet WHERE name = 'Bowser';
-- owner = 'Benny'
SELECT * FROM pet WHERE owner = 'Benny';

SELECT birth, death FROM pet;

SELECT birth, death FROM pet 	WHERE owner = 'Benny';
SELECT birth, death, birth, death FROM pet 	WHERE owner = 'Benny';



-- 이름 ***인 데이터!
SELECT * FROM pet 
WHERE name = 'Bowser' 
;

-- 성별이 m 인 데이터
SELECT * FROM pet  WHERE  sex = 'm' ;
SELECT * FROM pet WHERE sex = 'f' ;

-- 중복조건: and, or
select 100 > 200;  -- true:1, false:0


-- 품종이 dog 이고 성별이 F 인 데이터
select * from pet  where species = 'dog' and sex = 'f';
-- 품종이 snake 또는 품종이 bird 인 데이터.
select * from pet where species = "snake" or species = "bird";

-- Owner가 Gwen 이고 Species 가 bird 인 데이터: name, species, birth
select name,species,birth from pet  
	where species = 'bird' and owner = 'Gwen';

-- Owner가 Gwen 또는 Harold 인 데이터: name, species, birth
select name,species,birth from pet  
	where owner = 'Harold' or owner = 'Gwen';






-- 문자화 날짜.
-- YYYY MM DD, YYYY-MM-DD, YYYY/MM/DD
-- birth가 1998-1-1 일 이후
select * from pet where birth >= '1998-02-01'; 

select * from pet where birth >= '01/02/1998'; 

-- birth 가 1990 보다 크고 1993 보다 작은 레코드
select * from pet where birth >= '1990-01-01'
                  and birth <= '1993-12-31'; 

desc pet;




/* order by : 동물의 생일이 날짜 순으로 오름차수 정렬된 결과를 원하면: */

SELECT name, birth  FROM pet ORDER BY name asc; 

SELECT name, birth  FROM pet ORDER BY name; 

-- 내림차순
SELECT name, birth FROM pet ORDER BY name desc; 
SELECT name, owner FROM pet ORDER BY name desc, owner desc; 




SELECT name, birth 
FROM pet 
ORDER BY birth desc; 

SELECT * FROM pet ORDER BY birth;

/* 내림차순 정렬을 해야 할 때에는 DESC */
SELECT name, birth FROM pet ORDER BY birth desc;


/*========== null ==============*/

select * from pet where death is not null;

select name from pet where death is null;




select name 
from pet 
where species is null;





/*
 패턴 매칭 
*/

-- like - b로 시작하는 이름 동물
select * from pet where name like 'b%';

select * from pet where name not like 'b%';

-- owner
select * from pet 
where owner like 'b%';

-- fy로 끝나는
SELECT * FROM pet WHERE name LIKE "%fy";
-- w 포함
SELECT * FROM pet WHERE name LIKE "%w%";
-- 날짜 패턴 매칭
SELECT * FROM pet WHERE birth LIKE "%7%";

# pattern character _ 를 사용해서 정확히 4문자 이름
SELECT * FROM pet WHERE name LIKE "____";
SELECT * FROM pet WHERE species LIKE "___";




/*
내장함수: 
    select [ function_name(parameter) ] ; <-- 컬럼 이름: 패턴...
*/
select count(*)  from pet;
select count(owner)  from pet;
select count(death)  from pet; 
select count(sex)  from pet; 




select count(owner),
		count(owner) as cnt
from pet;

select count(death) as cnt from pet;


-- Alias
select count(death) as cnt from pet;
select count(death) cnt from pet;

SELECT name '이름', birth as '생일' FROM pet;





/*
내장함수: 
    select [ function_name(parameter) ] ; <-- 컬럼 이름: 패턴...
*/
select count(*) 
from pet;

-- error!!!
select name, count(*) from pet;



-- 집계!
select name, count(*) from pet
group by name;


select count(owner),
	   count(owner) as '개수'
from pet;


select count(death) as '개수'
from pet;




/* 
pet table에 새 데이터를 입력 
*/




-- INSERT
INSERT INTO pet VALUES('멍멍이', '김씨', 'dog', 'm', '2001-01-23', NULL);

INSERT INTO pet(name, owner, species, sex)
		VALUES('멍멍이', '김씨', 'dog', 'm');






-- safe update mode 적용!
-- delete & update

-- delete
delete from pet where species='snake';





select @@sql_safe_updates;
set sql_safe_updates=0;
delete from pet where species='snake';

-- update
-- set sql_safe_updates=0; -- 적용된 상태!!!
select * from pet;
update pet set species='멍멍' where species = 'dog';

set sql_safe_updates=1;


-- schema 레벨 영역 지정.
select * from pet;
select * from lectures.pet;
select * from sakila.actor;


/* 드롭 */
drop table lectures.pet22222;
