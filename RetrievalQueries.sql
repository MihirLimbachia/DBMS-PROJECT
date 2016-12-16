set search_path to project;


/* 1 .	Retrieve all the players associated with the teams for the owner  James Y Adams */
select * from players 
where playerid in 
(select playerid from teamplayers 
where (teamname,ownerid) in
(select teamname,ownerid from team where ownerid in (select ownerid from owners where fname='James' and minit='Y'and lname='Adams')));


/* 2 .	Retrieve all Real Madrid players associated with the team with name Barce-loners  and their scores in individual matches*/
select name,score,matchid from playermatchscore 
natural join 
(select playerid,name from players 
where playerid in
(select playerid from teamplayers where teamname='Barce-loners') and uefateamname='Real Madrid')as R;

/* 3 .	Retrieve the highest performing player for each match with his score */

select * from players
natural join
(select playerid,PS.matchid,score from playermatchscore PS
join  
(select matchid,max(score)as MaxScore from playermatchscore group by matchid) as R on( R.MaxScore=PS.score and PS.matchid=R.matchid))as R2;

/* 4 .	Retrieve league winner team for each league with their scores in the league*/

select R2.* from (select teamname,leaguename,leaguecommissionerid,ownerid,sum(score) as LeagueScore from teamleaguematchperfomance group by teamname,leaguename,leaguecommissionerid,ownerid) as R2
join 
(select leaguename,leaguecommissionerid,max(leaguescore)as MaxLeagueScore from(
select teamname,leaguename,leaguecommissionerid,ownerid,sum(score) as LeagueScore from teamleaguematchperfomance group by teamname,leaguename,leaguecommissionerid,ownerid) as R group by leaguename,leaguecommissionerid) as R3 on (R3.MaxLeagueScore=R2.LeagueScore and R2.leaguename=R3.leaguename and R2.leaguecommissionerid=R3.leaguecommissionerid); 

/* 5 .	Retrieve owner who has won max no of leagues */

select * from owners where ownerid 
in
(select ownerid from (
select ownerid,count((leaguename,leaguecommissionerid)) as no_of_leagues_won from (
select R2.* from (select teamname,leaguename,leaguecommissionerid,ownerid,sum(score) as LeagueScore from teamleaguematchperfomance group by teamname,leaguename,leaguecommissionerid,ownerid) as R2
join 
(select leaguename,leaguecommissionerid,max(leaguescore)as MaxLeagueScore from(
select teamname,leaguename,leaguecommissionerid,ownerid,sum(score) as LeagueScore from teamleaguematchperfomance group by teamname,leaguename,leaguecommissionerid,ownerid) as R group by leaguename,leaguecommissionerid) as R3 
on (R3.MaxLeagueScore=R2.LeagueScore and R2.leaguename=R3.leaguename and R2.leaguecommissionerid=R3.leaguecommissionerid)) as R4 group by ownerid)as R6

join 
(select max(no_of_leagues_won)as Max_no_of_leagues from (
select ownerid,count((leaguename,leaguecommissionerid)) as no_of_leagues_won from (
select R2.* from (select teamname,leaguename,leaguecommissionerid,ownerid,sum(score) as LeagueScore from teamleaguematchperfomance group by teamname,leaguename,leaguecommissionerid,ownerid) as R2
join 
(select leaguename,leaguecommissionerid,max(leaguescore)as MaxLeagueScore from(
select teamname,leaguename,leaguecommissionerid,ownerid,sum(score) as LeagueScore from teamleaguematchperfomance group by teamname,leaguename,leaguecommissionerid,ownerid) as R group by leaguename,leaguecommissionerid) as R3 
on (R3.MaxLeagueScore=R2.LeagueScore and R2.leaguename=R3.leaguename and R2.leaguecommissionerid=R3.leaguecommissionerid)) as R4 group by ownerid) as R5)as R7 on R6.no_of_leagues_won=R7.Max_no_of_leagues); 

