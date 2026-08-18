-- Drop existing tables in reverse dependency order
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS passengers;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS aircrafts;
DROP TABLE IF EXISTS airlines;
DROP TABLE IF EXISTS airports;
DROP TABLE IF EXISTS Users;

-- Create Tables
CREATE TABLE Users (
    UserID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL
);

CREATE TABLE airports (
    airport_id INT NOT NULL PRIMARY KEY,
    airport_name VARCHAR(100) NOT NULL,
    airport_code VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    timezone VARCHAR(50) NOT NULL
);

CREATE TABLE airlines (
    airline_id INT NOT NULL PRIMARY KEY,
    airline_name VARCHAR(100) NOT NULL,
    iata_code VARCHAR(10) NOT NULL,
    country VARCHAR(50) NOT NULL,
    contact_email VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL
);

CREATE TABLE aircrafts (
    aircraft_id INT NOT NULL PRIMARY KEY,
    aircraft_code VARCHAR(20) NOT NULL,
    model VARCHAR(100) NOT NULL,
    airline_id INT NOT NULL,
    total_seats INT NOT NULL,
    manufacture_year INT NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id)
);

CREATE TABLE flights (
    flight_id INT NOT NULL PRIMARY KEY,
    flight_number VARCHAR(20) NOT NULL,
    airline_id INT NOT NULL,
    aircraft_id INT NOT NULL,
    origin_id INT NOT NULL,
    destination_id INT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    fare DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id),
    FOREIGN KEY (origin_id) REFERENCES airports(airport_id),
    FOREIGN KEY (destination_id) REFERENCES airports(airport_id)
);

CREATE TABLE passengers (
    passenger_id INT NOT NULL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    passport_no VARCHAR(20) NOT NULL,
    nationality VARCHAR(50) NOT NULL,
    dob DATE NOT NULL
);

