# Entity-Relationship Diagram (ERD) Requirements

This document describes the core entities, their attributes, and the relationships designed for the Airbnb-like database system.

---

## Entities and Attributes

### 1. User
- `user_id`: UUID (Primary Key)
- `first_name`: VARCHAR, NOT NULL
- `last_name`: VARCHAR, NOT NULL
- `email`: VARCHAR, UNIQUE, NOT NULL
- `password_hash`: VARCHAR, NOT NULL
- `phone_number`: VARCHAR, NULL
- `role`: ENUM('guest', 'host', 'admin'), NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

---

### 2. Property
- `property_id`: UUID (Primary Key)
- `host_id`: UUID (Foreign Key → User.user_id)
- `name`: VARCHAR, NOT NULL
- `description`: TEXT, NOT NULL
- `location`: VARCHAR, NOT NULL
- `pricepernight`: DECIMAL, NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- `updated_at`: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

---

### 3. Booking
- `booking_id`: UUID (Primary Key)
- `property_id`: UUID (Foreign Key → Property.property_id)
- `user_id`: UUID (Foreign Key → User.user_id)
- `start_date`: DATE, NOT NULL
- `end_date`: DATE, NOT NULL
- `total_price`: DECIMAL, NOT NULL
- `status`: ENUM('pending', 'confirmed', 'canceled'), NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

---

### 4. Payment
- `payment_id`: UUID (Primary Key)
- `booking_id`: UUID (Foreign Key → Booking.booking_id)
- `amount`: DECIMAL, NOT NULL
- `payment_date`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- `payment_method`: ENUM('credit_card', 'paypal', 'stripe'), NOT NULL

---

### 5. Review
- `review_id`: UUID (Primary Key)
- `property_id`: UUID (Foreign Key → Property.property_id)
- `user_id`: UUID (Foreign Key → User.user_id)
- `rating`: INTEGER (1–5), NOT NULL, CHECK constraint
- `comment`: TEXT, NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

---

### 6. Message
- `message_id`: UUID (Primary Key)
- `sender_id`: UUID (Foreign Key → User.user_id)
- `recipient_id`: UUID (Foreign Key → User.user_id)
- `message_body`: TEXT, NOT NULL
- `sent_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

---

## Relationships

- **User —< Booking**: A user can make many bookings.
- **User —< Property**: A user (host) can list multiple properties.
- **User —< Review**: A user can write many reviews.
- **User —< Message (sender & recipient)**: A user can send and receive many messages.
- **Property —< Booking**: A property can be booked many times.
- **Property —< Review**: A property can receive many reviews.
- **Booking —1:1—> Payment**: Each booking has one payment.

---

## Assumptions and Notes

- UUIDs are used for all primary keys to ensure uniqueness.
- Users can play multiple roles (guest, host, admin), but role logic is determined at the application level.
- Each property must belong to one host (a user).
- Bookings are linked to both a user (guest) and a property.
- Messages are stored in a single table with sender and recipient as foreign keys to the User table.
