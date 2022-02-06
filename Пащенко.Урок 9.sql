-- Практическое задание по теме “Транзакции, переменные, представления”




-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.


use sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255), 
  birthday_at DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;


START TRANSACTION;
INSERT INTO sample.users (id,name,birthday_at) 
SELECT shop.users.id, shop.users.name, shop.users.birthday_at 
FROM shop.users 
WHERE (id = 1);
COMMIT;


-- Создайте представление, которое выводит название name товарной позиции 
-- из таблицы products и соответствующее название каталога name из таблицы catalogs.

Use shop;

CREATE OR REPLACE VIEW view_tovar
AS 
SELECT p.name as n1, c.name as n2
FROM products p 
LEFT JOIN catalogs c ON p.catalog_id = c.id


-- 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at.
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

DROP TABLE IF EXISTS tbl_4;
CREATE TABLE tbl_4 (
	created_at DATE
);

INSERT INTO tbl_4 VALUES
    ('2018-05-03'),
	('2018-05-11'),
	('2018-05-01'),
	('2018-04-18'),
	('2018-04-15'),
	('2018-04-11'),
	('2018-04-01'),
	('2018-03-01'),
	('2018-02-01'),
	('2018-01-01'),
	('2017-12-31');

-- Создала представление выборки, при помощи которого можно удалять устаревшие записи


CREATE OR REPLACE VIEW date_limit_5 AS 
SELECT created_at FROM tbl_4
		ORDER BY created_at DESC
		LIMIT 5;

	
-- выборка дат, не подходящих к посл 5ти записям
	
SELECT created_at AS date_1 
FROM tbl_4
WHERE created_at NOT IN 
( SELECT created_at FROM date_limit_5) ORDER BY created_at DESC;

--- Удаляем неподходящие записи 

DELETE FROM tbl_4
WHERE created_at NOT IN 
(SELECT created_at FROM date_limit_5) 
ORDER BY created_at DESC;

-- Итог
SELECT created_at FROM tbl_4 ORDER BY created_at DESC;





		
	
	
	-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".


DELIMITER //

CREATE FUNCTION hello ()
RETURNS TINYTEXT READS SQL DATA
BEGIN
	DECLARE HOUR INT;
	SET HOUR = HOUR(NOW());
	CASE
		WHEN HOUR BETWEEN 0 AND 5 THEN RETURN "Доброй ночи";
		WHEN HOUR BETWEEN 6 AND 11 THEN RETURN "Доброе утро";
		WHEN HOUR BETWEEN 12 AND 17 THEN RETURN "Добрый день";
		WHEN HOUR BETWEEN 18 AND 23 THEN RETURN "Добрый вечер";
	END CASE;
END//

DELIMITER ;

SELECT hello();





--  2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное
-- значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля
-- были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
  

-- Этот вариант для "Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля
-- были заполнены"

DROP TRIGGER IF EXISTS check_no_name_insert;

DELIMITER //

CREATE TRIGGER check_no_name_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL THEN
		SET NEW.name = 'NoName';
	END IF;
	IF NEW.description IS NULL THEN
		SET NEW.description = 'NoDesc';
	END IF;
END //
DELIMITER ;

INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, NULL, 1000 , 2); 

--- "При попытке присвоить полям NULL-значение необходимо отменить операцию", если намерено обновляют, чтобы поставит значение 'NULL'.

DROP TRIGGER IF EXISTS check_not_null_update;

DELIMITER //

CREATE TRIGGER check_not_null_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	IF(NEW.name IS NULL  
	AND  
	  NEW.description IS NULL) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'insert chanceled!value is null';
	END IF;
END //
DELIMITER ;

UPDATE products SET name= NULL, description= NULL, price= 1000, catalog_id= 2
WHERE id=1; -- Trigger

UPDATE products SET name= "Intel Core i5-740", description= NULL, price= 1000, catalog_id= 1
WHERE id=2; -- Ok

UPDATE products SET name= "Intel Core i5-740", description= "Процессор", price= 1000, catalog_id= 1
WHERE id=3; -- Ok


