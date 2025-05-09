# Normalization Process

## Objective
To ensure the database schema adheres to the Third Normal Form (3NF) by eliminating redundancy, ensuring data integrity, and optimizing structure.

---

## First Normal Form (1NF)
- All tables contain atomic values.
- No multi-valued or repeating fields exist.

## Second Normal Form (2NF)
- All tables are in 1NF.
- Non-key attributes are fully dependent on their entire primary key.

## Third Normal Form (3NF)
- All tables are in 2NF.
- No transitive dependencies (i.e., non-key attributes do not depend on other non-key attributes).

---

## Table-by-Table Analysis

### User
- All attributes depend only on `user_id`.
- No derived or redundant data.

### Property
- `host_id` is a foreign key; other attributes describe the property.
- No repetition or dependency between non-key attributes.

### Booking
- `property_id` and `user_id` are foreign keys.
- Dates and `total_price` are dependent solely on `booking_id`.

### Payment
- Linked only to `booking_id`.
- `amount`, `payment_method`, and `payment_date` directly describe the payment.

### Review
- `user_id` and `property_id` are foreign keys.
- `rating` and `comment` depend only on the review entity.

### Message
- `sender_id` and `recipient_id` reference the user.
- `message_body` is directly related to the `message_id`.

---

## Conclusion

The database design adheres to 3NF, ensuring minimal redundancy, clear structure, and efficient querying.
