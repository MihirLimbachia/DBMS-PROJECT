set search_path to project;

alter table league 
alter column leaguename type varchar(50);

insert into league (leaguename,commissionerid)
values ('Ballers',4);

insert into league (leaguename,commissionerid)
values ('RealFans',2);

insert into league (leaguename,commissionerid)
values ('UEFA ONLY',1);

insert into league (leaguename,commissionerid)
values ('NO SMALL TALK',9);

insert into league (leaguename,commissionerid)
values ('Knights in Valour',7);

insert into league (leaguename,commissionerid)
values ('Dark Ring',8);


insert into league (leaguename,commissionerid)
values ('WANT MON''YY',14);

insert into league (leaguename,commissionerid)
values ('KICKS AND GOALS',15);