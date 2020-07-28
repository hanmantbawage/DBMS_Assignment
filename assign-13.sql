/* Assignment – 13
Using the UNION clause.
1) Create a union of two queries that shows the names, cities, 
and ratings of all customers. Those with rating of 200 or greater 
will also have the words “High Rating”, while the others will have the words “Low Rating”.*/
use cdac_assignment;
/* distinguish without union */
select cname, city, rating,case 
when rating>=200 then 'High Rating'
else'Low Rating' end as status
from customers ;

/* using union */
select cname, city, 'High Rating' rating from customers where  rating >=200 union
select cname, city, 'Low Rating' rating from customers where  rating <200;
/*2) Write a command that produces the name and number of each salesperson and each
 customer with more than one current order. Put the results in alphabetical order.*/
select cnum as name ,cname as number from customers group by cname union
select snum,sname from salespeople group by sname;

/*3) Form a union of three queries.
 Have the first select the snums of all salespeople in San Jose;
 the second, the cnums of all customers in San Jose; and the third the onums of all orders on October 
 3. Retain duplicates between the last two queries but eliminate any redundancies between either of them and the first.
(Note: in the sample tables as given, there would be no such redundancy. This is besides the point.)*/
select snum from salespeople where city='san jose'
union
select distinct cnum from customers where cnum IN (select cnum from orders where odate='1990-10-03');