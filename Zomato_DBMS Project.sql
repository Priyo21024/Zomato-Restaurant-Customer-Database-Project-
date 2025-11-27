CREATE DATABASE zomato_db;
USE zomato_db;
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL,
    email VARCHAR(80) UNIQUE,
    phone VARCHAR(15),
    signup_date DATE,
    gender VARCHAR(10),
    dob DATE);
    CREATE TABLE Customer_Address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    address_line VARCHAR(120),
    city VARCHAR(40),
    state VARCHAR(40),
    pincode VARCHAR(10),
    address_type VARCHAR(20),
    added_on DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id));
    CREATE TABLE Restaurant (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(80),
    avg_rating DECIMAL(2,1),
    registration_date DATE,
    is_active BOOLEAN);
    CREATE TABLE Restaurant_Address (
    rest_address_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    address_line VARCHAR(120),
    city VARCHAR(40),
    state VARCHAR(40),
    pincode VARCHAR(10),
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id));
CREATE TABLE Cuisine (
    cuisine_id INT PRIMARY KEY AUTO_INCREMENT,
    cuisine_name VARCHAR(40) NOT NULL);
    CREATE TABLE Restaurant_Cuisine (
    rc_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    cuisine_id INT,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id),
    FOREIGN KEY (cuisine_id) REFERENCES Cuisine(cuisine_id));
    CREATE TABLE Menu_Item (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    item_name VARCHAR(100),
    description VARCHAR(200),
    price DECIMAL(7,2),
    category VARCHAR(40),
    veg_nonveg VARCHAR(10),
    availability_status BOOLEAN,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id));
    CREATE TABLE Delivery_Partner (
    delivery_partner_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60),
    phone VARCHAR(15),
    vehicle_number VARCHAR(20),
    rating DECIMAL(2,1));
    CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_method VARCHAR(20),
    payment_status VARCHAR(20),
    payment_time DATETIME,
    amount_paid DECIMAL(10,2));
  CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    restaurant_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10,2),
    payment_id INT,
    delivery_partner_id INT,
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id),
    FOREIGN KEY (payment_id) REFERENCES Payment(payment_id),
    FOREIGN KEY (delivery_partner_id) REFERENCES Delivery_Partner(delivery_partner_id));
  CREATE TABLE Order_Item (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_id INT,
    quantity INT,
    item_price DECIMAL(7,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Menu_Item(item_id));
CREATE TABLE Delivery_Status_History (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    status VARCHAR(30),
    updated_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id));
    CREATE TABLE Review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    restaurant_id INT,
    rating INT,
    review_text VARCHAR(200),
    review_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id));
