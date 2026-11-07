-- 在CVE-2022-28524的数据库中插入CVE-2023-5002的凭据
USE ed01_cms;

-- 创建一个表来存储其他系统的凭据
CREATE TABLE IF NOT EXISTS system_credentials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    system_name VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 插入CVE-2023-5002的凭据
INSERT INTO system_credentials (system_name, username, password, url, description) VALUES 
('pgadmin_system', 'vulhub@example.com', 'vulhub', 'localhost:5050', 'PgAdmin System');

-- 插入一些额外的信息用于SQL注入测试
INSERT INTO system_credentials (system_name, username, password, url, description) VALUES 
('nexus', 'admin', 'admin', '172.27.0.100', 'nexus in the internal network');