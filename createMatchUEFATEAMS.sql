set search_path to project;

create table matchUEFATEAMS(
	matchid integer references match(matchid),
	teamname varchar(50) references uefa_teams(teamname),
	primary key (matchid,teamname)
);