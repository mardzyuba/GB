
-- 1. Создать таблицу logs типа Archive

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	name_table VARCHAR(50) NOT NULL,
	ind_id BIGINT(20) NOT NULL,
	name_value VARCHAR(150) NOT NULL
) ENGINE = ARCHIVE;


-- C помощью триггера, создадим спец. хранимые процедуры, привязанные к событию изменения (insert, в нашем случае) содержимого 
--- из заданных таблиц в logs(Archive)
DROP TRIGGER IF EXISTS log_users;
DELIMITER //

CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, name_table, ind_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //

DELIMITER ;


DROP TRIGGER IF EXISTS log_catalogs;
DELIMITER //

CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, name_table, ind_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //

DELIMITER ;

DROP TRIGGER IF EXISTS log_products;
DELIMITER //

CREATE TRIGGER log_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, name_table, ind_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //

DELIMITER ;




-- 2. Вставка в users 1млн записей


DROP PROCEDURE IF EXISTS insert_in_users1 ;
DELIMITER //
CREATE PROCEDURE insert_in_users1 ()
BEGIN
	DECLARE x INT DEFAULT 1000000;
	DECLARE y INT DEFAULT 0;
	WHILE x > 0 DO
		INSERT INTO users(name, birthday_at) VALUES (CONCAT('user',' ', y), NOW());
		SET y = y + 1;
		SET x = x - 1;
	END WHILE;
END //
DELIMITER ;

-- Второй вариант

DROP PROCEDURE IF EXISTS insert_in_users2 ;
DELIMITER //
CREATE PROCEDURE insert_in_users2 (IN num INT)
BEGIN
	DECLARE x INT; 
	SET x=0;
	loop_label: LOOP
		INSERT INTO users(name, birthday_at) VALUES (CONCAT('user',' ', x), NOW());
		SET x = x + 1;
	IF x>=num
	THEN 
	LEAVE loop_label
	END IF;
    END LOOP;
END //

DELIMITER ;

CALL insert_in_users2(1000000);
