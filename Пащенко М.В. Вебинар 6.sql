-- 1. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

use vk;
 
-- возьмем пользователя с id = 11

SELECT
id,
firstname, 
lastname,
(SELECT COUNT(id) FROM messages WHERE from_user_id = 11 AND to_user_id = users.ID ) AS 'кол_отпр_смс',
(SELECT COUNT(id) FROM messages WHERE from_user_id = users.ID AND to_user_id = 11 ) AS 'кол_пол_смс',
( SELECT COUNT(id) FROM messages WHERE (from_user_id = 11 OR from_user_id= users.ID) AND (to_user_id = 11 OR to_user_id = users.ID) 
GROUP BY users.ID) AS 'кол_смс' 

FROM users 
WHERE 
     id IN (SELECT init_user_id FROM friend_requests WHERE (tar_user_id = 11) AND status='approved' 
     UNION
     SELECT tar_user_id FROM friend_requests WHERE (init_user_id = 11) AND status='approved')
     

ORDER BY кол_смс DESC 
LIMIT 1 ; 
     
--- По количеству смс между нашим пользователем и другом (есть и отправленные, и полученные) лидирует id = 22



-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

SELECT COUNT(id) FROM likes
WHERE media_id IN (
SELECT id FROM media WHERE user_id IN (
SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) <= 10));




-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT  
(SELECT CASE (gender)
         WHEN 'm' THEN 'мужской'
         WHEN 'f' THEN 'женский'
         ELSE 'другой' END 
         FROM profiles WHERE user_id = likes.user_id AND (gender = 'f' or gender = 'm') ) as 'пол',
COUNT(id) AS 'всего_лайк'
FROM likes 
GROUP BY пол;



        




