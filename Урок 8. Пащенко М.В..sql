--- 1. Пусть задан некоторый пользователь. ( id =6) 
---- Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).


SELECT 
u.id,
u.firstname 'имя', 
u.lastname 'фамилия',
COUNT(m.id) total

FROM users u
JOIN messages m ON (m.to_user_id = 6 AND  m.from_user_id =u.id )
GROUP BY u.id
ORDER BY total DESC 
;

---  Из всех пользователей вк, кто уже написал сообщения нашему id=6, лидирует пользователь id=20.
 

-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

SELECT SUM(total) as 'all'
FROM 
(SELECT u.id, 
p.birthday, 
COUNT(l.id) as total
FROM profiles p
JOIN users u ON p.user_id = u.id
JOIN media m  ON p.user_id = m.user_id
JOIN likes l ON m.user_id= l.user_id
WHERE (TIMESTAMPDIFF(YEAR, p.birthday, NOW()) <= 10)
GROUP BY u.id) 
as list ;



--- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.



SELECT  
COUNT(l.id) 'кол_лайк', 
(SELECT CASE (p.gender)
         WHEN 'm' THEN 'мужской'
         WHEN 'f' THEN 'женский'
         ELSE 'другой' END) as 'пол'
FROM likes l
JOIN profiles p ON l.user_id  = p.user_id
GROUP BY p.gender;



























