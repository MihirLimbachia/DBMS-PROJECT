set search_path to project;
/*
alter table playermatchperformance
add column score integer;
*/

create table playermatchscore(
	playerid integer ,
	matchid  integer,
	score decimal,
	foreign key (playerid,matchid) references playermatchperformance(playerid,matchid) 
);
 
insert into playermatchscore (playerid,matchid,score)
select  playerid,matchid,((saves*2) -overtimelosses -goalsallowed + (2.5*goalssaved) - blockedshots + (1.5*goals) + shots + (1.5*penaltykickattemptsdefended) - penaltykickgoalsdefended + (0.75*steals) + (3*gamewinninggoals) )as scorequery from playermatchperformance;

