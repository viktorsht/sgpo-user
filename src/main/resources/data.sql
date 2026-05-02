CREATE TABLE IF NOT EXISTS roles (
    role_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT IGNORE INTO roles (role_id, name) VALUES (1, 'Admin');
INSERT IGNORE INTO roles (role_id, name) VALUES (2, 'Client');

INSERT IGNORE INTO users (email, name, phone, password) VALUES
('cliente1@gmail.com', 'Cliente 1', '11999999991', '123456'),
('cliente2@gmail.com', 'Cliente 2', '11999999992', '123456'),
('cliente3@gmail.com', 'Cliente 3', '11999999993', '123456');