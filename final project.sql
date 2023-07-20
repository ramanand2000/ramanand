create database library;
use library; 

create table branch( branch_no int primary key,
manager_id int,
branch_address varchar(100),
contact_no int);

insert into branch values
(10,1,'palakkad',123456),
(20,2,'kochi',976543219),
(30,3,'germany',976543200),
(40,4,'thrissur',93254319),
(50,5,'uk',97654980);
select * from branch;

create table employee(emp_id int primary key ,
emp_name varchar(30),
position varchar(100),
salary decimal (10,2));

insert into employee values
(1,'sanjeev','hr',140000),
(2,'fenim','finance analyst',60000),
(3,'arun','python developer',55000),
(4,'sarath','fullstack developer',50000),
(5,'sooraj','data analyst',60000);
select * from employee;

create table customer(customer_id int primary key,
customer_name varchar(30),
customer_address varchar(30),
reg_date date);

insert into customer values
(1,'richard','nelson street','2023-02-15'),
(2,'naveenth',' street road','2023-04-19'),
(3,'akhil','city centre','2023-04-10'),
(4,'rohit','central street','2023-09-12'),
(5,'kohil','city centre','2023-07-25');

select * from customer;

create table books(isbn varchar(100) primary key,
book_title varchar(100),
category varchar(30),
rental_price int,
status varchar(10),
author varchar(30),
publisher varchar(30));

insert into books values
('isbn1','Emma','novel',200,'yes','Jane Austen','Simon & Schuster'),
('isbn2','The Grapes of Wrath','Fiction',390,'yes','john Steinbeck','James Lloyd'),
('isbn3','David Copperfield','novel ',215,'yes','Charles Dickens','Bradbury & Evans'),
('isbn4','The Catcher in the Rye','fiction',643,'yes','J. D.Salinger','Little, Brown and Company'),
('isbn5','The Great Gatsby','Tragedy',109,'yes','F.Scott Fitzgerald','Charles Scribners Sons');

select * from books;

create table issuestatus(issue_id int primary key,
issued_cust int,
issued_book_name varchar(30),
issue_date date,
isbn_book varchar(100),
foreign key (issued_cust) references customer (customer_id),
foreign key (isbn_book) references books(isbn) );
 
 insert into issuestatus values
 (1,1,'Emma','2020-05-16','isbn1'),
 (2,2,'The Grapes of Wrath','2021-04-14','isbn2'),
 (3,3,'David Copperfield','2023-08-10','isbn3'),
 (4,4,'The Catcher in the Rye','2022-07-26','isbn4'),
 (5,5,'The Great Gatsby','2011-11-19','isbn5');
 
 select * from issuestatus;
 
 create table returnstatus(return_id int primary key,
 return_cust int,
 return_book_name varchar(100),
 return_date date,
 isbn_book2 varchar(100),
 foreign key (isbn_book2) references books (isbn));
 
insert into returnstatus values
(1,1,'Emma','2020-03-11','isbn1'),
 (2,2,'The Grapes of Wrath','2021-08-20','isbn2'),
 (3,3,'David Copperfield','2022-02-17','isbn3'),
 (4,4,'The Catcher in the Rye','2017-07-26','isbn4'),
 (5,5,'The Great Gatsby','2018-07-10','isbn5');
 
 select * from returnstatus;
 
 #Retrieve the book title, category, and rental price of all available books.
 select book_title,category,rental_price from books;
 
 #List the employee names and their respective salaries in descending order of salary
 select emp_name,salary from employee order by salary desc;
 
 # Retrieve the book titles and the corresponding customers who have issued those books
 select issuestatus.issued_book_name, customer.customer_name from issuestatus inner join
 customer on issuestatus.issued_cust = customer.customer_id;
 
 #Display the total count of books in each category.
 select  category ,count(*) as total_count_of_books from books group by category ;
 
#Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
select emp_name,position,salary from employee where salary >50000;

#List the customer names who registered before 2022-01-01 and have not issued any books yet.
select customer_name from customer where reg_date <'2022-01-01' and customer_id not in 
(select issued_cust from issuestatus);

#Display the branch numbers and the total count of employees in each branch
select branch_no,count(*) as total_count_of_employees from branch group by branch_no;

#Display the names of customers who have issued books in the month of June 2023.
select customer_name from customer where customer_id in (select issued_cust from issuestatus 
where issue_date ='2023-08-10');
#Retrieve book_title from book table containing history
select book_title from books where category ='fiction';
#. Retrieve the branch numbers along with the count of employees for branches having more than 5 employee
select branch.branch_no,count(*) as total_employees from branch
join employee on branch.manager_id = employee.emp_id group by branch.branch_no having count(*)>5;
