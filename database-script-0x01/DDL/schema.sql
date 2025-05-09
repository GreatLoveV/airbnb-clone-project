-- schema.sql

-- Create User Table
CREATE TABLE User (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),  -- UUID as primary key
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,  -- Unique constraint on email
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    role ENUM('guest', 'host', 'admin') NOT NULL,  -- ENUM for role
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX(email)  -- Index on email for faster search
);

-- Create Property Table
CREATE TABLE Property (
    property_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),  -- UUID as primary key
    host_id UUID,  -- Foreign key reference to User table
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES User(user_id) ON DELETE CASCADE,  -- Foreign key constraint
    INDEX(property_id)  -- Index on property_id
);

-- Create Booking Table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),  -- UUID as primary key
    property_id UUID,  -- Foreign key reference to Property table
    user_id UUID,  -- Foreign key reference to User table
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,  -- ENUM for status
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,  -- Foreign key constraint
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,  -- Foreign key constraint
    INDEX(property_id),  -- Index on property_id
    INDEX(user_id)  -- Index on user_id
);

-- Create Payment Table
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),  -- UUID as primary key
    booking_id UUID,  -- Foreign key reference to Booking table
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,  -- ENUM for payment method
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE,  -- Foreign key constraint
    INDEX(booking_id)  -- Index on booking_id
);

-- Create Review Table
CREATE TABLE Review (
    review_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),  -- UUID as primary key
    property_id UUID,  -- Foreign key reference to Property table
    user_id UUID,  -- Foreign key reference to User table
    rating INT CHECK (rating >= 1 AND rating <= 5) NOT NULL,  -- Rating constraint
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,  -- Foreign key constraint
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,  -- Foreign key constraint
    INDEX(property_id),  -- Index on property_id
    INDEX(user_id)  -- Index on user_id
);

-- Create Message Table
CREATE TABLE Message (
    message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),  -- UUID as primary key
    sender_id UUID,  -- Foreign key reference to User table
    recipient_id UUID,  -- Foreign key reference to User table
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE CASCADE,  -- Foreign key constraint
    FOREIGN KEY (recipient_id) REFERENCES User(user_id) ON DELETE CASCADE,  -- Foreign key constraint
    INDEX(sender_id),  -- Index on sender_id
    INDEX(recipient_id)  -- Index on recipient_id
);
