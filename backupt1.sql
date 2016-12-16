set search_path to project;
select  ownerid,teamname,matchid,count(playerid)as no_of_players from teamplayers group by ownerid,teamname,matchid;

declare
no_of integer;
begin 
select no_of_players from (select ownerid,teamname,matchid,count(playerid)as no_of_players from teamplayers group by ownerid,teamname,matchid) as R where R.matchid=NEW.matchid and R.ownerid=NEW.ownerid and R.teamname=NEW.teamname;
if no_of_players>10 then 
raise exception 'Team already has 11 players' ;
end if;
return new;
end;