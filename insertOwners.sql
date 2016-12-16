set search_path to project;

alter table owners 
alter column email type varchar(50);

alter table owners 
alter column fname type varchar(50);

alter table owners 
alter column lname type varchar(50);

insert into owners (ownerid,fname,minit,lname,email)
values (1,'Harold','D','Hunt','harokldhunt@gmail.com');

insert into owners (ownerid,fname,minit,lname,email)
values (2,'James','Y','Adams','jamesadams597@gmail.com');

insert into owners (ownerid,fname,minit,lname,email)
values (3,'Clark','W','Winston','ClarkWinston4392@gmail.com');

insert into owners (ownerid,fname,minit,lname,email)
values (4,'Geroge','H','Reynolds','GeorgeReynolds3267@gmail.com');

insert into owners (ownerid,fname,minit,lname,email)
values (5,'Harry','U','Kawasaki','harryKawasaki45@gmail.com');

insert into owners (ownerid,fname,minit,lname,email)
values (6,'Todd','Q','Ryan','ToddRyanoneandonly@hotmail.com');

insert into owners (ownerid,fname,minit,lname,email)
values (7,'Kevin','I','Smith','KevinSmith@gmail.com');

insert into owners (ownerid,fname,minit,lname,email)
values (8,'Akihiko','O','Daihatsu','Akihiko@gmail.com');


insert into owners (ownerid,fname,minit,lname,email)
values (9,'Dinesh','T','Patel','DinPatel1235@gmail.com');

insert into owners (ownerid,fname,minit,lname,email)
values (10,'Jake','Y','Gasai','JakeGasai1412@gmail.com');

insert into owners (ownerid,fname,minit,lname,email)
values (11,'Raj','T','Kuthrapalli','Rajkuthrapalli@yahoo.com');


insert into owners (ownerid,fname,minit,lname,email)
values (12,'Tyler','U','Hexal','TylerHexal@gmail.com');

insert into owners (ownerid,fname,minit,lname,email)
values (13,'Karan','R','Miller','KaranMiller23@gmail.com');

insert into owners (ownerid,fname,minit,lname,email)
values (14,'Irina','A','Olson','IrinaOlson25@gmail.com');

insert into owners (ownerid,fname,minit,lname,email)
values (15,'Ariana','W','Mortez','ArianaMortez12@reddit.com');

