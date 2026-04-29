CREATE TABLE IF NOT EXISTS roles (
    role_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT IGNORE INTO roles (role_id, name) VALUES (1, 'Admin');
INSERT IGNORE INTO roles (role_id, name) VALUES (2, 'Client');

CREATE TABLE IF NOT EXISTS travel_routes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    route_name VARCHAR(255) NOT NULL UNIQUE,
    departure_location VARCHAR(255) NOT NULL,
    arrival_location VARCHAR(255) NOT NULL,
    departure_time TIME NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    seats INT NOT NULL DEFAULT 50
);

INSERT IGNORE INTO travel_routes (route_name, departure_location, arrival_location, departure_time, price, seats)
VALUES
    ('Rota Salvador - Aracaju', 'Salvador', 'Aracaju', '07:30:00', 120.00, 50),
    ('Rota Recife - João Pessoa', 'Recife', 'João Pessoa', '08:00:00', 80.00, 50),
    ('Rota Fortaleza - Natal', 'Fortaleza', 'Natal', '10:00:00', 100.00, 50),
    ('Rota Teresina - São Luís', 'Teresina', 'São Luís', '06:00:00', 150.00, 50),
    ('Rota São Luís - Parnaíba', 'São Luís', 'Parnaíba', '07:30:00', 130.00, 50),
    ('Rota Parnaíba - Caxias', 'Parnaíba', 'Caxias', '09:00:00', 110.00, 50),
    ('Rota Caxias - Timon', 'Caxias', 'Timon', '12:00:00', 90.00, 50),
    ('Rota Timon - Teresina', 'Timon', 'Teresina', '14:30:00', 80.00, 50);

INSERT INTO users (user_id, email, name, phone, password)
SELECT 
    n + IFNULL((SELECT MAX(user_id) FROM users), 0),
    CONCAT('cliente', n, '@gmail.com'),
    CONCAT('Cliente ', n),
    LPAD(ABS(CRC32(CONCAT(n, NOW(), RAND()))) % 100000000000, 11, '0'),
    '123456'
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + d.N * 1000 + 1 AS n
    FROM 
    (SELECT 0 N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
    (SELECT 0 N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
    (SELECT 0 N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c,
    (SELECT 0 N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
     UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) d
) base
WHERE n <= 350000;