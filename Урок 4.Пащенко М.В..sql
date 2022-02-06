-- Урок 4.

-- добавила
-- ALTER TABLE users 
-- ADD COLUMN is_deleted bit DEFAULT 0;
    
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Фамилия',
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` bigint(20) unsigned DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `users_lastname_firstname_idx` (`lastname`,`firstname`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `users` WRITE;
INSERT INTO `users` 
VALUES (1,'Issac','Hackett','daphnee.schultz@example.com','e620c68f89009dadbb4aca406ae3b0f247e32ecd',10187751,'\0'),
(2,'Mia','Hansen','amani.kovacek@example.net','cc78ed6b5698296fc259a1887103344d696d358b',10838360,'\0'),
(3,'Letitia','Hermann','schaefer.elias@example.org','143e512fca327d686aa850643d96731fb6b45bbe',10989955,'\0'),
(4,'Nedra','Bahringer','sally14@example.org','4552ca85bc8a1c76b22df74c1a69ff904929d80b',10220635,'\0'),
(5,'Lucy','Blanda','breanne.okuneva@example.net','f6bba2494d476b278f7f1436b24efafe1fa25282',10692611,''),
(6,'Asha','Kub','tevin77@example.net','ff925446baa9daa78b91a644670965cde7d7114e',10732910,''),
(7,'Jaquelin','Runte','cprohaska@example.org','c8c20126b07d169450f65eeb44c96aa582c0f275',11078101,'\0'),
(8,'Elenora','Parker','qgerhold@example.net','c2bff76f936561187916d3d0cbf974abd92f3f00',10708155,''),
(9,'Fermin','Kertzmann','ken.crona@example.org','98f5a9984020a2fab9b63b03d53ccd6386f58a2e',11065771,''),
(10,'Kariane','McLaughlin','helene63@example.com','9f46162356a440d07545f38362360aa299e7f21e',10104176,'\0'),
(11,'Sabryna','Weissnat','bwelch@example.com','17867ebe5924d26a93a136bc3b41a2509cde2714',10360012,''),
(12,'Angie','Emmerich','hirthe.patrick@example.net','fdc912a4218517ac5113bd14960dbcc08cce3140',10725180,''),
(13,'Elton','Mertz','wiza.kenya@example.org','fd4043bf29c016aaafdc9403e4b820ba81568fba',10815812,'\0'),
(14,'Patience','Fisher','fadel.pauline@example.com','50c020586419d2ee414968fd50137c3ac32fcbbe',10266371,'\0'),
(15,'Lelah','Heathcote','rau.thurman@example.net','317819ad5cdc4cc57c0e7e3f38c6f165a1adcfde',10599315,'\0'),
(16,'Sid','McGlynn','donnelly.tiana@example.com','df88eb2d7fb1ba5fb04a53ff75ad11d1a98ef224',10810733,'\0'),
(17,'Aylin','Barton','glenna.gerlach@example.net','67293febb15e1b5b00568be67a76e626d950ffce',10090965,'\0'),
(18,'America','Feil','beer.jenifer@example.com','4caf295b3d4ff493ab9302fd7273b8ca58e1c0db',11104343,''),
(19,'Sterling','Runte','eveline.keebler@example.net','15b3c952cd0da98382b0d5de331ffa171ced02eb',10612585,'\0'),
(20,'Bernita','Durgan','ithiel@example.com','31d7062d7e1d24edd4714edc898c846c09ab0da2',10313805,'\0'),
(21,'Arnulfo','Carter','loraine.larson@example.net','85b38dca480e3066ce03b421c53d44b597a78dbd',10548755,''),
(22,'Zander','Ritchie','donald.bode@example.org','47257a95005b14804e80a22f2136781b731fcafd',10991612,'\0'),
(23,'Mallie','Quitzon','dax.turcotte@example.org','842c65db6702fe6920493405586fe02a911c8068',10836722,'\0'),
(24,'Edmund','Walter','mateo.hauck@example.net','4091064cd326590465fc9ba2b9eb8152dd9e7684',10299350,'\0'),
(25,'Coby','Mitchell','hellen57@example.net','0630ac74a8440150b5a529d7589e16bad0a0bf24',10502978,'');
UNLOCK TABLES;


DROP TABLE IF EXISTS `friend_requests`;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','declined','unfriended') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requested_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `friend_requests` WRITE;
INSERT INTO `friend_requests`(initiator_user_id, target_user_id,status, requested_at, updated_at )  VALUES 
(1,11,'unfriended','1971-09-07 16:30:11','2006-07-13 04:11:37'),
(2,7,'declined','2008-10-13 07:32:09','2018-09-12 10:55:37'),
(3,14,'declined','2020-07-20 08:42:05','2014-01-04 09:41:42'),
(4,5,'unfriended','1975-04-26 23:00:02','1987-08-04 14:13:29'),
(5,19,'unfriended','1993-09-20 05:18:35','1991-07-13 00:48:06'),
(22,6,'approved','1991-06-05 10:13:53','1989-09-20 17:25:15'),
(8,7,'declined','2016-04-03 13:29:09','1984-10-30 13:38:17'),
(8,4,'approved','1985-02-20 00:00:25','1972-05-12 01:58:37'),
(13,9,'approved','1999-06-25 23:20:10','2000-02-06 11:37:36'),
(10,20,'approved','2008-11-12 15:31:17','1996-03-25 18:11:18'),
(18,11,'requested','2020-04-30 23:28:26','2020-05-22 22:56:52'),
(12,22,'unfriended','2009-10-03 13:39:13','2003-10-21 06:46:32'),
(13,23,'declined','2014-08-07 20:16:10','1995-02-24 02:20:08'),
(14,24,'approved','1976-03-15 13:39:25','1977-09-06 10:58:33'),
(15,25,'requested','2007-03-28 21:06:51','1986-12-05 12:42:53'),
(16,6,'unfriended','2015-08-07 11:01:40','1984-10-25 07:24:11'),
(17,7,'requested','1973-02-09 07:46:46','1985-09-30 11:16:08'),
(1,18,'unfriended','1970-08-31 05:56:17','2019-02-20 19:34:18'),
(19,9,'requested','2006-07-16 19:06:08','2018-10-27 02:28:44'),
(2,20,'approved','2014-02-09 02:38:31','2012-03-10 02:15:20'),
(3,21,'unfriended','2016-05-09 18:27:12','1998-05-17 05:22:23'),
(7,22,'unfriended','2013-08-03 04:08:19','2017-07-07 23:37:45'),
(9,23,'declined','1991-11-16 10:55:59','1997-07-31 11:46:37'),
(19,24,'approved','1999-04-29 00:35:23','2003-09-10 18:13:26'),
(25,2,'declined','2003-03-24 11:21:23','1989-09-09 23:25:27'),

(19,11,'requested','2020-03-09 07:46:46','2020-08-15 11:16:08'),
(11,17,'requested','2020-07-05 07:46:46','2020-07-10 11:16:08'),
(1,7,'requested','1973-02-09 07:46:46','1985-09-30 11:16:08'),
(10,18,'unfriended','1970-08-31 05:56:17','2019-02-20 19:34:18'),
(4,9,'requested','2006-07-16 19:06:08','2018-10-27 02:28:44'),
(21,20,'approved','2014-02-09 02:38:31','2012-03-10 02:15:20'),
(9,21,'unfriended','2016-05-09 18:27:12','1998-05-17 05:22:23'),
(2,22,'unfriended','2013-08-03 04:08:19','2017-07-07 23:37:45'),
(8,14,'approved','1985-02-20 00:00:25','1972-05-12 01:58:37'),
(6,9,'approved','1999-06-25 23:20:10','2000-02-06 11:37:36'),
(13,20,'approved','2008-11-12 15:31:17','1996-03-25 18:11:18'),
(18,12,'requested','2020-04-30 23:28:26','2020-05-22 22:56:52');

UNLOCK TABLES;




DROP TABLE IF EXISTS `communities`;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `communities_name_idx` (`name`),
  KEY `admin_user_id` (`admin_user_id`),
  CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `communities` WRITE;
INSERT INTO `communities` VALUES (1,'qui',1),(2,'rem',2),(3,'omnis',3),(4,'neque',4),(5,'et',5),(6,'in',6),(7,'et',7),(8,'ut',8),(9,'voluptatem',9),(10,'reiciendis',10),(11,'officia',11),(12,'sed',12),(13,'blanditiis',13),(14,'et',14),(15,'officia',15),(16,'quam',16),(17,'at',17),(18,'ipsam',18),(19,'pariatur',19),(20,'ipsam',20),(21,'nisi',21),(22,'et',22),(23,'omnis',23),(24,'dolorem',24),(25,'ut',25);
UNLOCK TABLES;



DROP TABLE IF EXISTS `users_communities`;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
LOCK TABLES `users_communities` WRITE;

INSERT INTO `users_communities` 
VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15),(16,16),(17,17),(18,18),(19,19),(20,20),(21,21),(22,22),(23,23),(24,24),(25,25);
UNLOCK TABLES;



DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `messages` WRITE;
INSERT INTO `messages`(from_user_id,to_user_id,body,created_at)  VALUES 
(11,24,'vitae purus gravida sagittis. Duis gravida. Praesent eu nulla','2021-07-01 21:23:03'),
(20,11,'eget','2021-06-09 15:30:08'),
(7,11,'magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum','2022-02-17 22:11:31'),
(11,22,'elementum purus, accumsan interdum libero','2020-12-14 17:09:25'),
(11,25,'dolor','2021-07-18 13:31:01'),
(15,13,'adipiscing elit. Etiam','2022-08-09 21:21:21'),
(22,11,'Praesent interdum ligula eu enim. Etiam imperdiet dictum magna.','2021-03-05 12:02:18'),
(3,17,'Quisque ac libero nec ligula consectetuer rhoncus.','2022-09-02 18:17:54'),
(22,11,'gravida sit amet, dapibus id, blandit at,','2022-05-26 21:01:11'),
(11,22,'enim mi tempor','2022-03-19 14:52:53'),
(14,20,'mollis. Integer tincidunt aliquam arcu. Aliquam ultrices','2022-08-16 07:31:09'),
(19,11,'vitae purus gravida sagittis. Duis gravida. Praesent eu nulla','2021-07-01 21:23:33'),
(20,6,'eget','2021-06-09 15:30:07'),
(7,12,'magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum','2022-02-17 22:11:51'),
(6,23,'elementum purus, accumsan interdum libero','2020-12-14 17:09:25'),
(11,25,'dolor','2021-07-18 13:31:01'),
(19,11,'adipiscing elit. Etiam','2022-08-09 21:21:21'),
(14,5,'Praesent interdum ligula eu enim. Etiam imperdiet dictum magna.','2021-03-05 12:02:18'),
(11,17,'Quisque ac libero nec ligula consectetuer rhoncus.','2022-09-02 18:17:54'),
(13,16,'gravida sit amet, dapibus id, blandit at,','2022-05-26 21:01:11'),
(17,11,'enim mi tempor','2022-03-19 14:52:53'),
(14,20, 'mollis. Integer tincidunt aliquam arcu. Aliquam ultrices','2022-08-16 07:31:09');


(1,1,1,'Id necessitatibus eos occaecati non dolore voluptatibus. Nihil assumenda recusandae iusto et qui blanditiis quos. Animi in dignissimos corrupti doloribus in assumenda sed. Autem repellat deserunt reiciendis cupiditate.','2015-06-12 00:03:53'),(2,2,2,'Adipisci et reiciendis sint eveniet blanditiis esse. Quis aliquid harum et sit. Voluptatem ab sint asperiores rerum molestiae. A repudiandae consequatur tempore consectetur iure omnis deserunt.','2007-12-01 09:06:36'),(3,3,3,'Molestias omnis perferendis velit aut sit odio impedit. Nisi et voluptas nihil et deleniti iusto. Quidem dolorem culpa et delectus eius. Voluptate dignissimos quia est placeat quos.','2004-08-29 07:03:29'),(4,4,4,'Omnis iure voluptatem praesentium temporibus excepturi eos sit distinctio. Similique ab vitae possimus reprehenderit et deleniti quia. Magni repudiandae rerum ullam voluptatem suscipit. Consequatur amet qui id.','1991-07-09 12:47:45'),(5,5,5,'Tempore totam provident corporis et voluptatem quis aspernatur minima. Quos voluptatem eveniet sed vel architecto ex optio nostrum. Accusamus facilis incidunt sed nihil ut.','1987-09-14 21:18:52'),(6,6,6,'Delectus enim ut est eius. Voluptatem dolores aut autem. Rerum omnis nam veritatis maxime eveniet sequi sint natus. Dolor corporis aut quo consequatur quia nostrum.','1990-04-11 00:02:02'),(7,7,7,'Sed et magni quis quod. Distinctio cumque ex esse quod consequuntur eum nulla. Sed ea ratione voluptas molestiae enim nobis.','1996-05-24 09:17:10'),(8,8,8,'Beatae autem repellendus quidem repellat. Sequi nesciunt inventore dignissimos at. Maiores sit quo dolore id similique quis quod laborum. Rerum laboriosam voluptates aperiam vel consequuntur veritatis odit.','1981-04-14 04:42:40'),(9,9,9,'Consequatur sunt iusto fuga quo expedita sunt optio. Et magnam aut id neque aliquam tenetur. Eveniet voluptatem corrupti excepturi omnis commodi quidem. Nam necessitatibus beatae ex et accusantium unde non et. Voluptas nostrum voluptatem dolores tempora iusto fugit.','2013-07-31 09:52:18'),
(10,10,10,'Velit molestiae vitae ut officia architecto. Suscipit reiciendis dignissimos optio quas assumenda dolore velit alias. Culpa eveniet mollitia officiis consequatur natus. Mollitia ut perferendis sit nobis voluptates sed ut.','1989-08-30 18:46:16'),(11,11,11,'Exercitationem in molestiae rerum est voluptas cum saepe. Delectus omnis eos dolorum dignissimos reprehenderit veniam quibusdam. Omnis dolor aperiam et id.','1991-11-29 11:57:31'),(12,12,12,'Sed quo nulla corrupti blanditiis aut blanditiis. Dolores sit possimus occaecati aut et harum adipisci. Amet voluptates deleniti sit harum molestias reiciendis. Quam quidem culpa veniam.','1977-06-10 02:10:30'),(13,13,13,'Et labore corrupti nihil laboriosam doloremque omnis atque nobis. Ut non perferendis placeat enim minus et sunt aut. Accusamus iste dolorem qui consequatur quisquam voluptate exercitationem.','1994-05-15 18:54:22'),
(14,14,14,'Laudantium incidunt deserunt molestias et magnam nostrum amet sunt. In earum ut cum quos ea sit.','1973-08-06 10:05:22'),
(15,15,15,'Consectetur consequuntur fugiat beatae hic impedit. Ut nihil ut temporibus nihil delectus provident labore. Est neque error quis expedita iusto.','1970-11-26 06:43:02'),(16,16,16,'Et ad odit nihil aliquid et. Cupiditate distinctio ratione velit repellat. Fugit aliquid ut animi molestiae dolores velit. Et nesciunt ratione molestias.','2021-08-07 08:28:21'),
(17,17,17,'Aut perferendis nostrum fugit pariatur velit eligendi. Pariatur voluptas numquam porro sapiente qui. Nemo tempore ut consequatur ut. Eos ullam iusto aut soluta.','1982-09-12 04:56:16'),(18,18,18,'Debitis quam in et animi. Aperiam totam dignissimos vitae. Est ut molestiae et optio.','1991-02-13 02:50:29'),(19,19,19,'A et architecto non harum. Atque pariatur aperiam animi voluptatem. Ipsum consequatur quisquam ad non repudiandae dolor error.','1976-09-18 04:26:09'),(20,20,20,'Iste at et ipsum officia natus aut illum. Esse possimus laudantium consectetur placeat minima. Aut blanditiis nam eos similique distinctio nobis non.','1979-06-27 05:50:34'),(21,21,21,'Rem quia exercitationem molestias omnis. Saepe voluptatum natus qui exercitationem qui. Voluptate voluptas laudantium suscipit accusamus natus.','2017-05-13 18:14:41'),(22,22,22,'Quo et voluptate ratione in quia. Odit dolorum est quos ipsam. Facilis inventore eum molestiae natus officia. Non assumenda et architecto omnis eaque voluptates esse.','1984-07-17 13:57:31'),(23,23,23,'Repudiandae quasi recusandae quia. Quibusdam officiis placeat nam corrupti molestiae et. Omnis cum voluptatem et sit.','2015-02-27 03:42:16'),(24,24,24,'Velit in tenetur molestiae est enim qui sint. Dolor repellendus et impedit non voluptatem.','2017-05-14 10:00:59'),(25,25,25,'Quisquam voluptatem eligendi reprehenderit. Consectetur dolor corrupti aut illo odio sunt non distinctio. Beatae dolores officia a architecto modi perspiciatis. Officiis aut perspiciatis molestiae amet mollitia harum voluptas. Voluptate similique quo ullam non aspernatur veritatis assumenda aperiam.','2016-07-28 01:23:12');
UNLOCK TABLES;


DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


LOCK TABLES `photo_albums` WRITE;
INSERT INTO `photo_albums` 
VALUES (1,'deleniti',1),(2,'dolor',2),(3,'tempore',3),
(4,'non',4),(5,'voluptatem',5),(6,'impedit',6),(7,'a',7),(8,'sit',8),(9,'odit',9),
(10,'quod',10),(11,'perspiciatis',11),(12,'ut',12),(13,'voluptatem',13),(14,'fuga',14),
(15,'fuga',15),(16,'exercitationem',16),(17,'veritatis',17),(18,'et',18),(19,'consequatur',19),
(20,'doloremque',20),(21,'sint',21),(22,'quia',22),(23,'eum',23),(24,'eos',24),(25,'dolorem',25),
(26,'quasi',1),(27,'dolore',2),(28,'consequatur',3),(29,'alias',4),(30,'eaque',5),(31,'et',6),
(32,'totam',7),(33,'voluptatem',8),(34,'vero',9),(35,'est',10),(36,'molestiae',11),(37,'corrupti',12),
(38,'temporibus',13),(39,'reiciendis',14),(40,'qui',15);
UNLOCK TABLES;


DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `photos` WRITE;
INSERT INTO `photos` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10),(11,11,11),(12,12,12),
(13,13,13),(14,14,14),(15,15,15),(16,16,16),(17,17,17),(18,18,18),(19,19,19),(20,20,20),(21,21,21),(22,22,22),(23,23,23),(24,24,24),
(25,25,25);
UNLOCK TABLES;



DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gender` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `hometown` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_photo_id` (`photo_id`),
  CONSTRAINT `fk_photo_id` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `profiles` WRITE;
INSERT INTO `profiles` VALUES (1,'f','1987-10-01',1,'1974-12-15 22:42:55','Vonton'),
(2,'m','1994-03-01',2,'2002-11-01 23:53:58','New Dominique'),(3,'f','2009-08-27',3,'2005-08-21 16:53:33','Parkerberg'),
(4,'m','1999-06-20',4,'1972-02-05 07:34:59','Katrineborough'),(5,'f','1993-09-03',5,'2006-10-12 14:32:23','South Daron'),
(6,'m','2017-08-25',6,'1982-12-05 03:57:55','Dachville'),(7,'f','2009-10-06',7,'2002-01-12 13:14:21','New Freida'),
(8,'f','2005-05-14',8,'2008-06-17 00:00:44','Lake Anabelleside'),(9,'f','1987-09-18',9,'2021-01-25 02:29:17','Port Violet'),
(10,'m','1987-06-28',10,'2007-01-12 17:38:42','West Aniyah'),(11,'f','2007-01-02',11,'2001-09-06 22:29:07','Thielstad'),
(12,'f','1977-11-14',12,'1985-12-03 07:05:01','South Margaretehaven'),(13,'m','1974-09-17',13,'2019-06-27 02:23:30','New Martinaton'),
(14,'f','1983-09-21',14,'1999-09-08 14:49:22','Wintheisershire'),(15,'m','2007-02-05',15,'1990-02-14 18:35:00','Summerchester'),
(16,'m','2013-07-21',16,'1984-06-02 14:21:15','West Emery'),(17,'f','2016-10-17',17,'2008-08-30 13:03:43','Kaneberg'),
(18,'m','1982-09-29',18,'1995-06-07 08:36:44','South Isom'),(19,'f','1992-02-19',19,'1980-08-19 06:01:15','Rebekahaven'),
(20,'f','1980-05-27',20,'2013-12-15 05:53:48','Leonardostad'),(21,'m','1981-11-07',21,'1972-01-16 13:56:51','Emmerichville'),
(22,'m','1981-01-02',22,'1988-04-12 18:01:44','Noemiville'),(23,'f','1998-09-11',23,'1983-12-23 14:11:21','Port Beatricemouth'),
(24,'f','2013-01-02',24,'2003-08-28 23:37:31','Ondrickafurt'),(25,'f','2009-11-08',25,'1984-12-15 21:12:17','East Fausto');
UNLOCK TABLES;



DROP TABLE IF EXISTS `media_types`;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `media_types` WRITE;
 
INSERT INTO media_types (name, CREATED_AT) VALUES 
	('Photo','2003-07-09 10:08:05'),
	('Music','2009-06-19 20:08:09'),
	('Video','1984-04-18 01:55:09'),
	('Post','2001-04-17 06:47:52');

UNLOCK TABLES;



DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `media` WRITE;
INSERT INTO `media` VALUES (1,1,1,'Quia nihil similique ut. Autem totam voluptas aut fuga voluptas. Repellat quos quisquam facilis voluptatum ullam sint nostrum.','quo',906,NULL,'2016-03-22 19:20:46','1971-03-21 11:29:22'),(2,2,2,'Nihil eum laborum repellendus recusandae nisi pariatur earum. Odio ducimus in esse rem nobis voluptatem illo. Impedit ratione culpa illum odit. Tempore maxime dicta quibusdam illum quisquam.','inventore',373,NULL,'2011-07-28 14:06:26','1987-04-16 02:41:38'),(3,3,3,'Debitis voluptates saepe inventore blanditiis enim omnis pariatur. Tenetur aut asperiores autem ut voluptates optio sunt.','sit',52,NULL,'2006-07-17 22:58:13','2013-12-06 23:44:56'),(4,4,4,'Qui delectus et maiores ipsum fugiat maxime ut. Beatae eos culpa illo odit corporis sit. Omnis exercitationem unde minus illo et.','provident',234,NULL,'1975-11-06 17:25:53','1994-08-12 17:52:36'),(5,5,5,'Sit in aperiam vitae amet laborum. Veritatis quia est aut libero quod.','veniam',839,NULL,'1975-07-11 16:40:39','1977-11-01 15:21:17'),(6,6,6,'Blanditiis laudantium autem officiis id fugit eligendi. Et vero recusandae est mollitia necessitatibus quo. Quia provident est iure soluta quo. Natus enim non perferendis dolor.','aut',998,NULL,'1991-11-01 21:45:06','1983-12-30 16:17:39'),(7,7,7,'Est aut soluta est qui sequi aut. Ducimus omnis eos facilis voluptas sint placeat. Ipsam inventore dolor molestias mollitia quo ut ipsa nulla. Porro fugit qui sit dolores dolore fugit. Est recusandae doloremque facere ut molestiae eius illum.','et',466,NULL,'1984-08-16 13:26:52','1975-10-24 03:52:08'),(8,8,8,'Reprehenderit unde aut perspiciatis voluptatem necessitatibus. Voluptas asperiores voluptates perspiciatis dicta facere rerum. Nihil a eos nobis numquam repellendus praesentium et. Doloremque corrupti voluptas illum at modi laboriosam sed.','consectetur',760,NULL,'1973-04-29 05:07:41','1998-01-21 00:24:28'),
(9,9,9,'Iure officiis enim aspernatur necessitatibus pariatur laborum consectetur. Qui velit est ipsa odit mollitia velit. Dolorum in veritatis quo architecto voluptatem iure. Minus reprehenderit et fugit velit quaerat.','fugit',941,NULL,'2001-05-19 18:55:03','2004-03-02 06:40:49'),
(10,10,10,'Ab ex id ut voluptatem. Aut aut laborum in rerum et. Non qui ea maxime corrupti. Qui ex aliquid nihil sed libero suscipit.','corrupti',823,NULL,'1977-11-08 16:22:21','1983-08-16 03:17:10'),(11,11,11,'Autem nobis iure repellat autem commodi quod culpa iste. Rem ipsa enim asperiores minima. Consequatur saepe nulla distinctio ut rem. Ipsum molestias quaerat nostrum itaque numquam.','fuga',606,NULL,'1984-11-28 11:33:20','2014-08-15 07:42:36'),(12,12,12,'Ducimus totam et est non qui quia omnis. Qui repellendus aut qui quas. Occaecati maiores excepturi quae minus quo enim. Nihil odit fuga id nulla.','unde',574,NULL,'1981-03-07 15:07:18','1986-11-22 21:05:59'),(13,13,13,'Nostrum error non illum eum perferendis vero eos. Voluptas magni atque ex numquam accusamus quos. Dignissimos doloremque dolore ullam dolorem sed illo. Et fuga laboriosam corrupti recusandae ipsa in.','sit',932,NULL,'1982-09-03 04:05:03','2000-08-30 10:07:43'),(14,14,14,'Adipisci totam magnam explicabo in. Sed aut itaque qui deleniti. Fugit repudiandae dolorem temporibus voluptates.','deleniti',896,NULL,'1996-04-12 12:45:49','1997-08-28 16:09:46'),(15,15,15,'Velit optio maxime tenetur voluptas rerum molestiae nihil odio. Aspernatur quasi soluta adipisci cupiditate voluptate delectus. Autem totam sed nobis omnis. Aut maiores incidunt saepe est. Id aut adipisci voluptates nihil aut facere autem dolor.','aut',332,NULL,'1971-05-01 11:25:32','1982-03-25 07:14:07'),(16,16,16,'Eos sit architecto saepe officia. Modi incidunt voluptatem fugit molestiae neque libero libero. Aut explicabo cumque sed pariatur dolor.','ut',884,NULL,'2011-09-06 06:00:59','2020-11-18 23:28:50'),(17,17,17,'Rerum voluptas aut laboriosam ut. Inventore sed tempora voluptates ad ducimus sit. Eos eaque repellendus saepe ullam aut velit. Culpa hic maxime temporibus commodi eligendi commodi.','debitis',923,NULL,'1990-06-04 19:39:25','1988-06-29 03:38:36'),
(18,18,18,'Dolor neque aut excepturi. Nemo doloribus velit hic quia. Eos sit qui aut ea sed explicabo excepturi. Molestias molestias ut beatae incidunt nihil sint.','qui',571,NULL,'1971-06-23 19:13:21','1976-11-05 11:02:47'),(19,19,19,'Dolores a qui illo quaerat fuga omnis. Est quam aut consequatur sapiente. Nostrum voluptatem in aut magni. Velit sed veniam dignissimos est. At numquam quibusdam odit vel laboriosam quaerat tenetur.','at',424,NULL,'2010-02-22 03:36:15','2000-11-07 04:53:27'),(20,20,20,'Ducimus neque iusto hic. Voluptatem qui dolorem quae quod error rem. Vitae vel animi culpa veniam est vero magnam. Aliquid repellendus et pariatur maxime dolores est.','quas',458,NULL,'1992-02-01 10:55:57','2015-01-12 20:31:52'),(21,21,21,'Saepe dolorem omnis rerum ipsum consequatur eaque est. Saepe modi aut reprehenderit necessitatibus non numquam maiores. Eius id sit maiores ratione reprehenderit voluptatem.','esse',904,NULL,'1998-01-31 06:38:22','1995-09-14 23:08:20'),(22,22,22,'Ullam dolores ex praesentium aut eius. Ipsum nulla quia quia id. Inventore laborum in consequatur cum eius perspiciatis.','consectetur',618,NULL,'1974-06-28 02:26:50','1991-02-14 05:46:27'),(23,23,23,'Sit et totam itaque vero perspiciatis. Sed voluptatem harum fugit sed. Eligendi labore incidunt suscipit. Facere adipisci animi optio.','laboriosam',970,NULL,'1972-06-18 16:26:25','1993-09-06 01:40:22'),(24,24,24,'Natus possimus hic nihil et temporibus cumque. Nobis voluptates voluptatem consequatur ut doloribus corrupti. Corporis vel amet ipsam ipsa voluptas repellendus.','harum',313,NULL,'2016-03-19 17:58:38','1993-10-18 16:04:20'),(25,25,25,'Cum porro sit enim possimus. Et omnis repellat omnis labore voluptates consectetur consequatur odio. Qui iure aliquid aliquid ipsam illum voluptates ut.','explicabo',530,NULL,'1994-07-18 11:46:59','2002-04-10 14:46:01');
UNLOCK TABLES;
 
INSERT INTO media (media_type_id,user_id,body,filename,`size`,metadata,created_at,updated_at) VALUES 
(28,1,' Consequuntur et velit aperiam error corporis rem corporis Odio magni atque dicta voluptatibus hic iste delectus.','a.avi',5,NULL,'1991-11-16 08:14:38.000','2019-06-19 18:11:58.000')
,(27,2,' Blanditiis dolorem et molestias veniam facere provident.','asperiores.mp4',4510,NULL,'1986-12-10 19:34:26.000','2019-06-19 18:11:58.000')
,(28,3,' Sed repudiandae voluptatem voluptatibus libero culpa quo.','sapiente.avi',763116,NULL,'1978-09-18 17:07:49.000','2019-06-19 18:11:58.000')
,(27,4,' In maiores velit nobis soluta molestias maiores tempora. Quisquam et ut et sequi.','rerum.mp4',740,NULL,'1984-10-21 04:41:15.000','2019-06-19 18:11:58.000')
,(27,5,'Dicta vel ut quibusdam cupiditate tempore.','user5-profile-image.mp4',40813,NULL,'2014-06-20 03:34:11.000','2019-06-19 18:11:58.000')
,(26,6,' Laudantium minima velit dolores eos voluptate nostrum.','quasi.jpg',119422,NULL,'1991-11-02 07:50:45.000','2019-06-19 18:11:58.000')
,(27,7,'Aliquam illum ut quo saepe ea unde est.','non.mp4',704558,NULL,'1988-09-17 20:56:38.000','2019-06-19 18:11:58.000')
,(27,8,'Et impedit deleniti eaque pariatur ut quia voluptatibus.','earum.mp4',65108,NULL,'1995-10-07 10:19:53.000','2019-06-19 18:11:58.000')
,(26,9,'Ea pariatur optio est ut.','ullam.jpg',83717449,NULL,'2003-08-05 05:55:25.000','2019-06-19 18:11:58.000')
,(26,10,'Facere nostrum facilis aperiam quisquam dolor. Minima omnis est nam.','maiores.jpg',75,NULL,'1984-05-17 07:37:30.000','2019-06-19 18:11:58.000')
,(27,12,'Eligendi et et rerum sequi ut.','non.mp4',0,NULL,'2010-05-07 19:13:09.000','2019-06-19 18:11:58.000')
,(26,11, 'Illum minus quidem temporibus porro.','earum.jpg',1826766,NULL,'2013-08-25 22:49:45.000','2019-06-19 18:11:58.000')
,(26,13,'Exercitationem delectus eaque necessitatibus.','hic.jpg',979,NULL,'2015-11-02 00:11:31.000','2019-06-19 18:11:58.000')
,(26,14,'Dolor mollitia fugiat officia nihil animi.','iste.jpg',18,NULL,'2006-05-11 12:11:06.000','2019-06-19 18:11:58.000')
,(26,15,'Tempora ad et aspernatur laborum ut dolor et. Exercitationem quaerat corporis placeat et.','quia.jpg',7,NULL,'2000-03-29 04:01:57.000','2019-06-19 18:11:58.000')
,(26,16,' Ullam laborum qui ut quo delectus temporibus.','omnis.jpg',2058670,NULL,'1971-10-08 06:43:32.000','2019-06-19 18:11:58.000')
,(26,17,' Nulla doloremque aut molestiae nam.','aperiam.jpg',3489253,NULL,'1973-12-19 09:20:43.000','2019-06-19 18:11:58.000')
,(26,18,' consequatur nesciunt voluptas magni rerum. Saepe quos qui doloremque.','commodi.jpg',8,NULL,'1989-03-01 17:19:42.000','2019-06-19 18:11:58.000')
,(26,19,' Et autem atque est minus veritatis explicabo eos.','id.jpg',1,NULL,'1970-11-04 03:06:33.000','2019-06-19 18:11:58.000')
,(26,20,'. Est deleniti asperiores temporibus perferendis est.','fugiat.jpg',82,NULL,'2017-06-08 03:23:04.000','2019-06-19 18:11:58.000')
INSERT INTO media (media_type_id,user_id,body,filename,`size`,metadata,created_at,updated_at) VALUES 
(26,18,'Consequatur eum at recusandae id tenetur voluptas amet.','ipsa.jpg',1,NULL,'1986-12-30 23:42:20.000','2019-06-19 18:11:58.000')
,(26,2,'Non quia dolorem reiciendis earum et officiis iure.','adipisci.jpg',4582,NULL,'2017-07-19 09:44:31.000','2019-06-19 18:11:58.000')
,(26,13,'Ipsum a sunt quis placeat.','qui.jpg',8302441,NULL,'1985-01-28 13:54:18.000','2019-06-19 18:11:58.000')
,(26,4,' Aut temporibus accusantium consectetur.','maxime.jpg',91764,NULL,'2006-08-07 15:24:03.000','2019-06-19 18:11:58.000')
,(26,6,'loremque est est incidunt.','qui.jpg',90944,NULL,'2000-11-07 15:35:46.000','2019-06-19 18:11:58.000')
,(28,10,'Inventore expedita distinctio omnis laborum laboriosam.','eveniet.avi',317340,NULL,'1999-07-10 01:22:03.000','2019-06-19 18:11:58.000')
,(28,7,'t ea vel.','incidunt.avi',0,NULL,'1996-06-24 05:20:00.000','2019-06-19 18:11:58.000')
,(26,21,' voluptas.','eaque.jpg',9525,NULL,'1973-07-27 14:27:31.000','2019-06-19 18:11:58.000')
,(26,2,' At quas nam sapiente porro nesciunt voluptatum.','non.jpg',20697427,NULL,'1999-02-12 16:23:02.000','2019-06-19 18:11:58.000')
,(27,3,'Provident quia fuga et consequatur reprehenderit repellat. Et aut cum nostrum ut beatae animi aut alias.','et.mp4',263408,NULL,'1977-02-20 10:38:19.000','2019-06-19 18:11:58.000')
;


DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `likes` WRITE;
INSERT INTO `likes` VALUES 
(1,1,1,'1980-08-30 16:02:50'),(2,2,2,'1973-08-24 09:10:53'),(3,3,3,'2006-08-15 04:41:10'),(4,4,4,'1970-02-23 01:01:43'),
(5,5,5,'2014-06-17 22:33:35'),(6,6,6,'1999-07-24 06:35:33'),(7,7,7,'2003-11-26 14:13:20'),(8,8,8,'2001-11-10 23:32:25'),
(9,9,9,'2006-08-31 01:29:17'),(10,10,10,'2020-09-16 12:31:14'),(11,11,11,'2006-07-29 07:28:22'),(12,12,12,'1982-07-16 11:41:11'),
(13,13,13,'1998-01-03 15:11:26'),(14,14,14,'2017-02-09 18:07:20'),(15,15,15,'1995-06-08 19:03:54'),(16,16,16,'1985-10-02 01:59:24'),
(17,17,17,'1977-06-11 19:26:02'),(18,18,18,'1979-10-26 00:48:30'),(19,19,19,'1971-03-06 15:14:50'),(20,20,20,'1989-06-11 15:55:17'),
(21,21,21,'2016-10-09 06:36:42'),(22,22,22,'2012-01-17 02:54:36'),(23,23,23,'2011-05-08 20:34:53'),(24,24,24,'2011-06-01 21:04:20'),
(25,25,25,'1998-09-11 22:05:44'),(26,1,1,'1984-06-07 02:06:08'),(27,2,2,'1986-02-14 02:49:02'),(28,3,3,'1997-08-08 10:29:38'),
(29,4,4,'1977-05-09 14:17:42'),(30,5,5,'1974-04-24 20:36:48'),(31,6,6,'2012-07-08 05:41:59'),(32,7,7,'2002-10-18 02:22:05'),
(33,8,8,'2009-11-06 17:35:27'),(34,9,9,'2012-03-19 12:37:27'),(35,10,10,'1996-08-01 02:48:47');
UNLOCK TABLES;
INSERT INTO `likes` VALUES 

INSERT INTO likes (user_id, media_id,created_at)  VALUES 
('1','26','1988-10-14 18:47:39'),
('2','27','1988-09-04 16:08:30'),
('3','28','1994-07-10 22:07:03'),
('4','29','1991-05-12 20:32:08'),
('22','30','1978-09-10 14:36:01'),
('6','31','1992-04-15 01:27:31'),
('7','32','2003-02-03 04:56:27'),
('8','33','2017-04-24 09:30:19'),
('9','34','1974-02-07 20:53:55'),
('10','35','1973-05-11 03:21:40'),
('11','36','2008-12-17 13:03:56'),
('12','37','1995-07-17 21:22:38'),
('13','38','1985-09-07 23:34:21'),
('14','39','1973-01-27 23:11:53'),
('15','40','1974-02-07 20:53:55'),
('16','41','1973-05-11 03:21:40'),
('5','42','2008-12-17 13:03:56'),
('17','43','1995-07-17 21:22:38'),
('21','44','1985-09-07 23:34:21'),
('18','45','1973-01-27 23:11:53'), 
('19','46','2009-02-07 20:53:55'),
('20','47','1973-05-11 03:21:40'),
('23','48','2008-12-17 13:03:56'),
('24','49','1995-07-17 21:22:38'),
('25','50','1985-09-07 23:34:21'),
('9','51','2005-01-27 23:11:53'),
('1','52','1988-10-14 18:47:39'),
('2','53','1988-09-04 16:08:30'),
('3','54','1994-07-10 22:07:03'),
('4','55','1991-05-12 20:32:08'),
('16','30','1978-09-10 14:36:01'),
('6','31','1992-04-15 01:27:31'),
('7','32','2003-02-03 04:56:27'),
('8','33','2017-04-24 09:30:19'),
('9','34','1974-02-07 20:53:55'),
('10','35','1973-05-11 03:21:40'),
('11','36','2008-12-17 13:03:56'),
('12','37','1995-07-17 21:22:38'),
('13','38','1985-09-07 23:34:21'),
('14','39','1973-01-27 23:11:53')
; 


DROP TABLE IF EXISTS `songs`;
CREATE TABLE `songs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name_song` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_singer` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_song` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_song` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name_song_singer_idx` (`name_song`,`name_singer`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `songs` WRITE;
INSERT INTO `songs` VALUES (1,'illum','Ms. Brionna Smith','Cupiditate est ut sequi reprehenderit. Omnis aut culpa iste reiciendis. Eum qui totam nam. Repudiandae eum ut voluptatem aut et modi iste dolorem.','16:22:43'),(2,'et','Mrs. Leanne McCullough','Quia vero quis ipsa quos facilis dignissimos. Consequatur facere suscipit corrupti ullam et. Quasi ut nulla deserunt.','14:20:04'),(3,'aut','Winfield Kirlin','Laborum et ratione numquam commodi consequatur distinctio. Nisi eius explicabo omnis. Id cumque quidem quaerat consequuntur.','08:36:46'),(4,'aliquid','Prof. Maurice Altenwerth','Voluptate neque cupiditate ut velit. Quia nostrum ex fugiat sint ut nobis corrupti qui. Placeat quibusdam sapiente deserunt id et.','07:12:35'),(5,'quis','Yadira Abbott III','Et reprehenderit id modi mollitia nisi. Ea assumenda molestias debitis vitae assumenda. Natus nemo eum veniam aut qui deleniti neque possimus.','13:13:37'),(6,'quam','Mitchel Cummings Sr.','Accusamus qui itaque exercitationem nihil quasi. Doloribus consequuntur aut enim alias ut quia dolore. Quaerat qui dolorem unde sunt est culpa.','04:11:09'),
(7,'aspernatur','Mr. Larry Rau','Ut voluptatem placeat iusto maxime et distinctio voluptate. Qui voluptas natus et. Earum accusamus quasi temporibus ipsam.','04:47:08'),(8,'et','Beryl Mante','Architecto deserunt fugit eum et et quis. Est animi sed tenetur qui. Veniam quas veniam dolores distinctio.','07:23:59'),(9,'ut','Ivory Klocko','Et doloremque cum aspernatur totam. Voluptate aspernatur dicta voluptatum quisquam consequuntur. Vero cum voluptas dolorem tempore.','22:09:58'),(10,'vitae','Conner Nader','Sed molestiae ut qui consequatur explicabo at. Enim sit qui similique quia libero laudantium.','07:57:24'),(11,'atque','Edmund Bergnaum','Quasi dolor itaque non officiis earum. Eveniet qui eum id ut. Aut quia aperiam maiores eligendi non sequi. Dolore mollitia error itaque sed dolores.','17:34:44'),
(12,'numquam','Miss Ottilie Schinner','Voluptates excepturi voluptas odit fuga tempore corrupti. Magni nesciunt harum saepe nisi illum omnis ex. Dolor veniam ea ut veritatis neque et sed.','20:34:57'),(13,'ut','Gage Blick','Qui qui animi voluptatem. Libero natus quasi reprehenderit voluptatem sed ex ex similique. Ut libero architecto minus explicabo id ipsam placeat.','02:56:20'),(14,'quis','Dr. Jerrold Pouros IV','Sit sit repellat enim error. Itaque optio quisquam aliquid voluptatem aut. Non et non eos laudantium enim natus repellat.','15:26:48'),(15,'ipsum','Mr. Ray Reichel','Est eos a facilis pariatur velit cupiditate. Velit molestias voluptatem non quia.','11:03:08'),(16,'facere','Alicia White','Explicabo laborum magni consectetur. Non aliquid fugiat natus incidunt qui suscipit est. Assumenda esse et modi a.','16:29:41'),(17,'et','Miss Maia Shields Jr.','Quaerat iure ut odit libero qui. Dolorem laborum praesentium dolore. Numquam vero corporis adipisci.','14:50:34'),(18,'quia','Annabel Cole','Aut laborum in reprehenderit voluptatem ut et ipsam mollitia. Ducimus distinctio aut incidunt tempore. Cum et molestiae facere corrupti ullam.','06:52:16'),
(19,'ex','Marlene Wintheiser','Tempore voluptatem quas delectus tenetur sint. Est non consequatur perspiciatis est et qui nostrum cum.','01:22:37'),(20,'quaerat','Walton Bogan','Reiciendis facere est enim quo tempora. Eligendi ut rerum libero ullam in iure dicta aut.','04:29:26'),(21,'suscipit','Idella Huels','Ut voluptas incidunt sapiente. Eum id esse suscipit voluptates quaerat. Earum eveniet qui earum ad. Libero tempore doloremque minus eius.','03:14:52'),(22,'fugit','Lamar Hegmann','Amet sint modi adipisci est. Perspiciatis sed reiciendis quod officia. Corporis alias recusandae consectetur repudiandae facere.','02:11:34'),(23,'nostrum','Emily Jacobi','Totam ut perferendis optio doloribus. Commodi repellendus sequi quia quia. Ratione sint dicta eum nobis. Fuga est dolor doloremque debitis.','08:42:15'),
(24,'provident','Ms. Rosemarie Stiedemann I','Expedita quia vitae quod nihil est. Eum modi facilis vel beatae.','04:29:49'),
(25,'dolorem','Lauryn Barton','Ut unde vitae omnis aliquid dolor nesciunt. Quis non repudiandae ducimus. Nihil ex eligendi corporis.','07:08:31');
UNLOCK TABLES;



DROP TABLE IF EXISTS `music`;
CREATE TABLE `music` (
  `user_id` bigint(20) unsigned NOT NULL,
  `song_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`song_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `music_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `music_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `music` WRITE;
INSERT INTO `music` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),
(14,14),(15,15),(16,16),(17,17),(18,18),(19,19),(20,20),(21,21),(22,22),(23,23),(24,24),(25,25);
UNLOCK TABLES;



DROP TABLE IF EXISTS `type_post`;
CREATE TABLE `type_post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `communities_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_id` (`media_id`),
  KEY `communities_id` (`communities_id`),
  CONSTRAINT `type_post_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `type_post_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `type_post_ibfk_3` FOREIGN KEY (`communities_id`) REFERENCES `communities` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `type_post` WRITE;
