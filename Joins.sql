CREATE DATABASE store;

use store;

CREATE TABLE customers (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(50)
);

CREATE TABLE Orders (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE,
    Amount DECIMAL(8,2),
    CustomerID INT,
    FOREIGN KEY (customerID) REFERENCES customers(ID)
);

INSERT INTO customers (firstname, lastname, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
       
INSERT INTO orders (orderdate, amount, customerid)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
       
SELECT * from orders
limit 3;

insert INTO orders (orderdate, amount, customerid)
VALUES ( '2023-05-18', 120.55, 7);

insert INTO orders (orderdate, amount, customerid)
VALUES ( '2023-05-18', 120.55, 3),
	   ( '2023-05-23', 120.55, 5);
       
SELECT * from orders;

select firstname, lastname, sum(amount) as 'Total spending'
from customers INNER JOIN orders ON  -- Inner join is the default join, meaning that you can perform an inner join without writing the "INNER" 
customers.id = orders.customerid
GROUP BY firstname, lastname
ORDER BY sum(amount) DESC;

select firstname, lastname, orderdate, amount
from customers left JOIN orders ON 
customers.id = orders.customerid
where orderdate is null;

select firstname, lastname, ifnull(sum(amount), 0) as 'total amount spent'
from customers left JOIN orders ON 
customers.id = orders.customerid
GROUP BY firstname, lastname
ORDER BY sum(amount) DESC;

create TABLE students (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL 
);

create TABLE Papers (
	Title VARCHAR(50),
    Grade TINYINT,
    StudentID INT,
    CONSTRAINT student_key FOREIGN KEY(studentid)
    REFERENCES students(id)
);

INSERT INTO students (firstname) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');
 
INSERT INTO papers (studentid, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT* FROM students;
SELECT* FROM papers;

ALTER TABLE papers
Add COLUMN ID INT AUTO_INCREMENT PRIMARY KEY;

SELECT * FROM papers;

SELECT firstname, title, grade from students
inner join papers on students.id = papers.studentid
where firstname in ('caleb', 'samantha', 'carlos')
ORDER BY grade DESC;

SELECT firstname, title, grade from students
left join papers on students.id = papers.studentid;

SELECT firstname, ifnull(title, 'Missiing'), ifnull(grade, 0) from students
left join papers on students.id = papers.studentid;

SELECT firstname, ifnull(avg(grade), 0) as average,
	CASE
		when avg(grade) >= 50 THEN 'Passing'
        else 'Failing'
    end As PassingStatus
from students
left join papers on students.id = papers.studentid
GROUP BY firstname
ORDER BY average DESC;

Alter TABLE papers
modify title VARCHAR(50) not null;

DESC papers;

CREATE DATABASE TV_DB;
USE TV_DB;

CREATE TABLE Reviewers (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL
);

CREATE TABLE Series (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(225) NOT NULL,
    ReleasedYear YEAR, 
    Genre VARCHAR (50)
);

CREATE TABLE Reviews (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    Rating DECIMAL(3,1),
    SeriesID INT NOT NULL,
    ReviewerID INT NOT NULL,
    CONSTRAINT Series_Fkey FOREIGN KEY (SeriesID)
    REFERENCES Series(ID),
    CONSTRAINT Reviewers_Fkey FOREIGN KEY (ReviewerID)
    REFERENCES Reviewers(ID)
);

INSERT INTO series (title, releasedyear, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
 
 
INSERT INTO reviewers (firstname, lastname) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
 
INSERT INTO reviews(seriesid, reviewerid, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);
    
SELECT * from reviewers;
SELECT * from series;
SELECT * from reviews;

SELECT title, rating from series
INNER JOIN reviews ON series.ID = reviews.seriesID;

SELECT title, round(avg(rating), 1) as 'Average Rating' from series
INNER JOIN reviews ON series.ID = reviews.seriesID
GROUP BY title
ORDER BY avg(rating) DESC;

ALTER TABLE reviews
RENAME COLUMN reviewsid to ReviewID;

SELECT concat(firstname, ' ', lastname) as Reviewer, title as Series, rating from reviewers
join reviews on reviewers.id = reviews.reviewerid
join series on series.id = reviews.seriesid
ORDER BY series, rating DESC;

SELECT title as 'Unreviewed series' from series
left join reviews on series.id = reviews.seriesid
where rating is null;

SELECT genre, round(avg(rating), 2) as Avg_rating from series
join reviews on series.id = reviews.seriesid
GROUP BY genre
ORDER BY avg(rating) DESC;

select Firstname, lastname, count(rating) as count, 
ifnull(min(rating), 0) as min, ifnull(max(rating), 0) as max, ifnull(round(avg(rating), 2), 0) as average,
	-- case
		-- when count(rating) >= 1 THEN 'ACTIVE'
        -- else 'INACTIVE'
    -- end AS Status *in a case of one 'when' and then 'else' use below*
    If(count(rating) >=1, 'ACTIVE', 'INACTIVE') AS Status
from reviewers LEFT join
reviews on reviewers.id = reviews.reviewerid
GROUP BY firstname, lastname;

CREATE VIEW SeriesRateInfo AS
SELECT concat(firstname, ' ', lastname) as Reviewer, title as Series, rating, genre, ReleasedYear from reviewers
join reviews on reviewers.id = reviews.reviewerid
join series on series.id = reviews.seriesid
ORDER BY series, rating DESC;

SELECT * FROM seriesrateinfo
ORDER BY releasedyear DESC;

ALTER VIEW seriesrateinfo AS
SELECT concat(firstname, ' ', lastname) as Reviewer, title, rating, genre, ReleasedYear
from reviewers
join reviews on reviewers.id = reviews.reviewerid 
join series on series.id = reviews.seriesid;

SELECT * from seriesrateinfo;

SELECT genre, releasedyear, avg(rating) from seriesrateinfo
GROUP BY genre, releasedyear WITH ROLLUP;
