CREATE TABLE IF NOT EXISTS roles (
    role_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT IGNORE INTO roles (role_id, name) VALUES (1, 'Admin');
INSERT IGNORE INTO roles (role_id, name) VALUES (2, 'Client');