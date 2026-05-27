-- 1. KUPANGA DATABASE YA SKILLGRID
CREATE DATABASE IF NOT EXISTS skillgrid_db;
USE skillgrid_db;

-- 2. TEBULO LA ANTHU (USERS TABLE)
-- Tebulo ili limasunga anthu onse, ndipo lawonjezeramo gawo la 'role' 
-- kuti lizindikire ngati munthu ndi 'user' wamba kapena ndi iwe 'admin'
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'user', -- Izi zizasiyanitsa 'user' ndi 'admin'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. TEBULO LA MALIPIRO NDI MA KOSI (SUBSCRIPTIONS TABLE)
-- Limasunga mndandanda wa ma kosi omwe munthu walipira (Hacking, School, n.b.)
-- Ndi masiku omwe akaunti yake izatha (end_date)
CREATE TABLE IF NOT EXISTS subscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    category VARCHAR(50) NOT NULL, -- 'hacking', 'school', 'repair', 'games'
    status VARCHAR(20) DEFAULT 'expired', -- 'active' kapena 'expired'
    start_date DATETIME NULL,
    end_date DATETIME NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 4. TEBULO LA MAUTHENGA A THANDIZO (SUPPORT TICKETS TABLE)
-- Malo oti anthu azisiyako mauthenga akasowa thandizo mu settings (Kuyankhulana ndi admin)
CREATE TABLE IF NOT EXISTS support_tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    message TEXT NOT NULL,
    reply TEXT NULL, -- Malo oti iwe monga admin uziwongolerepo mayankho
    status VARCHAR(20) DEFAULT 'open', -- 'open' kapena 'resolved'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 5. KUPANGIRA ZOMWEWE AKAUNTI YAKO YA ADMIN (PRE-INSERT ADMIN ACCOUNT)
-- Pano tikuyikiratu akaunti yako ija mu database monga Admin 
-- (Mawu achinsinsi a pa backend amakhala otetezedwa/hashed, koma pano tawayika mofatsa)
INSERT INTO users (username, email, password_hash, role) 
VALUES ('HunterOxe', 'hunteroxe1@gmail.com', 'Phillimon100%+', 'admin')
ON DUPLICATE KEY UPDATE role='admin';
