CREATE DATABASE trigger_demo;
USE trigger_demo;

CREATE TABLE users (
	Username VARCHAR(100),
    Age INT
);

INSERT INTO users (username, age) VALUES ('bobby',23);

SELECT * from users;

DELIMITER $$
CREATE TRIGGER must_be_adult
	BEFORE INSERT ON users FOR EACH ROW
    BEGIN
		IF NEW.age < 18
        THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Must be an adult';
		END IF;
	END
$$
DELIMITER ;

INSERT INTO users (username, age) VALUES ('brown',15);

use ig_clone;
DELIMITER $$
CREATE TRIGGER prevent_self_follows
	BEFORE INSERT ON followers FOR EACH ROW
    BEGIN
		IF NEW.followerid = NEW.followeeid
        THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "Can't follow yourself";
		END IF;
    END
$$
DELIMITER ;

INSERT INTO followers (followerid, followeeid) VALUES(5,5);