/* 6 .	Retrieve the highest perfoming player of all time */
select * from players 
natural join(
select playerid from (select playerid,sum(score)as all_time_score from playermatchscore group by playerid)as R2 
where R2.all_time_score in
(select max(all_time_score)as Max_all_time_score from (
select playerid,sum(score)as all_time_score from playermatchscore group by playerid)as R))as R4;

/* 7 .	Retrieve the teams which have the player who has scored maximum no of goals in at least two matches */
select teamname,ownerid from(
select teamname,ownerid, count(distinct matchid)as no_of_matches from (select * from teamplayers R4 where R4.playerid
in  
(select playerid from players
natural join(
select playerid from (
select playerid,sum(goals)as no_of_goals from playermatchperformance group by playerid)as R2
where R2.no_of_goals  
in (select max(no_of_goals) as max_no_of_goals from (
select playerid,sum(goals)as no_of_goals from playermatchperformance group by playerid)as R))as R3))as R4 group by teamname,ownerid)as R4 where no_of_matches>1;

/* 8 .	Retrieve the highest scoring team which has the player who is the most persistent of all time (highest average score) for each league*/

select * from (
select teamname,ownerid,leaguename,leaguecommissionerid,sum(score) as Total_Score from (
select TP.* from teamleaguematchperfomance TP
natural join 
(select * from teamplayers where playerid
in
(select playerid from (select playerid,avg(score) as Avg_score from playermatchscore group by playerid) as R2
where playerid in ( 
select max(Avg_score) as Max_avg_score from (
select playerid,avg(score) as Avg_score from playermatchscore group by playerid)as R)))as R3)as R4 group by teamname,ownerid,leaguename,leaguecommissionerid) as RR


where (RR.leaguename,leaguecommissionerid,total_score)

in

(select leaguename,leaguecommissionerid,max(total_score)
from (
select teamname,ownerid,leaguename,leaguecommissionerid,sum(score) as Total_score from (
select TP.* from teamleaguematchperfomance TP
natural join 
(select * from teamplayers where playerid
in
(select playerid from (select playerid,avg(score) as Avg_score from playermatchscore group by playerid) as R2
where playerid in ( 
select max(Avg_score) as Max_avg_score from (
select playerid,avg(score) as Avg_score from playermatchscore group by playerid)as R)))as R3)as R4 group by teamname,ownerid,leaguename,leaguecommissionerid )as R5 group by leaguename,leaguecommissionerid) ;


/* 9 .	Retrieve the teams that have not won any league  */
select * from team T
where
(T.teamname,T.ownerid)
not in 
(select R2.teamname,R2.ownerid from (select teamname,leaguename,leaguecommissionerid,ownerid,sum(score) as LeagueScore from teamleaguematchperfomance group by teamname,leaguename,leaguecommissionerid,ownerid) as R2
join 
(select leaguename,leaguecommissionerid,max(leaguescore)as MaxLeagueScore from(
select teamname,leaguename,leaguecommissionerid,ownerid,sum(score) as LeagueScore from teamleaguematchperfomance group by teamname,leaguename,leaguecommissionerid,ownerid) as R group by leaguename,leaguecommissionerid) as R3 on (R3.MaxLeagueScore=R2.LeagueScore and R2.leaguename=R3.leaguename and R2.leaguecommissionerid=R3.leaguecommissionerid));
  

/* 10 .	Retrieve teams that are Real Madrid dominant who have higher than average perfomance each match in a league name Ballers */

select R1.* from (
select * from teamleaguematchperfomance TLP
where (TLP.teamname,TLP.ownerid,TLP.matchid)
in 
(select teamname,ownerid,matchid from(
select matchid,uefateamname,teamname,ownerid,count(playerid)as NoOfPlayers from(
select	* from teamplayers natural join players) as R group by matchid,uefateamname,teamname,ownerid)as R1 where noofplayers>=6))as R1

