-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup Template
-- DESCRIPTION: Pseudo-DDL Template for Table Creation & Data Insertion
-- INSTRUCTIONS: Replace 'TYPE' and the constraint placeholders with your own
--               actual data types, relational keys, and check criteria.
-- =========================================================================


CREATE DATABASE ticketBookingSystem

 -- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE users (
  user_id serial primary key,
  full_name varchar(55) not null,
  email varchar(85) not null,
  role varchar(16) not null check (role in ('Ticket Manager', 'Football Fan')),
  phone_number varchar(20) 
)

  DROP TABLE users


-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================

CREATE TABLE matches (
  match_id serial primary key,
  fixture varchar(125) not null,
  tournament_category varchar(85) not null,
  base_ticket_price numeric(10,2) check ( base_ticket_price > 0 ),
  match_status varchar(20) not null
    check (match_status in ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
  
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================

CREATE TABLE bookings (
  booking_id serial primary key,
  user_id int not null,
  match_id int not null,
  seat_number varchar(10),
  payment_status varchar(20) 
    check (payment_status in ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
  total_cost numeric(10,2) not null
    check ( total_cost >= 0 ),
  foreign key (user_id) references users(user_id),
  foreign key (match_id) references matches(match_id)
)

DROP TABLE bookings

  
-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================


INSERT INTO users (user_id, full_name, email, role, phone_number)
VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================



INSERT INTO matches (match_id, fixture, tournament_category, base_ticket_price, match_status)
VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================

INSERT INTO bookings (
    booking_id,
    user_id,
    match_id,
    seat_number,
    payment_status,
    total_cost
)
VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);


-- 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.

SELECT
    match_id,
    fixture,
    base_ticket_price
FROM matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';


-- 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).
SELECT
    user_id,
    full_name,
    email
FROM users
WHERE full_name ILIKE 'Tanvir%'
   OR full_name ILIKE '%Haque%';


-- 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.

SELECT
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM bookings
WHERE payment_status IS NULL;


-- 4: Retrieve match booking details along with the User's full name and the scheduled Match fixture teams.

SELECT
    bookings.booking_id,
    users.full_name,
    matches.fixture,
    bookings.total_cost
FROM bookings
INNER JOIN users
    ON bookings.user_id = users.user_id
INNER JOIN matches
    ON bookings.match_id = matches.match_id;


-- 5: Display a comprehensive list of all users and their booking IDs, ensuring that fans who have never bought a ticket are still listed.

SELECT
    users.user_id,
    users.full_name,
    bookings.booking_id
FROM users
LEFT JOIN bookings
    ON users.user_id = bookings.user_id;

-- 6: Find all ticket bookings where the total cost is strictly higher than the average cost of all ticket bookings.

SELECT
    booking_id,
    match_id,
    total_cost
FROM bookings
WHERE total_cost > (
    SELECT AVG(total_cost)
    FROM bookings
);


-- 7: Retrieve the top 2 most expensive matches sorted by base ticket price, skipping the absolute highest premium match.

SELECT
    match_id,
    fixture,
    base_ticket_price
FROM matches
ORDER BY base_ticket_price DESC
OFFSET 1
LIMIT 2;
