## RDS�ڑ�
mysql -h xxx -u udemy -p

## �f�[�^�쐬
create database testdb;

use testdb;

create table testdb.account(id int, name varchar(20));

show testdb;

insert into account values (1001, "hiroyuki");

insert into account values (1002, "shingo");

insert into account values (1003, "naoko");


select * from account;