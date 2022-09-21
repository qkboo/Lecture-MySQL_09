
/*--------------------------------------------------------
 *                  교안3 - 02 DDL 명령 사용 (p9)
 * ------------------------------------------------------*/


-- create database: lecture
show databases;

show databases;
-- test schema
create database test;
create database if not exists test;


-- show create database
show create database test;
show create database lecture;


use test;

-- tables
show tables;
show tables from lectures;
show tables from bookstore;



/* 사용할 스키마 : lecture */
show tables;

-- booklibrary table
create table booklibrary33 (
	bookid int,
	bookname varchar(20),
	publisher varchar(50),
	price integer
);

-- table 조회
show tables;

-- desc
desc booklibrary;
desc test.booklibrary;


-- test table
show tables;
desc test;
desc test publisher;



-- DROP table
show tables;
drop table booklibrary;








/* 03. 제약 조건 */
use test;
-- primary key
create table booklibrary(
	bookid   	integer,
	bookname 	varchar(20),
	publisher 	varchar(20),
	price 		integer,
    primary key (bookid)
);

create table booklibrary2(
	bookid   	integer primary key,
	bookname 	varchar(20),
	publisher 	varchar(20),
	price 		integer
);
desc booklibrary;
desc booklibrary2;
desc booklibrary33;


create table booklibrary5(
	bookid   	integer,
	bookname 	varchar(20),
	publisher 	varchar(20) not null,
	price 		integer default 10000,
    primary key (bookid, bookname)
);
desc booklibrary5;


insert into booklibrary(bookid, bookname, publisher)
	values(100, '홍길동', '도서출판');
select * from booklibrary;

-- publisher가 not null 
insert into booklibrary5(bookid, bookname)
	values(100, '홍길동');
select * from booklibrary5;







/* 
04 alter  문
 */
show tables;


desc booklibrary;

alter table booklibrary add inventory varchar(30);
desc booklibrary;

alter table booklibrary modify inventory int;
alter table booklibrary add company varchar(30);

alter table booklibrary drop column inventory;
alter table booklibrary drop inventory;



-- primary key 추가 
desc booklibrary;
alter table booklibrary drop primary key;
alter table booklibrary add primary key(bookid);