natural join 
(select matchid,leaguename,leaguecommissionerid,avg(score) as AVGscore from teamleaguematchperfomance TLP group by matchid,leaguename,leaguecommissionerid)as R2 where R1.score > R2.avgscore;

/* 11 . Retrive the teams having players having higher than average perfomance in all of their played matches */

select playerid from playermatchscore PMS
where 
PMS.playerid
not in
(select playerid from playermatchscore PS
join 
(select matchid,avg(score)as AverageScore from playermatchscore group by matchid) as R on (R.matchid=PS.matchid and PS.score < R.averagescore)); 


/* 12 . Retrieve the player and the uefa teamname of the player having max score in each match */

select matchid,name,uefateamname from 
(select playerid,matchid from playermatchscore PMS 
where 
(PMS.matchid,PMS.score)
in
(select matchid,max(score) from playermatchscore PS group by matchid)) as R1 natural join players;

/* 13 . Retrieve ownernames who have the player who has the maximum individual match score in any league */
select (fname||' '||minit||' '||lname)as Names
from
(select distinct ownerid from teamplayers
where playerid
in
(select playerid from 
(select playerid,max(score)as SCORE from playermatchscore group by playerid) as R1
where 
R1.SCORE
>=all
(select SCORE
from
(select playerid,max(score)as SCORE from playermatchscore group by playerid)as R2)))as R3 natural join owners;

/* 14 .	Retrieve names of the top 3 players with average goals/shots percentage higher than 35 in the real uefa league and high average score*/

select * from
(select * from
(select playerid,avg(shotsongoalratio) as avgGS,avg(score) as avgScore from
(select * from
(select playerid,matchid, (goals*100)/shots as ShotsOnGoalratio from playermatchperformance where shots>0)as R1
natural join
(select * from playermatchscore)as R2) as R3 group by playerid)as R4 where avgGS>35)as R4 order by avgscore desc ;

/* 15 .	Retrieve the winning teams(highest average score) from Dallas in each league with their owner name and email*/

select ownerid,(fname||' '||minit||' '||lname)as Owner_name,email as Owner_email,teamname,leaguename,leaguecommissionerid from 

(select * from 
((select * from
(select teamname,ownerid,leaguename,leaguecommissionerid,avg(score) as League_Perfomance from
(select * from
(select * from participations
natural join
(select * from team where location='Dallas')as R1)as R2
natural join 
(select * from teamleaguematchperfomance)as R3) as R4 group by teamname,ownerid,leaguename,leaguecommissionerid)as R5 order by leaguename,leaguecommissionerid)) as R8
except

(select R6.* from
(select * from
(select teamname,ownerid,leaguename,leaguecommissionerid,avg(score) as League_Perfomance from
(select * from
(select * from participations
natural join
(select * from team where location='Dallas')as R1)as R2
natural join 
(select * from teamleaguematchperfomance)as R3) as R4 group by teamname,ownerid,leaguename,leaguecommissionerid)as R5 order by leaguename,leaguecommissionerid)
as R6
join
(select * from
(select teamname,ownerid,leaguename,leaguecommissionerid,avg(score) as League_Perfomance from
(select * from
(select * from participations
natural join
(select * from team where location='Dallas')as R1)as R2
natural join 
(select * from teamleaguematchperfomance)as R3) as R4 group by teamname,ownerid,leaguename,leaguecommissionerid)as R5 order by leaguename,leaguecommissionerid)
as R7
 on (R6.leaguename=R7.leaguename and R6.leaguecommissionerid=R7.leaguecommissionerid and R6.league_perfomance<R7.league_perfomance)))as R9
natural join
owners;

/* 16 .	Retrieve the top 4 teams with highest gaps(difference between the player with maximum score and minimum score selected for the team) for the owner teams with the matchid with their ownernames*/

select matchid,uefateamname,(max(score)-min(score))as Team_Perfomance_Gap from playermatchscore natural join players group by matchid,uefateamname;

