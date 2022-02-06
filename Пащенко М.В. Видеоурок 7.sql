

--- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.


   
INSERT INTO SHOP.ORDERS (user_id, created_at, updated_at) VALUES
(3,'1971-09-07 16:30:11','2006-07-13 04:11:37'),
(6,'2008-10-13 07:32:09','2018-09-12 10:55:37'),
(4,'2020-07-20 08:42:05','2014-01-04 09:41:42'),
(5,'1993-09-20 05:18:35','1991-07-13 00:48:06'),
(6,'1991-06-05 10:13:53','1989-09-20 17:25:15'),
(3,'2016-04-03 13:29:09','1984-10-30 13:38:17'),
(4,'1985-02-20 00:00:25','1972-05-12 01:58:37'),
(2,'1999-06-25 23:20:10','2000-02-06 11:37:36'),
(1,'2008-11-12 15:31:17','1996-03-25 18:11:18'),
(3,'2020-04-30 23:28:26','2020-05-22 22:56:52'),
(1,'2009-10-03 13:39:13','2003-10-21 06:46:32'),
(2,'2014-08-07 20:16:10','1995-02-24 02:20:08'),
(6,'1976-03-15 13:39:25','1977-09-06 10:58:33'),
(5,'2007-03-28 21:06:51','1986-12-05 12:42:53'),
(6,'2015-08-07 11:01:40','1984-10-25 07:24:11'),
(2,'1973-02-09 07:46:46','1985-09-30 11:16:08'),
(1,'1970-08-31 05:56:17','2019-02-20 19:34:18'),
(1,'2006-07-16 19:06:08','2018-10-27 02:28:44'),
(4,'2014-02-09 02:38:31','2012-03-10 02:15:20');



use shop;

SELECT 
u.name,
COUNT(*) as total
FROM 
users u
JOIN orders o ON u.id= o.user_id
GROUP BY u.id
ORDER BY total DESC;



--- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT
p.name,
c.name,
c.id
FROM products p 
JOIN catalogs c ON p.catalog_id= c.id;


SELECT
	p.name,
	p.price,
	c.name
FROM catalogs c
RIGHT JOIN
	products p ON c.id = p.catalog_id;
	




-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
--- Выведите список рейсов flights с русскими названиями городов.

DROP TABLE IF EXISTS flights ;
CREATE TABLE flights (
 id SERIAL PRIMARY KEY,
`from` VARCHAR(100),
`to` VARCHAR(100)
);
INSERT INTO flights (id, `from`, `to`) VALUES
(1,'moscow','omsk'),
(2,'novgorod','kazan'),
(3,'irkutsk','moscow'),
(4,'omsk','irkutsk'),
(5,'moscow','kazan');
 
ALTER TABLE flights ADD CONSTRAINT fk_label_1 FOREIGN KEY(`from`) REFERENCES cities(label);
ALTER TABLE flights ADD CONSTRAINT fk_label_2 FOREIGN KEY(`to`) REFERENCES cities(label);


DROP TABLE IF EXISTS cities ;
CREATE TABLE cities (
`label` VARCHAR(255),
`name` VARCHAR(255)
);
INSERT INTO cities ( `label`, `name`) VALUES
('moscow','Москва'),
('irkutsk','Иркутск'),
('novgorod','Новгород'),
('kazan','Казань'),
('omsk','Омск');


SELECT
	id f_id,
	(SELECT name FROM cities WHERE label = `from`)  `из`,
	(SELECT name FROM cities WHERE label = `to`) `в`
FROM
	flights
ORDER BY
	f_id;

-- JOIN
SELECT
	id f_id,
	c.name `from`,
	c.name `to`
	FROM flights f
	JOIN cities c ON (c.label = f.`from` OR c.label = f.`to`)
ORDER BY
	f_id;



























