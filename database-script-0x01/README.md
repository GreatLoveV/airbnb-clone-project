# ALX Airbnb Database Schema

This repository contains the SQL scripts to create the database schema for the **Airbnb-like** platform. The schema defines the structure for **users**, **properties**, **bookings**, **payments**, **reviews**, and **messages**.

## Database Schema

The following tables are included in the schema:

### 1. User
- **user_id**: UUID, Primary Key
- **first_name**: VARCHAR(100), NOT NULL
- **last_name**: VARCHAR(100), NOT NULL
- **email**: VARCHAR(255), Unique, NOT NULL
- **password_hash**: VARCHAR(255), NOT NULL
- **phone_number**: VARCHAR(15), NULL
- **role**: ENUM('guest', 'host', 'admin'), NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### 2. Property
- **property_id**: UUID, Primary Key
- **host_id**: UUID, Foreign Key referencing `User(user_id)`
- **name**: VARCHAR(255), NOT NULL
- **description**: TEXT, NOT NULL
- **location**: VARCHAR(255), NOT NULL
- **pricepernight**: DECIMAL(10, 2), NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- **updated_at**: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

### 3. Booking
- **booking_id**: UUID, Primary Key
- **property_id**: UUID, Foreign Key referencing `Property(property_id)`
- **user_id**: UUID, Foreign Key referencing `User(user_id)`
- **start_date**: DATE, NOT NULL
- **end_date**: DATE, NOT NULL
- **total_price**: DECIMAL(10, 2), NOT NULL
- **status**: ENUM('pending', 'confirmed', 'canceled'), NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### 4. Payment
- **payment_id**: UUID, Primary Key
- **booking_id**: UUID, Foreign Key referencing `Booking(booking_id)`
- **amount**: DECIMAL(10, 2), NOT NULL
- **payment_date**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- **payment_method**: ENUM('credit_card', 'paypal', 'stripe'), NOT NULL

### 5. Review
- **review_id**: UUID, Primary Key
- **property_id**: UUID, Foreign Key referencing `Property(property_id)`
- **user_id**: UUID, Foreign Key referencing `User(user_id)`
- **rating**: INT, CHECK (rating >= 1 AND rating <= 5), NOT NULL
- **comment**: TEXT, NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### 6. Message
- **message_id**: UUID, Primary Key
- **sender_id**: UUID, Foreign Key referencing `User(user_id)`
- **recipient_id**: UUID, Foreign Key referencing `User(user_id)`
- **message_body**: TEXT, NOT NULL
- **sent_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Setup

To create the schema, execute the SQL script `schema.sql` in your PostgreSQL database.

```bash
psql -f schema.sql
