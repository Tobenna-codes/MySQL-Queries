SELECT author_lname, MAX(pages) AS NumberOfPages FROM books
GROUP BY author_lname
ORDER BY NumberOfPages DESC LIMIT 1;

SELECT CONCAT_WS(' ', author_fname, author_lname) AS Author, COUNT(title) AS Books
FROM books
GROUP BY Author
ORDER BY Books DESC;

SELECT author_fname, author_lname, title FROM books
ORDER BY author_fname;

SELECT  released_year, COUNT(*) AS Count FROM books
GROUP BY released_year
ORDER BY Count DESC, released_year;

SELECT title, author_fname, author_lname, released_year FROM books
WHERE released_year = (SELECT MIN(released_year) FROM books);

SELECT CONCAT_WS(' ', author_fname, author_lname) AS Author, MIN(released_year) AS 'First book'
FROM books
GROUP BY Author
ORDER BY 'first book';

SELECT author_fname, author_lname, released_year FROM books
ORDER BY author_fname, released_year;

SELECT CONCAT_WS(' ', author_fname, author_lname) AS Author, COUNT(title) AS Books,
MIN(released_year) AS 'Earliest book',
MAX(released_year) AS 'Latest book',
MAX(pages) AS 'Longest book in pages'
FROM books
GROUP BY Author
ORDER BY Books DESC;

SELECT book_id, title, pages FROM books
WHERE author_fname = 'neil'
ORDER BY released_year;

SELECT CONCAT_WS(' ', author_fname, author_lname) AS Author, 
COUNT(title) Books, 
AVG(pages) AS AveragePages 
FROM books
GROUP BY Author
ORDER BY Averagepages DESC;

SELECT released_year, SUM(stock_quantity) AS 'In stock' FROM books
GROUP BY released_year
ORDER BY released_year DESC;

SELECT SUM(stock_quantity) FROM books
WHERE released_year BETWEEN 2012 AND 2017;

SELECT title, author_fname, author_lname, released_year, stock_quantity FROM books
WHERE released_year BETWEEN 2012 AND 2017;

SELECT COUNT(title) FROM books;

SELECT released_year, COUNT(title)  FROM books
GROUP BY released_year
ORDER BY released_year DESC;

SELECT SUM(stock_quantity) FROM books;

SELECT CONCAT_WS(' ', author_fname, author_lname) AS Author, AVG(released_year)
FROM books
GROUP BY author;

SELECT CONCAT_WS(' ', author_fname, author_lname) AS Author, title, released_year, pages
FROM books
WHERE pages = (SELECT MAX(pages) FROM books);

SELECT released_year Year, COUNT(title) '# books', AVG(pages) 'avg pages'
FROM books
GROUP BY year
ORDER BY year;