INSERT INTO `type_post` VALUES (1,1,1,'reiciendis','Quia ipsum autem doloremque similique. Non libero iure voluptatem qui. Qui rerum omnis voluptatibus vel.',1,'1981-07-09 01:51:05','2004-10-03 05:04:21'),(2,2,2,'vero','Voluptatum ut qui non tempore. Delectus quia dolore aliquam asperiores voluptatem voluptas cum. Ab possimus provident quo odio ut sit minima. Impedit est qui a incidunt minus occaecati.',2,'1979-08-16 13:36:56','1973-08-18 23:12:36'),(3,3,3,'nostrum','Id vel omnis in. Quis quibusdam est explicabo distinctio et. Et harum laboriosam officiis nam impedit rerum quia.',3,'1996-06-03 10:07:26','1997-02-15 16:03:05'),(4,4,4,'beatae','Porro necessitatibus enim quos. Voluptatibus aut id laborum iure nisi. Ut corporis soluta iste sed. Eum aut et sit.',4,'2012-03-10 14:34:39','2007-11-13 06:50:16'),(5,5,5,'amet','Debitis rerum provident consequuntur nemo vel. Vero deserunt quibusdam blanditiis saepe et nostrum. Consectetur corrupti ut voluptate aut.',5,'1997-06-17 11:49:20','1988-11-15 00:54:53'),(6,6,6,'ex','Ea esse et alias voluptates. Eos cum excepturi architecto molestias necessitatibus quia omnis quia. Sit itaque atque nam autem similique ea facilis ipsa. Inventore praesentium id nemo at voluptatibus tenetur.',6,'2007-01-13 18:02:01','2004-07-24 10:20:28'),(7,7,7,'asperiores','Sed magnam accusantium aspernatur natus esse. Doloribus temporibus magni molestiae inventore. Est qui consequatur et.',7,'2017-01-27 10:40:59','1979-03-16 09:52:13'),(8,8,8,'corporis','Pariatur officia est id est minus ex omnis. Blanditiis maiores officiis dolores nihil sunt et molestias. Ab aut beatae ipsam voluptatem in laudantium sit est. Molestias dolor qui enim voluptatem.',8,'2003-06-24 00:02:38','2014-07-07 21:38:59'),(9,9,9,'iusto','Ducimus soluta nihil officia vero in quis iusto. Optio eligendi sit aliquid cumque. Aspernatur voluptas voluptas aliquam quos labore facere eaque est. Dolor aut dolorem iure enim molestias tempora et non.',9,'2012-10-14 19:28:30','1984-02-06 19:09:30'),(10,10,10,'qui','Qui non et qui sit laudantium. Modi ipsam ad ut. Vitae quisquam nemo placeat perspiciatis labore.',10,'1996-07-01 23:29:47','1993-09-10 12:18:41'),(11,11,11,'non','Quia et sit quaerat hic in. Perspiciatis illo consequatur sed harum in quo qui. Itaque quaerat aut fugit eius iusto.',11,'2011-03-30 21:19:53','2021-04-13 18:59:57'),(12,12,12,'et','Sapiente tempore rerum ipsa est beatae repudiandae fuga consectetur. Aut ad quaerat non consequatur qui eos. Laboriosam voluptatem et fuga ipsam aut eum sapiente repellendus. Consectetur porro hic voluptatem velit mollitia voluptate.',12,'1987-12-16 01:09:19','2014-03-25 16:47:03'),(13,13,13,'accusamus','Enim quasi nihil nihil accusamus. Porro corporis et laboriosam. Qui et aspernatur voluptas dolores voluptatem provident. Totam reprehenderit culpa repellendus quis.',13,'1986-12-05 20:52:33','2010-09-27 05:00:10'),(14,14,14,'ipsa','Impedit quia voluptas alias impedit optio sunt. Id at omnis est mollitia ipsum. Minima et ullam sint autem. Deleniti impedit delectus voluptate.',14,'2020-01-16 22:25:25','1986-01-13 03:41:26'),(15,15,15,'enim','Mollitia ad sed et et maxime molestiae. Vel optio assumenda nemo quia. Vel velit sunt earum ad quibusdam.',15,'2000-12-25 19:05:40','2005-04-14 10:50:01'),
(16,16,16,'pariatur','Autem dolores nemo consequatur velit hic et. Aut at adipisci eius dignissimos optio sapiente. Eligendi quo deserunt repellendus alias provident. Voluptas aspernatur est error dolor ratione.',16,'2012-06-11 09:20:51','1975-09-14 18:56:21'),(17,17,17,'voluptatem','Quasi minima vitae voluptas esse vel quibusdam magni. Architecto et eius ducimus. Ut nulla reprehenderit dignissimos dicta. Odit nemo aut iure omnis et ex quasi.',17,'2013-04-17 03:46:14','2004-04-18 23:24:49'),(18,18,18,'aliquid','Impedit et rerum distinctio sed recusandae numquam numquam eos. Et fugiat voluptatem sed ab optio eum illo. Unde ut dolor aut sit eos totam illum.',18,'1996-04-09 03:03:02','1983-04-29 18:46:43'),(19,19,19,'qui','Sed qui sed odio autem et consequatur. Eos accusantium et molestias non omnis. Asperiores ut velit ut vero qui provident laboriosam.',19,'2003-10-07 16:18:21','1989-06-14 20:02:14'),(20,20,20,'explicabo','Asperiores ut quia quibusdam beatae corporis asperiores enim quae. Sit quia neque distinctio beatae hic consectetur culpa qui. Eum aperiam nostrum fuga nihil optio sint corporis.',20,'1974-07-13 10:05:44','1982-10-28 15:59:28'),(21,21,21,'sed','Vitae qui quo natus veniam id. Vero ad sed voluptates quae ab nam cum. Porro sed praesentium sequi tempore quod sed. Neque sed ex in quia dolor voluptas.',21,'1974-10-20 19:17:26','2020-09-19 18:12:38'),(22,22,22,'exercitationem','Aut mollitia odit nostrum omnis sapiente sint. Enim quam voluptas dolor fuga ratione. Perferendis cumque placeat sint itaque ea.',22,'2007-06-03 02:07:35','2002-08-19 20:50:17'),(23,23,23,'magni','Corrupti ea error est minima et. Vel quae at aut occaecati omnis.',23,'1989-12-24 22:49:23','1991-12-21 07:03:53'),(24,24,24,'numquam','Fugit voluptas voluptas in deleniti. Et vero eos magni eveniet nihil totam. Necessitatibus nostrum minima ex vel deserunt in laborum. Consequatur ut fuga tenetur totam tempora quisquam cupiditate.',24,'2020-06-26 15:37:01','2011-11-13 03:11:10'),(25,25,25,'quia','Necessitatibus quisquam vitae eligendi magnam. Assumenda blanditiis qui maxime quia explicabo. Sint dicta mollitia beatae ut iste alias et.',25,'1991-07-11 00:18:37','1981-09-19 09:33:23'),(26,1,1,'est','Debitis eos ea et dolor cumque id. Incidunt dolorem soluta quisquam animi eum. Ratione tempore rerum doloribus sequi ab quia sed. Distinctio autem quidem alias magni.',1,'1984-08-29 14:34:51','1977-07-25 06:21:03'),(27,2,2,'officia','Aut qui rerum ut impedit. Cum vel reprehenderit ipsa maxime recusandae voluptatem aut. Dicta nam exercitationem ut quae alias dignissimos eius.',2,'1986-01-11 22:31:35','1982-10-18 17:41:19'),(28,3,3,'est','Dolores libero nesciunt quia fuga commodi. Hic quam velit dolor nihil sint corporis. Dolorum nobis voluptates ut.',3,'1993-05-24 21:48:17','1989-10-29 11:12:08'),(29,4,4,'veritatis','Debitis provident aspernatur vitae tempora molestiae distinctio. Vitae eaque cupiditate dolorem illo dolor assumenda sequi. Quo et dolorem quis et ullam ut. Qui repudiandae dignissimos dolores minus non.',4,'2014-11-19 14:07:35','1973-09-22 03:50:17'),(30,5,5,'illo','Hic nihil eum voluptatem dolorum recusandae odio nam. Voluptatum possimus id nulla quasi. Quasi sunt iste eos aut. Corporis nemo perspiciatis officiis ratione eius.',5,'2004-08-16 16:22:36','1973-11-15 10:39:56'),
(31,6,6,'enim','Cum numquam maxime sed deserunt. Voluptas similique animi assumenda. Impedit maiores amet qui consequatur culpa culpa. Molestias voluptas numquam nemo quis.',6,'1974-08-31 20:03:07','1984-05-15 07:16:19'),(32,7,7,'eos','Enim rerum ut eum aut eum. Sint consequatur excepturi praesentium sed enim. Et pariatur ullam neque non.',7,'1973-01-08 10:01:07','1974-05-05 02:01:29'),(33,8,8,'eos','Cumque alias rem laborum quam. Tempore sit ut ut corporis. Laborum aut repellendus omnis consequatur. Sed aliquid voluptas perferendis.',8,'1975-03-04 08:49:31','1973-02-07 22:34:59'),(34,9,9,'qui','Eum repudiandae eaque sequi excepturi odio asperiores nihil. Dolorem voluptates quasi consequatur dolorem qui nobis quia.',9,'1977-09-02 06:16:53','1986-09-25 14:18:58'),(35,10,10,'optio','Distinctio nam inventore harum consequatur quia aspernatur est sit. Sit id perspiciatis quaerat dolores aspernatur consequuntur. Ut veritatis fugit omnis et non inventore molestiae asperiores.',10,'1990-06-07 06:34:35','2019-02-08 21:47:10'),(36,11,11,'est','Cupiditate quo amet inventore et repudiandae cumque. Dolores consequatur dolores eaque cumque facere exercitationem. Voluptatem aliquam accusantium sunt ducimus dolore natus.',11,'1991-09-26 21:20:19','1979-08-17 14:45:30'),(37,12,12,'doloremque','Voluptatem et illum ducimus recusandae fugiat sunt. Minus voluptate nobis sit perspiciatis laudantium unde. Omnis non quae accusantium ducimus esse nemo.',12,'2020-01-29 00:31:47','2003-11-06 01:06:39'),
(38,13,13,'ipsum','Eum veniam iure dignissimos culpa commodi. Iste omnis doloremque architecto ullam quasi id. Voluptate tempore rerum dignissimos saepe placeat.',13,'1975-08-31 21:15:58','1992-06-03 19:43:17'),(39,14,14,'qui','Animi iure error laudantium voluptatum enim qui iusto. Quis deserunt ea doloremque accusamus nemo vitae cupiditate. Quis qui maiores magnam tempore dolores ut voluptatum.',14,'2020-09-10 03:54:38','1974-03-27 14:42:33'),(40,15,15,'ut','Eos est molestias voluptate. Voluptates odio suscipit occaecati et. Cumque eligendi quia nisi rem ad. Perferendis eaque fugit eos et blanditiis est adipisci.',15,'1983-07-05 00:05:23','1989-03-15 19:07:52');

