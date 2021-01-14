
CREATE DATABASE IF NOT EXISTS nnsay;

use nnsay;

DROP TABLE IF EXISTS orgs;
CREATE TABLE orgs (
 `id` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY `id`(`id`) USING BTREE
) ENGINE = INNODB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS subjects;
CREATE TABLE subjects (
 `id` INT(11) NOT NULL AUTO_INCREMENT,
 `org_id` INT(11) NOT NULL,
 INDEX `org_id` (`org_id`) USING BTREE,
 PRIMARY KEY `id`(`id`) USING BTREE,
 FOREIGN KEY `org_id`(`org_id`) REFERENCES orgs(`id`)
) ENGINE = INNODB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS projects;
CREATE TABLE projects (
 `id` INT(11) NOT NULL AUTO_INCREMENT,
 `org_id` INT(11) NOT NULL,
  INDEX `org_id` (`org_id`) USING BTREE,
 PRIMARY KEY `id`(`id`) USING BTREE,
 FOREIGN KEY `org_id`(`org_id`) REFERENCES orgs(`id`)
) ENGINE = INNODB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
 `id` INT(11) NOT NULL AUTO_INCREMENT,
 `org_id` INT(11) NOT NULL,
  INDEX `org_id` (`org_id`) USING BTREE,
 PRIMARY KEY `id`(`id`) USING BTREE,
 FOREIGN KEY `org_id`(`org_id`) REFERENCES orgs(`id`)
) ENGINE = INNODB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

DROP PROCEDURE IF EXISTS `add_orgs`;
CREATE PROCEDURE `add_orgs`(IN max_num INT(10))
BEGIN
    DECLARE i INT DEFAULT 0;
    SET autocommit=0;
    REPEAT
        SET i=i+1;
        INSERT INTO orgs(id) VALUES(i);
        UNTIL i = max_num
    END REPEAT;
    COMMIT;
END;

CALL add_orgs(1512);

DROP PROCEDURE IF EXISTS `add_subjects`;
CREATE PROCEDURE `add_subjects`(IN max_num INT(10))
BEGIN
    DECLARE i INT DEFAULT 0;
    SET autocommit=0;
    REPEAT
        SET i=i+1;
        INSERT INTO subjects(id, org_id) VALUES(i, 1);
        UNTIL i = max_num
    END REPEAT;
    COMMIT;
END;

CALL add_subjects(635);

DROP PROCEDURE IF EXISTS `add_projects`;
CREATE PROCEDURE `add_projects`(IN max_num INT(10))
BEGIN
    DECLARE i INT DEFAULT 0;
    SET autocommit=0;
    REPEAT
        SET i=i+1;
        INSERT INTO projects(id, org_id) VALUES(i, 1);
        UNTIL i = max_num
    END REPEAT;
    COMMIT;
END;


CALL add_projects(635);

DROP PROCEDURE IF EXISTS `add_users`;
CREATE PROCEDURE `add_users`(IN max_num INT(10))
BEGIN
    DECLARE i INT DEFAULT 0;
    SET autocommit=0;
    REPEAT
        SET i=i+1;
        INSERT INTO users(id, org_id) VALUES(i, 1);
        UNTIL i = max_num
    END REPEAT;
    COMMIT;
END;

CALL add_users(14);

