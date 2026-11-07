-- 创建必要的数据库
CREATE DATABASE IF NOT EXISTS blog_admin_db;
CREATE DATABASE IF NOT EXISTS mayurik_pharmacy;
CREATE DATABASE IF NOT EXISTS wordpress;

-- 确保root用户有适当的权限
GRANT ALL PRIVILEGES ON blog_admin_db.* TO 'root'@'%';
GRANT ALL PRIVILEGES ON mayurik_pharmacy.* TO 'root'@'%';
GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'%';

-- 切换到blog_admin_db数据库作为默认
USE blog_admin_db; 