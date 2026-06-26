DROP DATABASE IF EXISTS crunchy_food;
CREATE DATABASE crunchy_food;
USE crunchy_food;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    user_type ENUM('user','admin') DEFAULT 'user',
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    item_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    item_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    FOREIGN KEY (item_id)
        REFERENCES menu_items(item_id)
        ON DELETE CASCADE,

    INDEX(user_id),
    INDEX(item_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,

    status ENUM(
        'Pending',
        'Preparing',
        'Out for Delivery',
        'Delivered',
        'Cancelled'
    ) DEFAULT 'Pending',

    payment_method ENUM(
        'Cash on Delivery',
        'Online Payment'
    ) DEFAULT 'Cash on Delivery',

    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    INDEX(user_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,

    order_id INT NOT NULL,
    item_id INT NOT NULL,

    item_name VARCHAR(100) NOT NULL,

    item_price DECIMAL(10,2) NOT NULL,

    quantity INT NOT NULL,

    total_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    FOREIGN KEY (item_id)
        REFERENCES menu_items(item_id)
        ON DELETE CASCADE,

    INDEX(order_id),
    INDEX(item_id)
);