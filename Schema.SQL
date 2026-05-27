-- Create Database for SkillGrid
CREATE DATABASE skillgrid_db;
USE skillgrid_db;

-- 1. USERS TABLE
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'user', -- 'user' or 'admin'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. SUBSCRIPTIONS TABLE
CREATE TABLE subscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    category VARCHAR(50) NOT NULL, -- 'hacking', 'school', 'repair' etc.
    status VARCHAR(20) DEFAULT 'expired', -- 'active' or 'expired'
    start_date DATETIME NULL,
    end_date DATETIME NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 3. SUPPORT TICKETS TABLE
CREATE TABLE support_tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    message TEXT NOT NULL,
    reply TEXT NULL,
    status VARCHAR(20) DEFAULT 'open', -- 'open' or 'resolved'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
