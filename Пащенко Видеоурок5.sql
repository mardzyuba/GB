
-- N 1.
-- Практическое задание по теме 
-- «Операторы, фильтрация, сортировка и ограничение»

-- 1.УБРАЛА ЗНАЧЕНИЯ
UPDATE users SET created_at = NULL;
UPDATE users SET updated_at = NULL;
 
-- ЗАПОЛНИЛА ДАННЫМИ
UPDATE users 
SET created_at = NOW(),
updated_at = NOW()
; 

-- 2.Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

ALTER TABLE users ADD created_at_dt DATETIME, updated_at_dt DATETIME; -- добавила новые столбцы с нужным форматом

UPDATE users
SET created_at_dt = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'), --- функция протовоположная DATE_FORMAT(), из текста преобразует в дату, 
-- если имеется часть даты и времени
    updated_at_dt = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i');
   
ALTER TABLE users 
    DROP created_at, DROP updated_at, -- удаляем столбы с неправильным форматом
    RENAME COLUMN created_at_dt TO created_at, RENAME COLUMN updated_at_dt TO updated_at; -- переименовываем новые столбцы
    
    -- Также нашла решение через modify
    
    SELECT STR_TO_DATE(created_at, "%d.%m.%Y %k:%i") FROM users;
    UPDATE users SET created_at = STR_TO_DATE(created_at, "%d.%m.%Y %k:%i"); -- обновляем данные в соответствии с функцией
    ALTER TABLE users MODIFY created_at DATETIME; --- меняем  тип данных 

--- 3. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
--- Однако нулевые запасы должны выводиться в конце, после всех записей.

SELECT value FROM storehouses_products 
ORDER BY 
IF(value > 0, 0, 1), VALUE; 

--- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
--- Месяцы заданы в виде списка английских названий (may, august)

SELECT name, DATE_FORMAT(BIRTHDAY_AT, '%M')  AS BIRTHDAY_AT 
FROM users
where
MONTHNAME(BIRTHDAY_AT) = 'May'
OR 
MONTHNAME(BIRTHDAY_AT) = 'August' ;

--- 5.Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.


SELECT id, name FROM catalogs WHERE id IN (5, 1, 2) 
ORDER BY FIELD(id, 5, 1, 2) ;



-- N 2.Практическое задание теме «Агрегация данных»

-- 1. Подсчитайте средний возраст пользователей в таблице users.

SELECT ROUND(
AVG((TO_DAYS(NOW()) - TO_DAYS(birthday_at)) / 365.25) ) 
AS avg_age
FROM users;

-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
COUNT(*) AS total FROM users GROUP BY day ORDER BY total;

-- 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.

DROP TABLE IF EXISTS number_of_lesson;
CREATE TABLE number_of_lesson(
    value SERIAL PRIMARY KEY
);

INSERT INTO number_of_lesson VALUES
    (1),
    (2),
    (3),
    (4),
    (5);

SELECT ROUND(exp(SUM(log(value))), 0) AS 'произведение' FROM number_of_lesson;