CREATE TABLE bookings (
    booking_id INT NOT NULL PRIMARY KEY,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    booking_date DATE NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    seat_class VARCHAR(20) NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    booking_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

-- 1. Insert Airports
INSERT INTO airports (airport_id, airport_name, airport_code, city, country, timezone) VALUES
(1,  'Indira Gandhi International Airport',    'DEL', 'New Delhi',    'India',          'Asia/Kolkata'),
(2,  'Chhatrapati Shivaji Maharaj International Airport', 'BOM', 'Mumbai', 'India',    'Asia/Kolkata'),
(3,  'Kempegowda International Airport',       'BLR', 'Bangalore',    'India',          'Asia/Kolkata'),
(4,  'Chennai International Airport',          'MAA', 'Chennai',      'India',          'Asia/Kolkata'),
(5,  'Netaji Subhas Chandra Bose International Airport', 'CCU', 'Kolkata', 'India',     'Asia/Kolkata'),
(6,  'Rajiv Gandhi International Airport',     'HYD', 'Hyderabad',    'India',          'Asia/Kolkata'),
(7,  'Sardar Vallabhbhai Patel International Airport', 'AMD', 'Ahmedabad', 'India',     'Asia/Kolkata'),
(8,  'Dubai International Airport',            'DXB', 'Dubai',        'UAE',            'Asia/Dubai'),
(9,  'Heathrow Airport',                       'LHR', 'London',       'United Kingdom', 'Europe/London'),
(10, 'John F. Kennedy International Airport',  'JFK', 'New York',     'USA',            'America/New_York'),
(11, 'Singapore Changi Airport',               'SIN', 'Singapore',    'Singapore',      'Asia/Singapore'),
(12, 'Sydney Kingsford Smith Airport',         'SYD', 'Sydney',       'Australia',      'Australia/Sydney'),
(13, 'Frankfurt Airport',                      'FRA', 'Frankfurt',    'Germany',        'Europe/Berlin'),
(14, 'Bangkok Suvarnabhumi Airport',           'BKK', 'Bangkok',      'Thailand',       'Asia/Bangkok'),
(15, 'Kuala Lumpur International Airport',     'KUL', 'Kuala Lumpur', 'Malaysia',       'Asia/Kuala_Lumpur');

-- 2. Insert Airlines
INSERT INTO airlines (airline_id, airline_name, iata_code, country, contact_email, status) VALUES
(1, 'Air India',           'AI', 'India',          'support@airindia.in',       'Active'),
(2, 'IndiGo',              '6E', 'India',          'care@goindigo.in',          'Active'),
(3, 'SpiceJet',            'SG', 'India',          'support@spicejet.com',      'Active'),
(4, 'Vistara',             'UK', 'India',          'customercare@airvistara.com','Active'),
(5, 'Emirates',            'EK', 'UAE',            'support@emirates.com',      'Active'),
(6, 'British Airways',     'BA', 'United Kingdom', 'help@britishairways.com',   'Active'),
(7, 'Singapore Airlines',  'SQ', 'Singapore',      'customercare@singaporeair.com','Active'),
(8, 'AirAsia',             'AK', 'Malaysia',       'support@airasia.com',       'Suspended');

-- 3. Insert Aircrafts
INSERT INTO aircrafts (aircraft_id, aircraft_code, model, airline_id, total_seats, manufacture_year) VALUES
(1,  'VT-PPB', 'Boeing 787-8 Dreamliner',  1, 256, 2015),
(2,  'VT-IGL', 'Airbus A320neo',            2, 186, 2018),
(3,  'VT-IGM', 'Airbus A320neo',            2, 186, 2019),
(4,  'VT-SGF', 'Boeing 737-800',            3, 189, 2016),
(5,  'VT-SGG', 'Boeing 737-800',            3, 189, 2017),
(6,  'VT-TTB', 'Airbus A320',               4, 158, 2020),
(7,  'VT-TTC', 'Boeing 787-9 Dreamliner',   4, 268, 2021),
(8,  'A6-ENA', 'Boeing 777-300ER',          5, 354, 2014),
(9,  'A6-ENB', 'Airbus A380-800',           5, 489, 2013),
(10, 'G-XWBA', 'Airbus A350-1000',          6, 331, 2019),
(11, '9V-SKA', 'Boeing 777-300ER',          7, 299, 2016),
(12, '9M-AQA', 'Airbus A320',               8, 180, 2017);

-- 4. Insert Flights
INSERT INTO flights (flight_id, flight_number, airline_id, aircraft_id, origin_id, destination_id, departure_time, arrival_time, fare, status) VALUES
(1,  'AI-101',  1, 1,  1,  2,  '2024-03-01 06:00:00', '2024-03-01 08:10:00',  4500.00,  'Completed'),
(2,  'AI-202',  1, 1,  2,  9,  '2024-03-02 22:00:00', '2024-03-03 04:30:00', 32000.00,  'Completed'),
(3,  '6E-301',  2, 2,  1,  3,  '2024-03-03 07:30:00', '2024-03-03 09:45:00',  3200.00,  'Completed'),
(4,  '6E-402',  2, 3,  3,  6,  '2024-03-04 11:00:00', '2024-03-04 12:30:00',  2800.00,  'Completed'),
(5,  'SG-501',  3, 4,  1,  4,  '2024-03-05 08:00:00', '2024-03-05 10:15:00',  3500.00,  'Completed'),
(6,  'SG-602',  3, 5,  4,  7,  '2024-03-06 14:00:00', '2024-03-06 15:45:00',  2600.00,  'Delayed'),
(7,  'UK-701',  4, 6,  1,  5,  '2024-03-07 09:30:00', '2024-03-07 13:00:00',  5200.00,  'Scheduled'),
(8,  'UK-802',  4, 7,  2,  8,  '2024-03-08 18:00:00', '2024-03-08 21:30:00', 18000.00,  'Scheduled'),
(9,  'EK-901',  5, 8,  8, 10,  '2024-03-09 02:00:00', '2024-03-09 14:00:00', 55000.00,  'Completed'),
(10, 'EK-1002', 5, 9,  8,  9,  '2024-03-10 08:30:00', '2024-03-10 13:00:00', 42000.00,  'Completed'),
(11, 'BA-201',  6, 10, 9,  1,  '2024-03-11 10:00:00', '2024-03-11 23:30:00', 48000.00,  'Completed'),
(12, 'BA-302',  6, 10, 9, 13,  '2024-03-12 12:00:00', '2024-03-12 14:30:00', 22000.00,  'Cancelled'),
(13, 'SQ-401',  7, 11, 11, 1,  '2024-03-13 00:30:00', '2024-03-13 05:00:00', 36000.00,  'Completed'),
(14, 'SQ-502',  7, 11, 11, 12, '2024-03-14 09:00:00', '2024-03-14 18:30:00', 41000.00,  'Scheduled'),
(15, 'AI-303',  1, 1,  2,  4,  '2024-03-15 07:00:00', '2024-03-15 09:30:00',  3800.00,  'Completed'),
(16, '6E-503',  2, 2,  1,  2,  '2024-03-16 06:30:00', '2024-03-16 08:40:00',  3100.00,  'Scheduled'),
(17, 'SG-703',  3, 4,  4,  1,  '2024-03-17 16:00:00', '2024-03-17 18:15:00',  3300.00,  'Delayed'),
(18, 'UK-903',  4, 6,  1,  3,  '2024-03-18 13:00:00', '2024-03-18 15:10:00',  4100.00,  'Scheduled'),
(19, 'EK-1103', 5, 8,  8, 14,  '2024-03-19 03:00:00', '2024-03-19 07:30:00', 28000.00,  'Completed'),
(20, 'AK-101',  8, 12, 15, 11,  '2024-03-20 10:00:00', '2024-03-20 12:00:00',  8500.00,  'Cancelled');

-- 5. Insert Passengers
INSERT INTO passengers (passenger_id, full_name, email, phone, passport_no, nationality, dob) VALUES
(1,  'Aarav Sharma',      'aarav.sharma@gmail.com',      '9876543210', 'P1234567', 'Indian',      '1990-04-15'),
(2,  'Priya Mehta',       'priya.mehta@yahoo.com',       '9823456781', 'P2345678', 'Indian',      '1992-07-22'),
(3,  'Rahul Verma',       'rahul.verma@outlook.com',     '9712345682', 'P3456789', 'Indian',      '1988-11-05'),
(4,  'Sneha Patel',       'sneha.patel@gmail.com',       '9634567893', 'P4567890', 'Indian',      '1995-02-18'),
(5,  'Vikram Singh',      'vikram.singh@hotmail.com',    '9545678904', 'P5678901', 'Indian',      '1985-09-30'),
(6,  'Ananya Iyer',       'ananya.iyer@gmail.com',       '9456789015', 'P6789012', 'Indian',      '1998-06-12'),
(7,  'Karan Kapoor',      'karan.kapoor@gmail.com',      '9367890126', 'P7890123', 'Indian',      '1993-03-25'),
(8,  'Divya Nair',        'divya.nair@rediffmail.com',   '9278901237', 'P8901234', 'Indian',      '1991-12-08'),
(9,  'Mohammed Al Farsi', 'mohammed.alfarsi@email.ae',   '0551234568', 'UAE123456','Emirati',     '1987-08-14'),
(10, 'Sarah Johnson',     'sarah.j@gmail.com',           '07911123459','GB123456', 'British',     '1989-05-20'),
(11, 'Liu Wei',           'liu.wei@163.com',             '13812345670','CN123456', 'Chinese',     '1994-01-17'),
(12, 'Emily Watson',      'emily.watson@yahoo.com',      '21298765431','US123456', 'American',    '1996-10-03'),
(13, 'Rohan Desai',       'rohan.desai@gmail.com',       '9189012342', 'P9012345', 'Indian',      '1990-07-29'),
(14, 'Meera Krishnan',    'meera.k@gmail.com',           '9090123453', 'P0123456', 'Indian',      '1997-04-11'),
(15, 'Arjun Reddy',       'arjun.reddy@gmail.com',       '9901234564', 'P1122334', 'Indian',      '1986-02-28'),
(16, 'Fatima Sheikh',     'fatima.sheikh@email.ae',      '0559876545', 'UAE654321','Emirati',     '1993-09-19'),
(17, 'James Miller',      'james.miller@gmail.com',      '07922334456','GB654321', 'British',     '1984-12-31'),
(18, 'Nisha Agarwal',     'nisha.agarwal@gmail.com',     '9812345677', 'P2233445', 'Indian',      '1999-08-05'),
(19, 'Chen Jing',         'chen.jing@qq.com',            '13987654328','CN654321', 'Chinese',     '1991-03-16'),
(20, 'Siddharth Joshi',   'siddharth.j@gmail.com',       '9723456789', 'P3344556', 'Indian',      '1988-06-22');

-- 6. Insert Bookings
INSERT INTO bookings (booking_id, passenger_id, flight_id, booking_date, seat_number, seat_class, amount_paid, booking_status) VALUES
(1,  1,  1,  '2024-02-15', '12A', 'Economy',  4500.00,  'Confirmed'),
(2,  2,  1,  '2024-02-16', '14B', 'Economy',  4500.00,  'Confirmed'),
(3,  3,  2,  '2024-02-10', '3A',  'Business', 64000.00, 'Confirmed'),
(4,  4,  3,  '2024-02-20', '22C', 'Economy',  3200.00,  'Confirmed'),
(5,  5,  4,  '2024-02-22', '8D',  'Economy',  2800.00,  'Confirmed'),
(6,  6,  5,  '2024-02-25', '18E', 'Economy',  3500.00,  'Confirmed'),
(7,  7,  6,  '2024-02-26', '5A',  'Business', 7800.00,  'Confirmed'),
(8,  8,  7,  '2024-02-28', '11B', 'Economy',  5200.00,  'Pending'),
(9,  9,  9,  '2024-02-05', '2A',  'First',    110000.00,'Confirmed'),
(10, 10, 10, '2024-02-08', '1B',  'First',    84000.00, 'Confirmed'),
(11, 11, 13, '2024-02-12', '20C', 'Economy',  36000.00, 'Confirmed'),
(12, 12, 11, '2024-02-14', '4A',  'Business', 96000.00, 'Confirmed'),
(13, 13, 15, '2024-03-01', '9C',  'Economy',  3800.00,  'Confirmed'),
(14, 14, 3,  '2024-02-21', '25D', 'Economy',  3200.00,  'Confirmed'),
(15, 15, 4,  '2024-02-23', '7E',  'Business', 8400.00,  'Confirmed'),
(16, 16, 8,  '2024-02-27', '6B',  'Business', 36000.00, 'Pending'),
(17, 17, 10, '2024-02-09', '10A', 'Economy',  42000.00, 'Confirmed'),
(18, 18, 16, '2024-03-05', '30F', 'Economy',  3100.00,  'Confirmed'),
(19, 19, 14, '2024-03-02', '15C', 'Economy',  41000.00, 'Pending'),
(20, 20, 7,  '2024-02-28', '2B',  'Business', 15600.00, 'Confirmed'),
(21, 1,  15, '2024-03-03', '19A', 'Economy',  3800.00,  'Confirmed'),
(22, 2,  5,  '2024-02-24', '13B', 'Economy',  3500.00,  'Cancelled'),
(23, 3,  9,  '2024-02-06', '1A',  'First',    110000.00,'Confirmed'),
(24, 5,  11, '2024-02-13', '22D', 'Economy',  48000.00, 'Confirmed'),
(25, 6,  19, '2024-03-08', '17E', 'Economy',  28000.00, 'Confirmed'),
(26, 7,  13, '2024-02-11', '5C',  'Business', 72000.00, 'Confirmed'),
(27, 8,  16, '2024-03-06', '28F', 'Economy',  3100.00,  'Cancelled'),
(28, 10, 2,  '2024-02-11', '6A',  'Economy',  32000.00, 'Confirmed'),
(29, 13, 17, '2024-03-10', '14D', 'Economy',  3300.00,  'Pending'),
(30, 15, 19, '2024-03-09', '3B',  'Business', 56000.00, 'Confirmed');

SELECT 'Airports' AS TableName, COUNT(*) AS TotalRecords FROM airports
UNION ALL
SELECT 'Airlines', COUNT(*) FROM airlines
UNION ALL
SELECT 'Aircrafts', COUNT(*) FROM aircrafts
UNION ALL
SELECT 'Flights', COUNT(*) FROM flights
UNION ALL
SELECT 'Passengers', COUNT(*) FROM passengers
UNION ALL
SELECT 'Bookings', COUNT(*) FROM bookings;

SELECT 
    b.booking_id,
    p.full_name AS passenger_name,
    al.airline_name,
    f.flight_number,
    orig.city AS departure_city,
    dest.city AS arrival_city,
    f.departure_time,
    b.seat_number,
    b.seat_class,
    b.amount_paid,
    b.booking_status
FROM bookings b
JOIN passengers p ON b.passenger_id = p.passenger_id
JOIN flights f ON b.flight_id = f.flight_id
JOIN airlines al ON f.airline_id = al.airline_id
JOIN airports orig ON f.origin_id = orig.airport_id
JOIN airports dest ON f.destination_id = dest.airport_id;

SELECT 
    al.airline_name,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.amount_paid) AS total_revenue
