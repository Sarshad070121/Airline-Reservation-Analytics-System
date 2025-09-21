-- CREATE DATABASE airline_reservation_system;
USE airline_reservation_system;

DROP TABLE IF EXISTS airport;
CREATE TABLE airport (
	airport_id INT PRIMARY KEY NOT NULL,
    airport_name VARCHAR(100),
    airport_city VARCHAR(100),
    airport_country VARCHAR(100),
    code varchar(10)
);

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
    flight_id INT PRIMARY KEY NOT NULL,
    airline VARCHAR(100),
    origin_id INT,
    destination_id INT,
    departure_time DATETIME,
    arrival_time DATETIME,
    price DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (origin_id) REFERENCES airport(airport_id),
    FOREIGN KEY (destination_id) REFERENCES airport(airport_id)
);


DROP TABLE IF EXISTS passengers;
CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email_id VARCHAR(100),
    phone_no VARCHAR(20)
);

DROP TABLE IF EXISTS reservation;
CREATE TABLE reservation(
	reservation_id INT PRIMARY KEY NOT NULL,
    passenger_id INT,
    flight_id INT,
    booking_date DATETIME,
    seat_no VARCHAR(10),
    status VARCHAR(20),
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

DROP TABLE IF EXISTS payments;
CREATE TABLE payments(
	payment_id INT PRIMARY KEY NOT NULL,
    reservation_id INT,
    amount DECIMAL(10,2),
    method VARCHAR(30),
    paymentdate DATETIME,
    FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id)
);