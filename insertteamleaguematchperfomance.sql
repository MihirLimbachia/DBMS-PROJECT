set search_path to project;

alter table teamleaguematchperfomance
alter column teamname type varchar(50);

alter table teamleaguematchperfomance
alter column leaguename type varchar(50);

alter table teamleaguematchperfomance
alter column score type numeric;

insert into teamleaguematchperfomance (matchid,teamname,ownerid,leaguename,leaguecommissionerid,score)
select matchid,teamname,ownerid,leaguename,leaguecommissionerid,sum(score)as perfomance from (select * from (select * from (select * from participations natural join leaguematches) as R natural join teamplayers)as R2 natural join playermatchscore)as  R3 group by R3.matchid,R3.teamname,R3.ownerid,R3.leaguename,R3.leaguecommissionerid;
