select version(), current_date;

select "홍길동";
select '홍길동';
select "홍길동"             
+ " 서울시 ";

select 100 + 100;
select 100 + 10.1;  # casting
select 100 + '10.1';

# 사칙연산자: + - * / 
select 100 / '10.1';
select '50' * '10.1';


# 한 줄 주석 comments
# 주석 
-- 주석

# select '50' * '10.1';

/*
   여러줄 주석
   여러줄에 걸쳐서 주석을 처리
   
   select '50' * '10.1';
*/

# 날짜 
select current_date;
-- 2022-09-22 -> 09/22/2022 

select '2022-09-22'; # YYYY-MM-dd

# Boolean : 참/거짓. 1 / 0. True / False.
select 100 > 200;
select 100 < 200;
select True, False;

# 대소 <, > , 동일 =
select true = 1;
select true = 0;
select false = 0;

# 수학계산용 내장함수: min, max, sum, sin...
select sin(pi()/4);


select
	user()
    ,
        current_date
    ;

select @@general_log;

# show statement
show databases;
show schemas;















