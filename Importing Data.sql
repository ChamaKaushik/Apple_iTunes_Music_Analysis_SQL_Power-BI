# CREATING DATABASE

CREATE DATABASE Apple_iTunes ;
USE Apple_iTunes ;

# LOAD THE DATA

	 ## TABLE-1 EMPLOYEE

CREATE TABLE employee (
    employee_id INT PRIMARY KEY,               
    last_name VARCHAR(50) ,            
    first_name VARCHAR(50) ,            
    title VARCHAR(100),                         
    reports_to INT ,                       
    levels VARCHAR(5),                          
    birthdate VARCHAR(20) ,                             
    hire_date VARCHAR(20) ,                            
    address VARCHAR(100),                       
    city VARCHAR(50),                          
    state VARCHAR(50),                         
    country VARCHAR(50),                        
    postal_code VARCHAR(20),                    
    phone VARCHAR(30),                          
    fax VARCHAR(30),                            
    email VARCHAR(100)                    
) ;


insert into employee (employee_id, last_name, first_name, title, reports_to, levels, birthdate, hire_date, address, city, state, country, 
postal_code, phone, fax, email )
values(9, 'Madan', 'Mohan', 'Senior General Manager', NULL, 'L7',
'26-01-1961 00:00', '14-01-2016 00:00', '1008 Vrinda Ave MT', 'Edmonton', 
'AB', 'Canada', 'T5K 2N1', '+1 (780) 428-9482', '+1 (780) 428-3457',
'madan.mohan@chinookcorp.com') ;

UPDATE employee
SET birthdate = STR_TO_DATE(birthdate, '%d-%m-%Y %H:%i'),
    hire_date = STR_TO_DATE(hire_date, '%d-%m-%Y %H:%i');
    
ALTER TABLE employee 
MODIFY birthdate DATE,
MODIFY hire_date DATE;

SELECT * FROM employee;

      ## TABLE-2 CUSTOMER

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    company VARCHAR(100),
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(10),
    country VARCHAR(50),
    postal_code VARCHAR(20),
    phone VARCHAR(20),
    fax VARCHAR(20),
    email VARCHAR(100),
    support_rep_id INT,
    FOREIGN KEY (support_rep_id) REFERENCES employee(employee_id)
);

SELECT * FROM customer ;

      ## TABLE-3 ARTIST

CREATE TABLE artist (
    artist_id INT PRIMARY KEY,       
    name VARCHAR(120)       
);

SELECT * FROM artist ;

      ## TABLE-4 ALBUM

CREATE TABLE album (
    album_id INT PRIMARY KEY,
    title VARCHAR(100),
    artist_id INT,
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/album.csv'
INTO TABLE album
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM album ;

      ## TABLE- 5  GENRE

CREATE TABLE genre (
    genre_id INT PRIMARY KEY,
    name VARCHAR(50)
);

SELECT * FROM genre ;

      ## TABLE- 6 INVOICE 

CREATE TABLE invoice (
    invoice_id INT PRIMARY KEY ,
    customer_id INT ,
    invoice_date VARCHAR(20) ,
    billing_address VARCHAR(100),
    billing_city VARCHAR(70),
    billing_state VARCHAR(10),
    billing_country VARCHAR(50),
    billing_postal_code VARCHAR(30),
    total DOUBLE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

UPDATE invoice
SET invoice_date = STR_TO_DATE(invoice_date, '%Y-%m-%d %H:%i:%s') ;
    
ALTER TABLE invoice
MODIFY invoice_date DATE;

SELECT * FROM invoice ;

      ## TABLE- 7 MEDIA_TYPE 

CREATE TABLE media_type (
    media_type_id INT PRIMARY KEY,
    name VARCHAR(50)
);

SELECT * FROM media_type ;

      ## TABLE- 8 PLAYLIST 

CREATE TABLE playlist (
    playlist_id INT PRIMARY KEY,
    name VARCHAR(50)
);

SELECT * FROM playlist ;

      ## TABLE- 9 TRACK

CREATE TABLE track (track_id INT PRIMARY KEY,
name VARCHAR(400),
album_id INT,
media_type_id INT, 
genre_id INT,
composer VARCHAR(500),
milliseconds INT, 
bytes INT, 
unit_price DOUBLE,
FOREIGN KEY (album_id) REFERENCES album(album_id),
FOREIGN KEY (media_type_id) REFERENCES media_type(media_type_id),
FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
) ;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/track.csv'
INTO TABLE track
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM track ;

      ## TABLE- 10 PLAYLIST_TRACK

CREATE TABLE playlist_track (
playlist_id INT,
track_id INT, 
FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
FOREIGN KEY (track_id) REFERENCES track(track_id)
) ;

SELECT * FROM playlist_track ;

      ## TABLE- 11 INVOICE_LINE

CREATE TABLE invoice_line (
invoice_line_id INT PRIMARY KEY,
invoice_id INT,
track_id INT, 
unit_price DOUBLE,
quantity INT,
FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
FOREIGN KEY (track_id) REFERENCES track(track_id)
) ;

SELECT * FROM invoice_line ;