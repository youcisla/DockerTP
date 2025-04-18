CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
CREATE TABLE IF NOT EXISTS test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data VARCHAR(255)
);
INSERT INTO test_table (data) VALUES ('Test Data 1'), ('Test Data 2');