INSERT INTO Customer (name, email, phone, signup_date, gender, dob) VALUES
('Priyotosh  Ganguly', 'priyo26@gmail.com', '9199216677', '2024-01-10', 'Male', '2001-05-26'),
('Piyush Mehta', 'piyush@example.com', '9988776655', '2024-02-14', 'Male', '1998-09-22'),
('Drishti Badoni', 'drishti@gmail.com', '9123456780', '2024-03-05', 'Female', '1993-12-02'),
('Devanshi Goel', 'devanshi@gmail.com', '9090909090', '2024-01-28', 'Female', '1999-03-18'),
('Ishita Soni', 'ishita@gmail.com', '8888777666', '2024-04-01', 'Female', '1990-07-30');
INSERT INTO Customer_Address (customer_id, address_line, city, state, pincode, address_type, added_on) VALUES
(1, 'A-22 Green Park', 'Delhi', 'Delhi', '110016', 'Home', '2024-01-11'),
(2, 'B-14 HSR Layout', 'Bengaluru', 'Karnataka', '560102', 'Home', '2024-02-15'),
(3, 'C-90 Bandra West', 'Mumbai', 'Maharashtra', '400050', 'Work', '2024-03-06'),
(4, 'D-12 Salt Lake', 'Kolkata', 'West Bengal', '700091', 'Home', '2024-01-29'),
(5, 'E-77 Banjara Hills', 'Hyderabad', 'Telangana', '500034', 'Home', '2024-04-02');
INSERT INTO Restaurant (name, phone, email, avg_rating, registration_date, is_active) VALUES
('Biryani Palace', '9000011111', 'contact@biryani.com', 4.2, '2023-12-10', TRUE),
('Pizza Hub', '9000022222', 'info@pizzahub.com', 4.5, '2024-01-15', TRUE),
('Tandoori Treat', '9000033333', 'hello@tandoori.com', 3.9, '2024-02-01', TRUE),
('Sushi World', '9000044444', 'support@sushiworld.com', 4.7, '2023-11-20', TRUE),
('Vegan Delights', '9000055555', 'eat@veganD.com', 4.1, '2024-03-03', TRUE);
INSERT INTO Restaurant_Address (restaurant_id, address_line, city, state, pincode, latitude, longitude) VALUES
(1, '12 MG Road', 'Bengaluru', 'Karnataka', '560001', 12.9716, 77.5946),
(2, '44 Linking Road', 'Mumbai', 'Maharashtra', '400054', 19.0760, 72.8777),
(3, '71 Park Street', 'Kolkata', 'West Bengal', '700016', 22.5726, 88.3639),
(4, '18 Connaught Place', 'Delhi', 'Delhi', '110001', 28.6139, 77.2090),
(5, '55 Jubilee Hills', 'Hyderabad', 'Telangana', '500033', 17.3850, 78.4867);
INSERT INTO Cuisine (cuisine_name) VALUES
('North Indian'),
('Chinese'),
('Italian'),
('Japanese'),
('Vegan');
INSERT INTO Restaurant_Cuisine (restaurant_id, cuisine_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 1),
(4, 4);
INSERT INTO Menu_Item (restaurant_id, item_name, description, price, category, veg_nonveg, availability_status) VALUES
(1, 'Hyderabadi Biryani', 'Spicy aromatic rice with chicken', 320.00, 'Main Course', 'Non-Veg', TRUE),
(2, 'Cheese Burst Pizza', 'Loaded cheese delight', 450.00, 'Main Course', 'Veg', TRUE),
(3, 'Paneer Tikka', 'Grilled paneer cubes', 250.00, 'Starter', 'Veg', TRUE),
(4, 'California Sushi Roll', 'Crab & avocado roll', 600.00, 'Main Course', 'Non-Veg', TRUE),
(5, 'Vegan Salad Bowl', 'Fresh organic salad', 280.00, 'Healthy', 'Veg', TRUE);
INSERT INTO Delivery_Partner (name, phone, vehicle_number, rating) VALUES
('Rohan Singh', '9111111111', 'KA05AB1234', 4.6),
('Manoj Kumar', '9222222222', 'MH02CD5678', 4.3),
('Suresh Nair', '9333333333', 'DL03EF9012', 4.1),
('Arjun Das', '9444444444', 'WB04GH3456', 4.7),
('Faizal Khan', '9555555555', 'TS05IJ7890', 4.4);
INSERT INTO Payment (payment_method, payment_status, payment_time, amount_paid) VALUES
('UPI', 'Success', '2024-04-01 12:30:00', 620.00),
('Card', 'Success', '2024-04-02 14:15:00', 450.00),
('UPI', 'Failed', '2024-04-03 18:22:00', 0.00),
('COD', 'Success', '2024-04-04 20:05:00', 280.00),
('UPI', 'Success', '2024-04-05 11:10:00', 320.00);
INSERT INTO Orders (customer_id, restaurant_id, order_date, total_amount, payment_id, delivery_partner_id, order_status) VALUES
(1, 1, '2024-04-01 12:25:00', 620.00, 1, 1, 'Delivered'),
(2, 2, '2024-04-02 14:10:00', 450.00, 2, 2, 'Delivered'),
(3, 3, '2024-04-03 18:20:00', 250.00, 3, 3, 'Cancelled'),
(4, 4, '2024-04-04 20:00:00', 600.00, 4, 4, 'Delivered'),
(5, 5, '2024-04-05 11:05:00', 320.00, 5, 5, 'Delivered');
INSERT INTO Order_Item (order_id, item_id, quantity, item_price) VALUES
(1, 1, 2, 320.00),
(2, 2, 1, 450.00),
(3, 3, 1, 250.00),
(4, 4, 1, 600.00),
(5, 5, 1, 320.00);
INSERT INTO Delivery_Status_History (order_id, status, updated_at) VALUES
(1, 'Picked Up', '2024-04-01 12:15:00'),
(1, 'Delivered', '2024-04-01 12:30:00'),
(2, 'Delivered', '2024-04-02 14:15:00'),
(4, 'Out for Delivery', '2024-04-04 19:45:00'),
(4, 'Delivered', '2024-04-04 20:05:00');
INSERT INTO Review (customer_id, restaurant_id, rating, review_text, review_date) VALUES
(1, 1, 5, 'Amazing biryani!', '2024-04-02'),
(2, 2, 4, 'Great pizza and delivery.', '2024-04-03'),
(3, 3, 3, 'Food was average.', '2024-04-04'),
(4, 4, 5, 'Loved the sushi!', '2024-04-05'),
(5, 5, 4, 'Healthy and tasty.', '2024-04-06');









    
    



