use cdac;
select * from demo;

/*  select _ _ _ _ _ _ _ _ _ _ _ _ 
display the 5th largerst amount of sal  
output==>6000  
*/
select min(sal) as fifth from (select distinct sal from demo order by sal desc limit 5) as tempp ;

/*
select  - - - -
display the largest and second largest as follow

first   ||  Second
=======================
10000   ||  9000
*/
select max(sal)as first,min(sal) as second  from (select distinct sal from demo order by sal desc limit 2) as tempp ;