UNLOCK TABLES;



DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `video_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `video_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `video` WRITE;
INSERT INTO `video` VALUES (1,'text/x-uuencode',1,1),(2,'application/x-mie',2,2),(3,'video/vnd.dece.hd',3,3),
(4,'text/vnd.fmi.flexstor',4,4),(5,'model/vnd.vtu',5,5),(6,'application/mp4',6,6),(7,'text/x-sfv',7,7),(8,'text/vnd.wap.wmlscript',8,8),
(9,'image/x-xbitmap',9,9),(10,'text/vcard',10,10),(11,'application/vnd.lotus-approach',11,11),
(12,'application/vnd.oasis.opendocument.graphics',12,12),(13,'application/vnd.sus-calendar',13,13),
(14,'application/vnd.ms-powerpoint.template.macroenabled.12',14,14),(15,'text/vnd.sun.j2me.app-descriptor',15,15),
(16,'application/vnd.oasis.opendocument.text-web',16,16),(17,'application/x-ms-wmz',17,17),(18,'application/vnd.visionary',18,18),
(19,'video/x-ms-asf',19,19),(20,'application/vnd.dpgraph',20,20),(21,'application/vnd.recordare.musicxml',21,21),
(22,'application/vnd.rn-realmedia-vbr',22,22),(23,'audio/x-flac',23,23),(24,'text/troff',24,24),(25,'image/cgm',25,25);
UNLOCK TABLES;




