


-- Creating a simple database for book information

CREATE DATABASE books;

USE Books;

-- Table that holds all the info needed for books, from price to average star rating
-- Certain data can not be Null.
-- Primary Key is tied to the unique value of the BookID.
CREATE TABLE BookInfo(

BookID int NOT NULL,
Category VARCHAR(50) NOT NULL,
BookPrice FLOAT NOT NULL,
Books_Available int NOT NULL,
Book_Description VARCHAR(300),
Average_Star int,
PRIMARY KEY(BookID)

)


