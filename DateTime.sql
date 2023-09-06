CREATE TABLE people (
	name VARCHAR(100),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME
);
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00'),
	   ('Lulu', '1985-04-11', '9:45:10', '1985-04-11 9:45:10'),
       ('Juan', '2020-08-15', '23:59:00', '2020-08-15 23:59:00');

SELECT * FROM people;

-- SELECT now();

INSERT INTO people
VALUES ('Hazel', CURDATE(), CURTIME(), NOW());

SELECT * FROM people;

SELECT name,
	DAYNAME(birthdate) AS DayOfBirth,
	MONTHNAME(birthdate) AS MonthOfBirth,
	DAY(birthdt) Day, 
    YEAR(birthdt) AS Year,
	TIME(birthdt) AS Time
FROM people;

SELECT CONCAT_WS(' ', name, 'was born on', CONCAT(DAY(birthdt),'th'), MONTHNAME(birthdt), YEAR(birthdt)) AS People
FROM people;  -- There is a more convinient way though

SELECT CONCAT(name, ' was born on the ', DATE_FORMAT(birthdt, '%D of %b %Y')) AS 'Juan\'s data'
FROM people
WHERE name = 'Juan';

SELECT DATE_FORMAT(birthtime, '%H %i') FROM people;  -- 'date_format' can work with a time column too

SELECT DATEDIFF(CURDATE(), birthdate) FROM people;  -- TIMEDIFF() also returns difference between times

SELECT DATE_ADD(CURDATE(), INTERVAL 1 YEAR);

SELECT DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

SELECT DATE_SUB(CURDATE(), INTERVAL '1 1' HOUR_SECOND);

SELECT name, DATE_ADD(birthdate, INTERVAL 18 YEAR) AS 'Eligible to vote from'
FROM people;

-- You can easily use operators too
SELECT name, YEAR(birthdate + INTERVAL 21 YEAR) AS 'Will be 21' FROM people;

SELECT birthtime - INTERVAL 1 HOUR FROM people;

SELECT TIMEDIFF(CURTIME(), '06:30:00');

CREATE TABLE Captions(
	text VARCHAR(150) NOT NULL,
	Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Last_updated TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO captions (text)
VALUES ('Hello People oon the media'),
	   ('Good morning my neighbor'),
       ('How are we doing today'),
       ('It\'s a beautiful life');

SELECT * FROM captions;

UPDATE captions
SET text = 'I\'m living my best life'
WHERE text LIKE '%life'; 

SELECT * FROM captions;

UPDATE captions
SET text = 'How are you doing this evening'
WHERE text LIKE '%How are%';

INSERT INTO captions (text)
VALUES ('The last of the piece');

SELECT CURTIME();
SELECT CURDATE();

SELECT DAYOFWEEK(CURDATE());

SELECT DAYNAME(CURDATE());

SELECT CURRENT_TIMESTAMP();
SELECT NOW();

SELECT CONCAT(DATE_FORMAT(NOW(), '%m/%d/%Y'), ' ', CURTIME()); -- Probably an overkill

SELECT DATE_FORMAT(CURRENT_TIMESTAMP(), '%M %D at %k:%i');

DROP TABLE tweets;

CREATE TABLE tweets(
		tweet VARCHAR(180) NOT NULL,
        Username VARCHAR(15) NOT NULL,
        Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO tweets(tweet, username)
VALUES ('Look at me now', 'Tboy'),
	   ('Im the guy', 'Abaga'),
       ('leemaooo', 'Classy'),
       ('Chelsea for life', 'Tobe');
       
SELECT * FROM tweets;

UPDATE tweets
SET tweet = 'lmfaooo'
WHERE username = 'classy';

SELECT * from people 
where hour(birthdt) BETWEEN 12 and 23;

SELECT * from people
where birthtime BETWEEN cast('12:00' as time) and cast('23:00'as time);

SELECT * from people;

SELECT * FROM people
where year(birthdate) BETWEEN 2010 and 2023;

SELECT * from people
where date_format(birthdate, '%y') BETWEEN 10 and 23;