FROM bookings b
JOIN flights f ON b.flight_id = f.flight_id
JOIN airlines al ON f.airline_id = al.airline_id
WHERE b.booking_status = 'Confirmed'
GROUP BY al.airline_name
ORDER BY total_revenue DESC;

CREATE TABLE passengers (
    passenger_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) UNIQUE,
    passport_no VARCHAR(20) UNIQUE,
    nationality VARCHAR(50) NOT NULL,
    dob DATE NOT NULL
);

CREATE TABLE bookings (
    booking_id INT IDENTITY(1,1) PRIMARY KEY,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    booking_date DATE DEFAULT GETDATE(),
    seat_number VARCHAR(5) NOT NULL,
    seat_class VARCHAR(20) CHECK (seat_class IN ('Economy', 'Business', 'First')),
    amount_paid DECIMAL(8,2) NOT NULL,
    booking_status VARCHAR(20) CHECK (booking_status IN ('Confirmed', 'Cancelled', 'Pending')),
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

-- Table 1: airports
CREATE TABLE airports (
    airport_id INT IDENTITY(1,1) PRIMARY KEY,
    airport_name VARCHAR(150) NOT NULL UNIQUE,
    airport_code CHAR(3) NOT NULL UNIQUE,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    timezone VARCHAR(50) NOT NULL
);

-- Table 2: airlines
CREATE TABLE airlines (
    airline_id INT IDENTITY(1,1) PRIMARY KEY,
    airline_name VARCHAR(100) NOT NULL UNIQUE,
    iata_code CHAR(2) NOT NULL UNIQUE,
    country VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(20) CHECK (status IN ('Active', 'Suspended'))
);

-- Table 3: aircrafts
-- Note: SQL Server does not have a native 'YEAR' type, so INT with a CHECK constraint is used.
CREATE TABLE aircrafts (
    aircraft_id INT IDENTITY(1,1) PRIMARY KEY,
    aircraft_code VARCHAR(20) NOT NULL UNIQUE,
    model VARCHAR(100) NOT NULL,
    airline_id INT,
    total_seats INT NOT NULL,
    manufacture_year INT NOT NULL CHECK (manufacture_year BETWEEN 1900 AND 2100),
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id)
);

