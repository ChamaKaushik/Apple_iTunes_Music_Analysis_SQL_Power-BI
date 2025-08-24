-- SQL QUERIES

-- Q1. Who is the senior most employee based on job title?

SELECT 
    first_name, last_name, title
FROM
    employee
ORDER BY levels DESC
LIMIT 1;

-- Q2. Which countries have the most Invoices?
SELECT 
    billing_country AS country,
    COUNT(invoice_id) AS total_invoices
FROM
    invoice
GROUP BY billing_country
ORDER BY total_invoices DESC;

-- Q3. What are top 3 values of total invoice?

SELECT 
    invoice_id, total
FROM
    invoice
ORDER BY total DESC
LIMIT 3;

-- Q4. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
--     Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.

SELECT 
    billing_city AS city,
    ROUND(SUM(total), 2) AS sum_of_invoice_total
FROM
    invoice
GROUP BY billing_city
ORDER BY sum_of_invoice_total DESC
LIMIT 1;




-- Q5. Who is the best customer? The customer who has spent the most money will be declared the best customer. 

ALTER TABLE customer
ADD full_name varchar(100) ;

UPDATE customer 
SET full_name = CONCAT(first_name, ' ', last_name) ;

SELECT * FROM customer;

SELECT 
    c.customer_id,
    c.full_name AS best_customer,
    ROUND(SUM(i.total), 2) AS money_spent
FROM
    customer c
        JOIN
    invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id , c.full_name
ORDER BY money_spent DESC;

-- Q6. Write a query to return the email, first name, last name, & Genre of all Rock Music listeners. 
--     Return your list ordered alphabetically by email starting with A. 

WITH rock_listeners AS (
    SELECT DISTINCT 
        c.email, 
        c.first_name, 
        c.last_name, 
        g.name AS genre_name  
    FROM track t
    JOIN invoice_line il 
        ON t.track_id = il.track_id
    JOIN invoice i 
        ON i.invoice_id = il.invoice_id
    JOIN customer c 
        ON c.customer_id = i.customer_id
    JOIN genre g 
        ON g.genre_id = t.genre_id
)
SELECT *
FROM rock_listeners 
WHERE genre_name = 'Rock'
ORDER BY email;

-- Q7. Let's invite the artists who have written the most rock music in our dataset. 
--     Write a query that returns the Artist name and total track count of the top 10 rock bands.

WITH artist_genre_tracks AS (
    SELECT 
        ar.artist_id, ar.name AS artist_name, 
        t.track_id, t.name AS track_name, 
        g.genre_id, g.name AS genre_name
    FROM artist ar
    JOIN album al 
        ON ar.artist_id = al.artist_id
    JOIN track t 
        ON al.album_id = t.album_id
    JOIN genre g 
        ON t.genre_id = g.genre_id
)
SELECT 
    artist_name, 
    COUNT(track_id) AS track_count
FROM artist_genre_tracks
WHERE genre_name = 'Rock'
GROUP BY artist_id, artist_name
ORDER BY track_count DESC
LIMIT 10;

-- Q8. Return all the track names that have a song length longer than the average song length. 
--     Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

SELECT 
    name, milliseconds
FROM track
WHERE milliseconds > (
    SELECT AVG(milliseconds) 
    FROM track
)
ORDER BY milliseconds DESC;

-- Q9. Find how much amount spent by each customer on artists. 
--     Write a query to return the customer name, artist name, and total spent.

WITH customer_artist_spending AS (
    SELECT 
        c.customer_id, 
        c.full_name AS customer_name, 
        ar.artist_id, 
        ar.name AS artist_name, 
        (il.unit_price * il.quantity) AS amount_spent
    FROM customer c
    JOIN invoice i 
        ON c.customer_id = i.customer_id
    JOIN invoice_line il 
        ON i.invoice_id = il.invoice_id
    JOIN track t 
        ON il.track_id = t.track_id
    JOIN album al 
        ON t.album_id = al.album_id
    JOIN artist ar 
        ON al.artist_id = ar.artist_id
)
SELECT 
    customer_name, 
    artist_name, 
    ROUND(SUM(amount_spent), 2) AS total_spent
FROM customer_artist_spending
GROUP BY customer_name, artist_name
ORDER BY total_spent DESC;

-- Q10. We want to find out the most popular music Genre for each country. 
--      We determine the most popular genre as the genre with the highest amount of purchases. 
--      Write a query that returns each country along with the top Genre. 
--      For countries where the maximum number of purchases is shared return all Genres.

WITH genre_purchases AS (
    SELECT 
        i.billing_country AS country, 
        g.name AS genre_name, 
        il.invoice_line_id
    FROM track t
    JOIN invoice_line il 
        ON t.track_id = il.track_id
    JOIN invoice i 
        ON i.invoice_id = il.invoice_id
    JOIN genre g 
        ON g.genre_id = t.genre_id
)
SELECT 
    country, 
    genre_name AS most_popular_music_genre, 
    purchases
FROM (
    SELECT 
        country, 
        genre_name, 
        COUNT(invoice_line_id) AS purchases,
        RANK() OVER (
            PARTITION BY country 
            ORDER BY COUNT(invoice_line_id) DESC
        ) AS rnk
    FROM genre_purchases 
    GROUP BY country, genre_name
) AS ranked
WHERE rnk = 1;

-- Q11. Write a query that determines the customer that has spent the most on music for each country. 
--      Write a query that returns the country along with the top customer and how much they spent. 
--      For countries where the top amount spent is shared, provide all customers who spent this amount.

SELECT 
    country, 
    customer_name, 
    ROUND(amount_spent, 2) AS amount_spent
FROM (
    SELECT 
        i.billing_country AS country, 
        c.full_name AS customer_name, 
        SUM(i.total) AS amount_spent,
        RANK() OVER (
            PARTITION BY i.billing_country 
            ORDER BY SUM(i.total) DESC
        ) AS rnk
    FROM invoice i
    JOIN customer c 
        ON i.customer_id = c.customer_id 
    GROUP BY i.billing_country, c.full_name
) AS ranked
WHERE rnk = 1;


-- Q12. Who are the most popular artists?

SELECT 
    ar.artist_id, 
    ar.name AS artist_name, 
    SUM(il.quantity) AS tracks_sold
FROM artist ar
JOIN album al 
    ON ar.artist_id = al.artist_id
JOIN track t 
    ON al.album_id = t.album_id
JOIN invoice_line il 
    ON t.track_id = il.track_id 
GROUP BY 
    ar.artist_id, 
    ar.name
ORDER BY 
    tracks_sold DESC
LIMIT 1;

-- Q13. Which is the most popular song?

SELECT 
    t.track_id, 
    t.name AS song_name, 
    SUM(il.quantity) AS units_sold
FROM track t
JOIN invoice_line il 
    ON t.track_id = il.track_id
GROUP BY 
    t.track_id, 
    t.name
ORDER BY 
    units_sold DESC
LIMIT 1;


-- Q14. What are the average prices of different types of music?

SELECT 
    g.genre_id, 
    g.name AS genre_name, 
    ROUND(AVG(t.unit_price), 2) AS average_price
FROM genre g
JOIN track t 
    ON g.genre_id = t.genre_id 
GROUP BY 
    g.genre_id, 
    g.name
ORDER BY 
    average_price DESC;

-- Q15. What are the most popular countries for music purchases?

SELECT billing_country AS country, ROUND(SUM(total),2) AS total_spent, 
COUNT(invoice_id) AS total_invoices
FROM invoice 
GROUP BY billing_country 
ORDER BY total_spent DESC ;