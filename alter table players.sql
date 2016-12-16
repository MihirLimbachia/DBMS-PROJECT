set search_path to project;

alter table players 
add foreign key (UEFATeamName)
references uefa_teams(teamname);