-- Table 4: flights
CREATE TABLE flights (
    flight_id INT IDENTITY(1,1) PRIMARY KEY,
    flight_number VARCHAR(10) NOT NULL UNIQUE,
    airline_id INT,
    aircraft_id INT,
    origin_id INT,
    destination_id INT,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    fare DECIMAL(8,2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Scheduled', 'Delayed', 'Cancelled', 'Completed')),
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id),
    FOREIGN KEY (origin_id) REFERENCES airports(airport_id),
    FOREIGN KEY (destination_id) REFERENCES airports(airport_id)
);

-- Q1: Create tables - airports and airlines
CREATE TABLE airports (
    airport_id INT IDENTITY(1,1) PRIMARY KEY,
    airport_name VARCHAR(150) NOT NULL UNIQUE,
    airport_code CHAR(3) NOT NULL UNIQUE,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    timezone VARCHAR(50) NOT NULL
);

CREATE TABLE airlines (
    airline_id INT IDENTITY(1,1) PRIMARY KEY,
    airline_name VARCHAR(100) NOT NULL UNIQUE,
    iata_code CHAR(2) NOT NULL UNIQUE,
    country VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(20) CHECK (status IN ('Active', 'Suspended'))
);

-- Q2: Create tables - aircrafts, flights, passengers, and bookings
CREATE TABLE aircrafts (
    aircraft_id INT IDENTITY(1,1) PRIMARY KEY,
    aircraft_code VARCHAR(20) NOT NULL UNIQUE,
    model VARCHAR(100) NOT NULL,
    airline_id INT,
    total_seats INT NOT NULL,
    manufacture_year INT NOT NULL CHECK (manufacture_year BETWEEN 1900 AND 2100),
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id)
);