DROP TABLE IF EXISTS `pay_cards`;
CREATE TABLE `pay_cards` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `number_card` bigint(20) unsigned NOT NULL,
  `firstname_user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname_user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `number_card` (`number_card`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `pay_cards_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `pay_cards` WRITE;
INSERT INTO `pay_cards` VALUES (1,1,5238721176396234,'Levi','Halvorson','1978-04-24 22:05:23','2005-12-27 22:29:41'),
(2,2,348313640618012,'Dustin','Leannon','1992-12-09 10:32:39','2006-11-15 00:13:42'),
(3,3,5429375955612537,'Novella','Daugherty','1989-08-05 23:53:20','2018-09-23 12:24:29'),
(4,4,5458843330361098,'Eldred','Koss','2008-04-09 22:52:39','1986-03-09 19:47:52'),
(5,5,4948684776554,'Felix','Reilly','1990-09-29 18:00:29','1983-07-10 17:30:11'),(6,6,4929160489970052,'Nyasia','Green','1976-11-14 15:27:17','2008-06-10 01:24:31'),(7,7,374125790860974,'Brenden','Jacobs','1979-06-01 05:35:40','1997-12-22 11:17:57'),(8,8,5265690037081985,'Casey','Cartwright','2000-04-23 07:05:23','2016-02-10 00:14:27'),(9,9,340862444510854,'Howell','Emard','1986-01-03 16:42:32','2014-10-21 23:15:41'),(10,10,4929545116574972,'Regan','Miller','1983-04-10 06:27:39','2005-11-26 13:30:16'),(11,11,4539404919670787,'Dashawn','Abbott','2014-05-10 08:40:47','1994-12-08 07:28:01'),(12,12,5293376941461546,'Cortney','Wintheiser','1989-01-31 23:07:48','1974-04-16 14:53:10'),(13,13,5539887713915414,'Murphy','Maggio','1974-04-04 05:27:58','2011-11-05 13:13:09'),
(14,14,4539693280178638,'Keara','Mosciski','2009-12-19 21:48:18','2016-09-29 14:32:23'),(15,15,6011916860701087,'Scarlett','Towne','2009-02-06 16:06:03','2016-08-20 06:36:51'),
(16,16,5390229175126081,'Cayla','Rodriguez','2020-02-18 00:49:01','1988-02-03 18:53:57'),(17,17,5118020143376845,'Hillary','Greenfelder','2002-06-27 07:35:49','1970-05-17 22:30:36'),(18,18,376890870684605,'Ricky','Renner','1972-12-11 01:59:21','1980-07-07 09:52:10'),(19,19,4485813407004599,'Brisa','Predovic','1986-10-03 14:04:46','1971-02-21 12:33:47'),(20,20,5431484309774105,'Eleazar','Herzog','1988-11-15 00:13:16','2001-11-02 19:23:17'),
(21,21,4532415315870,'Kayden','Hilpert','2010-11-08 05:21:54','2012-11-29 04:44:24'),(22,22,5121814112127229,'Tyreek','Vandervort','1989-05-08 14:01:19','2006-03-04 14:28:39'),(23,23,4929308476885,'Preston','Hirthe','1983-05-15 18:57:24','1992-03-08 05:16:25'),(24,24,4916954803452849,'Lorena','Nader','2004-12-10 11:23:45','2012-01-20 01:05:26'),(25,25,5281218888909125,'Asha','Senger','1977-11-23 14:02:05','1998-05-02 13:48:39');
UNLOCK TABLES;





