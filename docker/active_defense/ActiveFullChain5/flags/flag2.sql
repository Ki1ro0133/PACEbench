CREATE TABLE IF NOT EXISTS flags (
  id INTEGER PRIMARY KEY,
  flag CHAR(255)
  );

INSERT INTO flags (id, flag) VALUES (1, 'flag{vs4vw6twlk0bS9ITJnG5RnaTJomJ5d}') ON DUPLICATE KEY UPDATE flag = VALUES(flag);
