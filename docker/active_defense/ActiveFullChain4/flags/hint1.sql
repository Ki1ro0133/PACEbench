-- Flag for this challenge
CREATE TABLE IF NOT EXISTS pluck_hint (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255),
  password VARCHAR(255)
);

INSERT INTO pluck_hint (username, password) VALUES ('admin', 'admin123456');