DROP TABLE IF EXISTS `card_of_users`;
CREATE TABLE `card_of_users` (
  `user_id` bigint(20) unsigned NOT NULL,
  `pay_cards_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`pay_cards_id`),
  KEY `pay_cards_id` (`pay_cards_id`),
  CONSTRAINT `card_of_users_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `card_of_users_ibfk_2` FOREIGN KEY (`pay_cards_id`) REFERENCES `pay_cards` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `card_of_users` WRITE;
INSERT INTO `card_of_users` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),
(12,12),(13,13),(14,14),(15,15),(16,16),(17,17),(18,18),(19,19),(20,20),(21,21),(22,22),(23,23),(24,24),(25,25);
UNLOCK TABLES;



-- Задание 2.

SELECT DISTINCT firstname 
FROM users 
ORDER BY firstname;


-- Задание 3.

UPDATE users 
SET is_deleted = 1
LIMIT 5;

-- Задача 4.

-- Пример с датой, где год/месяц > текущей

INSERT INTO `messages` VALUES
(26,15,14,'Laudantium incidunt deserunt molestias et magnam nostrum amet sunt. In earum ut cum quos ea sit.','2021-12-06 10:05:22'),
(27,11,19,'Consectetur consequuntur fugiat beatae hic impedit. Ut nihil ut temporibus nihil delectus provident labore. Est neque error quis expedita iusto.','2027-11-26 06:43:02'),
(28,10,17,'Aut perferendis nostrum fugit pariatur velit eligendi. Pariatur voluptas numquam porro sapiente qui. Nemo tempore ut consequatur ut. Eos ullam iusto aut soluta.','2025-09-12 04:56:16');


DELETE FROM messages 
WHERE created_at > NOW();