select * from
(select teamname,matchid,ownerid,(max(score)-min(score))as Team_Perfomance_Gap from
(select * from team natural join players natural join playermatchscore) as R1 group by teamname,matchid,ownerid)as R2 order by team_perfomance_gap limit 4;

/* 17 .	Retrieve the uefateams that scored more than 75 percent of goals of their opponent and lost */

select R1.uefateamname,R1.matchid from 
(select uefateamname,matchid,sum(goals)as no_of_goals from playermatchperformance natural join players group by uefateamname,matchid)
as R1
join
(select uefateamname,matchid,sum(goals)as no_of_goals from playermatchperformance natural join players group by uefateamname,matchid) as R2 on(R1.matchid=R2.matchid and R1.no_of_goals<R2.no_of_goals and R1.no_of_goals > 0.75*R2.no_of_goals);

/* 18 . Retrieve the ownernames and their email that have more than two leaguewins not necessarily in the same league */

select (fname||' '||minit||' '||lname)as Owner_name,email as Owner_email from 
(select ownerid from
(select ownerid,count((leaguename,leaguecommissionerid))as League_Wins from
(select R2.* from
(select leaguename,leaguecommissionerid,teamname,ownerid,avg(score)as Team_average_League_perfomance from teamleaguematchperfomance 
group by leaguename,leaguecommissionerid,teamname,ownerid) as R2
join
(select leaguename,leaguecommissionerid,max(team_average_league_perfomance) as League_maximum from 
(select leaguename,leaguecommissionerid,teamname,ownerid,avg(score)as Team_average_League_perfomance from teamleaguematchperfomance 
group by leaguename,leaguecommissionerid,teamname,ownerid) as R1
 group by leaguename,leaguecommissionerid) as R3 on (R2.Team_average_League_perfomance=R3.league_maximum)) as R4 group by ownerid) as R5 where League_wins>1) as R6
natural join
owners;

/* 19 .	Retrieve the top 3 uefateamplayer names with their average league score in the winning uefa team and the teamname*/
select name,uefateamname from
(select playerid from
(select playerid,avg(score) as avg_score from
(select * from playermatchscore natural join players

natural join

(select teamname as uefateamname from

(select teamname,count(matchid)as no_of_wins from
(select * from matchuefateams
except
select R1.matchid,R1.uefateamname from 
(select uefateamname,matchid,sum(goals)as no_of_goals from playermatchperformance natural join players group by uefateamname,matchid)
as R1
join
(select uefateamname,matchid,sum(goals)as no_of_goals from playermatchperformance natural join players 
group by uefateamname,matchid) as R2 on(R1.matchid=R2.matchid and R1.no_of_goals<R2.no_of_goals))as R1 group by teamname)as Rf1

join

(select max(no_of_wins)as Max_no_of_wins from
(select teamname,count(matchid)as no_of_wins from
(select * from matchuefateams
except
select R1.matchid,R1.uefateamname from 
(select uefateamname,matchid,sum(goals)as no_of_goals from playermatchperformance natural join players group by uefateamname,matchid)
as R1
join
(select uefateamname,matchid,sum(goals)as no_of_goals from playermatchperformance natural join players 
group by uefateamname,matchid) as R2 on(R1.matchid=R2.matchid and R1.no_of_goals<R2.no_of_goals))as R3 
group by teamname) as R4)as Rf2

on (Rf1.no_of_wins=Rf2.MAx_no_of_wins)) as Rf) as Rff group by playerid) as Rfff order by avg_score desc limit 3) as R natural join players
;


/* 20 . Retrieve the owner email of owners that have player with maximum no of goals in any of his team during any match */
select email as owner_email from owners
natural join

(select distinct ownerid from teamplayers
natural join
(select playerid from

(select playerid,avg(steals)as Avg_steals from playermatchperformance group by playerid) as R1
 
join

(select max(Avg_steals)as max_steals from
(select playerid,avg(steals)as Avg_steals from playermatchperformance group by playerid)as R1) as R2
on (R1.avg_steals=R2.max_steals))as Rin) as Rinin;
 	 