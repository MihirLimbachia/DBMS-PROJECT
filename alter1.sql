set search_path to project;
alter table playermatchperformance
alter column overtimelosses set default '0';
alter table playermatchperformance
alter column  goalssaved set default 0;
alter table playermatchperformance
alter column overtimelosses set default 0;
alter table playermatchperformance
alter column saves set default 0;
alter table playermatchperformance
alter column overtimewins set default 0;
alter table playermatchperformance
alter column goalsallowed set default 0;
alter table playermatchperformance
alter column blockedshots set default 0;
alter table playermatchperformance
alter column penaltykickattemptsdefended set default 0;
alter table playermatchperformance
alter column penaltykickgoalsdefended set default 0;
alter table playermatchperformance
alter column assists set default 0;
alter table playermatchperformance
alter column goals set default 0;
alter table playermatchperformance
alter column shotsongoal set default 0;
alter table playermatchperformance
alter column steals set default 0;
alter table playermatchperformance
alter column penaltykickattempts set default 0;
alter table playermatchperformance
alter column gamewinninggoals set default 0;
alter table playermatchperformance
alter column ejections set default 0;

