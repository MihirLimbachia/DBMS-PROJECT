(select teamname,wins from project.uefa_teams
left join
(select uefateamname,count(matchid)as wins from
(select R1.uefateamname,R1.matchid from 
(select uefateamname,matchid,sum(goals)as no_of_goals from project.playermatchperformance natural join project.players group by uefateamname,matchid)
as R1
join
(select uefateamname,matchid,sum(goals)as no_of_goals from project.playermatchperformance natural join project.players group by uefateamname,matchid) as R2 
on(R1.matchid=R2.matchid and R1.no_of_goals>R2.no_of_goals)) as R group by uefateamname)as R on teamname=R.uefateamname); 