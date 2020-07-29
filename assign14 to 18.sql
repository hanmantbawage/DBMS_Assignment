show databases;
use cdac_assignment;
show tables;

/*========================Assignment – 14================================*/
			/*Entering, Deleting, and Changing Field Values.*/

/*1) Write a command that puts the following values, in their 
given order, into the salespeople table: city – San Jose, 
name – Blanco, comm – NULL, cnum – 1100.*/
insert into salespeople values(1100,'Blanco','San Jose',null);


/*2) Write a command that removes all orders from customer Clemens from the Orders table.*/
delete from orders where cnum=all(
select cnum from customers where cname='Clemens');
/*
3) Write a command that increases the rating of all customers in Rome by 100.*/
update customers set rating=rating+100 where city='rome';
/*
4) Salesperson Serres has left the company. Assign her customers to Motika.*/

update customers set
 snum=(select snum from salespeople where sname='motika')
 where sname=(select snum from salespeople where sname='serres');
 
 
/* Assignment – 15
Using Subqueries with DML Commands.
1) Assume there is a table called Multicust,
 with all of the same column definitions as Salespeople.
 Write a command that inserts all salespeople with more than one customer into this table.*/
create table multicast as select * from customers where snum IN(select snum from customers group by snum having count(snum)>1);

 /*2)Write a command that deletes all customers with no current orders.*/
select * from salespeople;
delete  from customers where cnum=any(select cnum from orders where year(odate)!=year(now) );
/*3)Write  a  command  that  increases  by  twenty  percent  the  commissions  of  all salespeople with total orders above Rs. 3,000.*/
select comm*1.20  from salespeople where snum=any(select snum from orders where amt>3000 );


-- Assignment –16
-- Creating Tables and Indexes.
/*1)Write a command that will enable a user to pull orders grouped by date out of the Orders table quickly.*/
create index in_odate on orders(odate);
show indexes from orders;

/*2)If the Orders table has already been created, how can you force the onum field to be unique (assume all current values are unique)?*/
alter table orders  add unique(onum);

insert into orders (onum) values (3001);-- error

/*3)Create  an  index  that  would  permit  each  salesperson  to  retrieve  his  or  her  orders grouped by date quickly*/
create index in_odate on orders(odate);

/*4) Let us assume that each salesperson is to have only one customer of a given rating, and that this is currently the case.
 Enter a command that enforces it.*/

create unique index i_rating on customers(rating);






-- Assignment – 17
-- Constraining the Values of your data.
/*
1) Create the Orders table so that all onum values as well as all combinations of
cnum and snum are different from one another, and so that NULL values are excluded 
from the date field.
*/
create database r;
use r;
create table orders (onum int(2), amt float(7,2) ,odate date not null, cnum int(2),snum int(2),primary key(onum,cnum,snum));


/*2) Create the Salespeople table so that the default commission is 10% with no NULLS permitted, 
snum is the primary key, and all names fall alphabetically between A and M, 
inclusive (assume all names will be uppercase).*/

create table salespeople(snum int primary key,sname varchar(25) check(sname = upper(sname) between 'A' and 'N'),city varchar(10),comm float(3,2)default 0.10);

/*3) Create the Orders table, making sure that the onum is greater than the cnum,
 and the cnum is greater that the snum. Allow no NULLS in any of these three fields.
 */
 
create table o1(
snum int(4) NOT NULL,
onum int(4) NOT NULL,
cnum int(4) NOT NULL,
check(onum>cnum and cnum>snum)
);



-- Assignment – 18
-- Maintaining the Integrity of your Data.
/*1) Create a table called Cityorders. This will contain the same onum,
 amt and snum fields as the Orders table, and the same cnum and city fields
 as the Customers table, so that each customer’s order will be entered into 
 this table along with his or her city. Onum will be the primary key of Cityorders.
 All of the fields in Cityorders will be constrained to match the Customers and 
 Orders tables. Assume the parent keys in these tables already have the proper constraints.*/
 CREATE TABLE cityorders
SELECT onum,
 amt,
 snum,
 cnum,       
city
FROM orders
NATURAL JOIN customers;

/*2) Redefine the Orders table as follows:- add a new column called prev, which will identify,
 for each order, the onum of the previous order for that current customer. 
 Implement this with a foreign key referring to the Orders table itself.
 The foreign key should refer as well to the cnum of the customer, 
 providing a definite enforced link between the current order and the one referenced.
 */
 
 alter table orders add prev varchar(10);
	
ALTER TABLE orders add 
foreign key(prev) REFERENCES orders(onum);
 
 
 
 
 