CREATE TABLE flights (
    flight_id INT IDENTITY(1,1) PRIMARY KEY,
    flight_number VARCHAR(10) NOT NULL UNIQUE,
    airline_id INT,
    aircraft_id INT,
    origin_id INT,
    destination_id INT,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    fare DECIMAL(8,2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Scheduled', 'Delayed', 'Cancelled', 'Completed')),
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id),
    FOREIGN KEY (origin_id) REFERENCES airports(airport_id),
    FOREIGN KEY (destination_id) REFERENCES airports(airport_id)
);

CREATE TABLE passengers (
    passenger_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    passport_no VARCHAR(20) NOT NULL UNIQUE,
    nationality VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE bookings (
    booking_id INT IDENTITY(1,1) PRIMARY KEY,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    booking_date DATE DEFAULT CAST(GETDATE() AS DATE),
    seat_number VARCHAR(5),
    seat_class VARCHAR(15) CHECK (seat_class IN ('Economy', 'Business', 'First')),
    amount_paid DECIMAL(8,2) NOT NULL,
    booking_status VARCHAR(20) CHECK (booking_status IN ('Confirmed', 'Cancelled', 'Pending')),
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);
GO

-- Q3: Insert sample records into airports
INSERT INTO airports (airport_name, airport_code, city, country, timezone) 
VALUES 
('Indira Gandhi International Airport', 'DEL', 'New Delhi', 'India', 'Asia/Kolkata'),
('Chhatrapati Shivaji Maharaj International Airport', 'BOM', 'Mumbai', 'India', 'Asia/Kolkata'),
('Heathrow Airport', 'LHR', 'London', 'United Kingdom', 'Europe/London');

-- Q4: Insert sample records into flights
INSERT INTO flights (flight_number, airline_id, aircraft_id, origin_id, destination_id, departure_time, arrival_time, fare, status) 
VALUES 
('AI-202', 1, 1, 1, 2, '2026-09-01 10:00:00', '2026-09-01 12:15:00', 5500.00, 'Delayed'),
('6E-501', 2, 2, 2, 3, '2026-09-02 14:30:00', '2026-09-02 19:45:00', 32000.00, 'Scheduled');

-- Q5: Update scheduled flights to cancelled for airline 3
UPDATE flights 
SET status = 'Cancelled' 
WHERE airline_id = 3 AND status = 'Scheduled';

-- Q6: Delete cancelled bookings prior to June 2023
DELETE FROM bookings 
WHERE booking_status = 'Cancelled' AND booking_date < '2023-06-01';
GO



-- Q7: Check constraint on fare
ALTER TABLE flights
ADD CONSTRAINT chk_fare_positive CHECK (fare > 0);

-- Q8: Unique constraint on passport_no
ALTER TABLE passengers
ADD CONSTRAINT uq_passport_no UNIQUE (passport_no);




-- Q10: Modify seat_number column to NOT NULL
ALTER TABLE bookings
ALTER COLUMN seat_number VARCHAR(5) NOT NULL;

-- Q11: Default constraint on flight status
ALTER TABLE flights
ADD CONSTRAINT df_flight_status DEFAULT 'Scheduled' FOR status;

-- Q12: Add 'Waitlisted' status option
-- Drop existing constraint (system name may vary, replace if needed)
-- ALTER TABLE bookings DROP CONSTRAINT CK__bookings__bookin__12345678;
ALTER TABLE bookings
ADD CONSTRAINT chk_booking_status CHECK (booking_status IN ('Confirmed', 'Cancelled', 'Pending', 'Waitlisted'));
GO


-- Q13: Flights with airline names
SELECT 
    f.flight_number, 
    a.airline_name, 
    f.departure_time, 
    f.status
FROM flights f
INNER JOIN airlines a ON f.airline_id = a.airline_id;

-- Q14: Passenger booking details
SELECT 
    p.full_name, 
    f.flight_number, 
    b.seat_class, 
    b.amount_paid
FROM bookings b
INNER JOIN passengers p ON b.passenger_id = p.passenger_id
INNER JOIN flights f ON b.flight_id = f.flight_id;

-- Q15: Flights with origin and destination cities
SELECT 
    f.flight_number, 
    orig.city AS origin_city, 
    dest.city AS destination_city
FROM flights f
INNER JOIN airports orig ON f.origin_id = orig.airport_id
INNER JOIN airports dest ON f.destination_id = dest.airport_id;

-- Q16: Passenger payments per flight
SELECT 
    p.full_name, 
    f.flight_number, 
    b.amount_paid
FROM passengers p
INNER JOIN bookings b ON p.passenger_id = b.passenger_id
INNER JOIN flights f ON b.flight_id = f.flight_id;

-- Q17: Scheduled flights and aircraft details
SELECT 
    f.flight_number, 
    ac.model, 
    ac.total_seats, 
    f.departure_time
FROM flights f
INNER JOIN aircrafts ac ON f.aircraft_id = ac.aircraft_id
WHERE f.status = 'Scheduled';

-- Q18: Aircraft and airline breakdown
SELECT 
    al.airline_name, 
    ac.model, 
    ac.manufacture_year
FROM aircrafts ac
INNER JOIN airlines al ON ac.airline_id = al.airline_id;

-- Q19: Passengers with no bookings
SELECT 
    p.full_name, 
    p.email
FROM passengers p
LEFT JOIN bookings b ON p.passenger_id = b.passenger_id
WHERE b.booking_id IS NULL;

-- Q20: Total bookings count per flight
SELECT 
    f.flight_number, 
    COUNT(b.booking_id) AS total_bookings
FROM flights f
LEFT JOIN bookings b ON f.flight_id = b.flight_id
GROUP BY f.flight_id, f.flight_number;

-- Q21: Airlines with no assigned aircraft
SELECT 
    al.airline_id, 
    al.airline_name
FROM airlines al
LEFT JOIN aircrafts ac ON al.airline_id = ac.airline_id
WHERE ac.aircraft_id IS NULL;

-- Q22: Departing flights count per airport
SELECT 
    ap.airport_name, 
    ap.airport_code, 
    COUNT(f.flight_id) AS departing_flight_count
FROM airports ap
LEFT JOIN flights f ON ap.airport_id = f.origin_id
GROUP BY ap.airport_id, ap.airport_name, ap.airport_code;

-- Q23: Aircraft and flight linkage
SELECT 
    ac.aircraft_code, 
    ac.model, 
    f.flight_number
FROM aircrafts ac
LEFT JOIN flights f ON ac.aircraft_id = f.aircraft_id;

-- Q24: Right Join: Bookings and flights
SELECT 
    b.booking_id, 
    b.seat_number, 
    f.flight_number
FROM bookings b
RIGHT JOIN flights f ON b.flight_id = f.flight_id;

-- Q25: 3-Table Join: Passenger, Flight, Booking
SELECT 
    p.full_name, 
    f.flight_number, 
    b.seat_class, 
    f.departure_time, 
    b.booking_status
FROM bookings b
INNER JOIN passengers p ON b.passenger_id = p.passenger_id
INNER JOIN flights f ON b.flight_id = f.flight_id;

-- Q26: 5-Table Join: Full journey itinerary
SELECT 
    p.full_name, 
    f.flight_number, 
    orig.city AS origin_city, 
    dest.city AS destination_city, 
    b.amount_paid
FROM bookings b
INNER JOIN passengers p ON b.passenger_id = p.passenger_id
INNER JOIN flights f ON b.flight_id = f.flight_id
INNER JOIN airports orig ON f.origin_id = orig.airport_id
INNER JOIN airports dest ON f.destination_id = dest.airport_id;

-- Q27: 6-Table Join: Comprehensive itinerary summary
SELECT 
    p.full_name, 
    p.passport_no, 
    f.flight_number, 
    al.airline_name, 
    b.seat_number, 
    b.seat_class, 
    f.departure_time
FROM bookings b
INNER JOIN passengers p ON b.passenger_id = p.passenger_id
INNER JOIN flights f ON b.flight_id = f.flight_id
INNER JOIN airlines al ON f.airline_id = al.airline_id
INNER JOIN aircrafts ac ON f.aircraft_id = ac.aircraft_id
INNER JOIN airports orig ON f.origin_id = orig.airport_id;

-- Q28: Premium seat passengers
SELECT 
    p.full_name, 
    al.airline_name, 
    ac.model
FROM bookings b
INNER JOIN passengers p ON b.passenger_id = p.passenger_id
INNER JOIN flights f ON b.flight_id = f.flight_id
INNER JOIN airlines al ON f.airline_id = al.airline_id
INNER JOIN aircrafts ac ON f.aircraft_id = ac.aircraft_id
WHERE b.seat_class IN ('Business', 'First');

-- Q29: Delayed flights operational details
SELECT 
    f.flight_number, 
    al.airline_name, 
    ac.model, 
    orig.city AS origin_city, 
    dest.city AS destination_city
FROM flights f
INNER JOIN airlines al ON f.airline_id = al.airline_id
INNER JOIN aircrafts ac ON f.aircraft_id = ac.aircraft_id
INNER JOIN airports orig ON f.origin_id = orig.airport_id
INNER JOIN airports dest ON f.destination_id = dest.airport_id
WHERE f.status = 'Delayed';

-- Q30: Top originating airport
SELECT TOP 1
    ap.airport_name, 
    COUNT(b.booking_id) AS total_originating_bookings
FROM bookings b
INNER JOIN flights f ON b.flight_id = f.flight_id
INNER JOIN airports ap ON f.origin_id = ap.airport_id
GROUP BY ap.airport_id, ap.airport_name
ORDER BY total_originating_bookings DESC;

-- Q31: Self Join: Passengers sharing nationality
SELECT 
    p1.full_name AS passenger1_name, 
    p2.full_name AS passenger2_name, 
    p1.nationality
FROM passengers p1
INNER JOIN passengers p2 ON p1.nationality = p2.nationality AND p1.passenger_id < p2.passenger_id;

-- Q32: Self Join: Flights on same route
SELECT 
    f1.flight_number AS flight1, 
    f2.flight_number AS flight2, 
    orig.city AS origin_city, 
    dest.city AS destination_city
FROM flights f1
INNER JOIN flights f2 ON f1.origin_id = f2.origin_id 
                     AND f1.destination_id = f2.destination_id 
                     AND f1.flight_id < f2.flight_id
INNER JOIN airports orig ON f1.origin_id = orig.airport_id
INNER JOIN airports dest ON f1.destination_id = dest.airport_id;

-- Q33: Full Outer Join: Passengers and bookings
SELECT 
    p.passenger_id, 
    p.full_name, 
    b.booking_id, 
    b.flight_id, 
    b.booking_status
FROM passengers p
FULL OUTER JOIN bookings b ON p.passenger_id = b.passenger_id;

-- Q34: Cross Join: Airlines and seat classes
SELECT 
    al.airline_name, 
    sc.seat_class
FROM airlines al
CROSS JOIN (
    SELECT 'Economy' AS seat_class
    UNION ALL SELECT 'Business'
    UNION ALL SELECT 'First'
) sc;
GO



-- Q35: Total flights per airline
SELECT 
    al.airline_name, 
    COUNT(f.flight_id) AS total_flights
FROM airlines al
LEFT JOIN flights f ON al.airline_id = f.airline_id
GROUP BY al.airline_id, al.airline_name
ORDER BY total_flights DESC;

-- Q36: Total revenue per flight
SELECT 
    f.flight_number, 
    SUM(b.amount_paid) AS total_revenue
FROM flights f
INNER JOIN bookings b ON f.flight_id = b.flight_id
GROUP BY f.flight_id, f.flight_number
ORDER BY total_revenue DESC;

-- Q37: Bookings count by seat class
SELECT 
    seat_class, 
    COUNT(booking_id) AS booking_count
FROM bookings
GROUP BY seat_class;

-- Q38: Destinations with more than 10 flights
SELECT 
    destination_id, 
    COUNT(flight_id) AS arriving_flights_count
FROM flights
GROUP BY destination_id
HAVING COUNT(flight_id) > 10;

-- Q39: Airlines with fleet size greater than 5
SELECT 
    al.airline_name, 
    COUNT(ac.aircraft_id) AS aircraft_count
FROM airlines al
INNER JOIN aircrafts ac ON al.airline_id = ac.airline_id
GROUP BY al.airline_id, al.airline_name
HAVING COUNT(ac.aircraft_id) > 5;

-- Q40: Monthly booking trends
SELECT 
    DATEPART(YEAR, booking_date) AS booking_year, 
    DATEPART(MONTH, booking_date) AS booking_month, 
    COUNT(booking_id) AS booking_count
FROM bookings
GROUP BY DATEPART(YEAR, booking_date), DATEPART(MONTH, booking_date)
ORDER BY booking_year ASC, booking_month ASC;

-- Q41: Frequent flyers (more than 3 bookings)
SELECT 
    p.full_name, 
    COUNT(b.booking_id) AS total_bookings
FROM passengers p
INNER JOIN bookings b ON p.passenger_id = b.passenger_id
GROUP BY p.passenger_id, p.full_name
HAVING COUNT(b.booking_id) > 3
ORDER BY total_bookings DESC;

-- Q42: Flight count by operational status
SELECT 
    status, 
    COUNT(flight_id) AS flight_count
FROM flights
GROUP BY status;

-- Q43: Average revenue per seat class
SELECT 
    seat_class, 
    ROUND(AVG(amount_paid), 2) AS avg_amount
FROM bookings
GROUP BY seat_class;

-- Q44: Routes with high flight volume
SELECT 
    orig.airport_code AS origin_code, 
    dest.airport_code AS destination_code, 
    COUNT(f.flight_id) AS route_count
FROM flights f
INNER JOIN airports orig ON f.origin_id = orig.airport_id
INNER JOIN airports dest ON f.destination_id = dest.airport_id
GROUP BY f.origin_id, f.destination_id, orig.airport_code, dest.airport_code
HAVING COUNT(f.flight_id) > 2;
GO


-- Q45: Fare stats (Max, Min, Avg)
SELECT 
    MAX(fare) AS highest_fare, 
    MIN(fare) AS lowest_fare, 
    ROUND(AVG(fare), 2) AS average_fare
FROM flights;

-- Q46: Total revenue by airline
SELECT 
    al.airline_name, 
    SUM(b.amount_paid) AS total_revenue
FROM airlines al
INNER JOIN flights f ON al.airline_id = f.airline_id
INNER JOIN bookings b ON f.flight_id = b.flight_id
GROUP BY al.airline_id, al.airline_name;

-- Q47: Confirmed bookings by nationality
SELECT 
    p.nationality, 
    COUNT(b.booking_id) AS confirmed_bookings_count
FROM passengers p
INNER JOIN bookings b ON p.passenger_id = b.passenger_id
WHERE b.booking_status = 'Confirmed'
GROUP BY p.nationality;

-- Q48: Highest spending passenger
SELECT TOP 1
    p.full_name, 
    SUM(b.amount_paid) AS total_spent
FROM passengers p
INNER JOIN bookings b ON p.passenger_id = b.passenger_id
GROUP BY p.passenger_id, p.full_name
ORDER BY total_spent DESC;

-- Q49: Most used aircraft model
SELECT TOP 1
    ac.model, 
    COUNT(f.flight_id) AS flight_count
FROM aircrafts ac
INNER JOIN flights f ON ac.aircraft_id = f.aircraft_id
GROUP BY ac.model
ORDER BY flight_count DESC;

-- Q50: Comprehensive airline KPIs
SELECT 
    al.airline_name, 
    COUNT(DISTINCT f.flight_id) AS total_flights, 
    COUNT(DISTINCT b.passenger_id) AS total_passengers, 
    ISNULL(SUM(b.amount_paid), 0.00) AS total_revenue, 
    ROUND(AVG(f.fare), 2) AS avg_fare, 
    MAX(f.fare) AS max_fare
FROM airlines al
LEFT JOIN flights f ON al.airline_id = f.airline_id
LEFT JOIN bookings b ON f.flight_id = b.flight_id
GROUP BY al.airline_id, al.airline_name
ORDER BY total_revenue DESC;
GO