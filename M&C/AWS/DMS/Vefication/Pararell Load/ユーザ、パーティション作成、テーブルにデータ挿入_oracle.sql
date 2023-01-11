sqlplus / as sysdba

sqlplus admin/welcome1_2_KKA@mis-prd-dwh-rds-1.c8jwt9nxu8we.ap-northeast-1.rds.amazonaws.com:1521/DWH

CREATE USER TEST IDENTIFIED BY TEST2022;

GRANT CONNECT, RESOURCE TO TEST;

GRANT UNLIMITED TABLESPACE TO TEST;

select username from dba_users;

sqlplus TEST/TEST2022

sqlplus TEST/TEST2022@mis-prd-dwh-rds-1.c8jwt9nxu8we.ap-northeast-1.rds.amazonaws.com:1521/DWH

delete from table1;

truncate table table1;

select count(*) from table1;

create table table1 (
 id    number ,  
 day date)
 PARTITION BY RANGE (day) 
 INTERVAL(NUMTOYMINTERVAL(1, 'MONTH'))
   ( PARTITION P_JAN VALUES LESS THAN (TO_DATE('2019-02-01', 'YYYY-MM-DD')),
     PARTITION P_FEB VALUES LESS THAN (TO_DATE('2019-03-01', 'YYYY-MM-DD')),
     PARTITION P_MAR VALUES LESS THAN (TO_DATE('2019-04-01', 'YYYY-MM-DD'))
   );

begin
for r in 1..1000000 loop
insert into table1
values(r,'19-02-17');
end loop;
end;
/

commit;

select * from user_segments;

INSERT INTO table1
SELECT * 
FROM   table1;

SELECT * FROM table1 PARTITION (P_JAN);
SELECT * FROM table1 PARTITION (P_FEB);
SELECT * FROM table1 PARTITION (P_MAR);

SELECT COUNT(*) FROM table1 PARTITION (P_JAN);
SELECT COUNT(*) FROM table1 PARTITION (P_FEB);
SELECT COUNT(*) FROM table1 PARTITION (P_MAR);

insert into table1 values (1, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (2, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (3, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (4, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (5, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (6, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (7, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (8, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (9, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (10, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (11, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (12, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (13, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (14, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (15, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (16, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (17, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (18, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (19, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (20, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (21, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (22, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (23, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (24, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (25, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (26, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (27, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (28, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (29, to_date('2019-02-01', 'YYYY-MM-DD')) ;
insert into table1 values (30, to_date('2019-02-01', 'YYYY-MM-DD')) ;