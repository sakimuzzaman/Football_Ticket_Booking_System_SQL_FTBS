# ⚽ Football Ticket Booking System (PostgreSQL)

A simple PostgreSQL database project for managing a Football Ticket Booking System. The project demonstrates relational database design, data insertion, and SQL queries using PostgreSQL.

## 📌 Features

- Manage users (Football Fans and Ticket Managers)
- Store football match information
- Record ticket bookings
- Implement relationships using foreign keys
- Perform common SQL queries for data retrieval and analysis

---

## 🗂 Database Schema

The database contains three tables:

### 1. Users
Stores information about registered users.

| Column | Description |
|---------|-------------|
| user_id | Primary Key |
| full_name | User's full name |
| email | Email address |
| role | Ticket Manager or Football Fan |
| phone_number | Contact number |

---

### 2. Matches
Stores football match information.

| Column | Description |
|---------|-------------|
| match_id | Primary Key |
| fixture | Competing teams |
| tournament_category | Tournament name |
| base_ticket_price | Ticket price |
| match_status | Available, Selling Fast, Sold Out, or Postponed |

---

### 3. Bookings
Stores ticket booking information.

| Column | Description |
|---------|-------------|
| booking_id | Primary Key |
| user_id | Foreign Key → Users |
| match_id | Foreign Key → Matches |
| seat_number | Stadium seat |
| payment_status | Pending, Confirmed, Cancelled, or Refunded |
| total_cost | Total booking amount |

---

## 🔗 Database Relationships

- One User → Many Bookings
- One Match → Many Bookings
- Bookings belong to one User
- Bookings belong to one Match

---

## 📥 Sample Data

The project includes sample records for:

- 4 Users
- 5 Football Matches
- 5 Bookings

---

## 📝 SQL Queries

The project demonstrates the following SQL concepts:

### Query 1
Retrieve all available **Champions League** matches.

**Concepts:** `SELECT`, `WHERE`

---

### Query 2
Search users whose name starts with **Tanvir** or contains **Haque**.

**Concepts:** `ILIKE`

---

### Query 3
Find bookings with missing payment status and replace `NULL` with **Action Required**.

**Concepts:** `IS NULL`, `COALESCE`

---

### Query 4
Display booking details together with the user's name and match fixture.

**Concepts:** `INNER JOIN`

---

### Query 5
Display all users, including users who have never booked a ticket.

**Concepts:** `LEFT JOIN`

---

### Query 6
Find bookings whose total cost is greater than the average booking cost.

**Concepts:** `Subquery`, `AVG`

---

### Query 7
Retrieve the second and third most expensive matches by skipping the highest-priced match.

**Concepts:** `ORDER BY`, `OFFSET`, `LIMIT`

---

## 🛠 Technologies Used

- PostgreSQL
- SQL

---

## 📂 Project Structure

```text
Football_Ticket_Booking_System_SQL_FTBS/
│
├── football_ticket_booking_system.sql
└── README.md
```

---

## 🚀 How to Run

1. Create a PostgreSQL database.
2. Execute the SQL script.
3. The script will:
   - Create all tables
   - Insert sample data
   - Execute sample queries

---

## 📄 License

This project is created for learning and academic purposes.