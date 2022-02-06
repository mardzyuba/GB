
DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;

USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users ( 
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(100),
    lastname VARCHAR(100) COMMENT 'Фамилия', 
    email VARCHAR(120) UNIQUE,
    password_hash VARCHAR(100),
    phone BIGINT UNSIGNED,
    INDEX users_lastname_firstname_idx(lastname, firstname)
);

ALTER TABLE users 
ADD COLUMN is_deleted bit DEFAULT 0;
    
  
   DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100)
);


ALTER TABLE `profiles` ADD CONSTRAINT fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON UPDATE CASCADE ON DELETE CASCADE;
  
   
   DROP TABLE IF EXISTS messages;
CREATE TABLE messages ( 
     id SERIAL PRIMARY KEY,
     from_user_id BIGINT UNSIGNED NOT NULL,
     to_user_id BIGINT UNSIGNED NOT NULL,
     body TEXT,
     created_at DATETIME DEFAULT NOW(),
     FOREIGN KEY (from_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
     FOREIGN KEY (to_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests ( 
   init_user_id BIGINT UNSIGNED NOT NULL,
     tar_user_id BIGINT UNSIGNED NOT NULL,
     `status` ENUM('requested', 'approved', 'declined', 'unfriended'),
     requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE NOW(),
	PRIMARY KEY(init_user_id,tar_user_id),
    FOREIGN KEY (init_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (tar_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);


      
      DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),
	admin_user_id BIGINT UNSIGNED,

	INDEX communities_name_idx(name),
	FOREIGN KEY (admin_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL
);

      
      DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
    user_id BIGINT UNSIGNED NOT NULL,
    community_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, community_id), 
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (community_id) REFERENCES communities(id) ON UPDATE CASCADE ON DELETE CASCADE
    );
   
   
  
   DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );
   
   
   
   
   DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED,
    user_id BIGINT UNSIGNED NOT NULL,
  	body TEXT,
    filename VARCHAR(255),
    `size` INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (media_type_id) REFERENCES media_types(id) ON UPDATE CASCADE ON DELETE SET NULL
    );

   
   
   
  DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
   FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
    );
   
  
   DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
	`id` SERIAL,
	`name` VARCHAR(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL,
  	PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
	id SERIAL PRIMARY KEY,
	`album_id` BIGINT unsigned NOT NULL,
	`media_id` BIGINT unsigned NOT NULL,
    FOREIGN KEY (album_id) REFERENCES photo_albums(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
);

ALTER TABLE `profiles` ADD CONSTRAINT fk_photo_id
    FOREIGN KEY (photo_id) REFERENCES photos(id)
    ON UPDATE CASCADE ON DELETE set NULL;
   

   
   
    DROP TABLE IF EXISTS `songs`;
CREATE TABLE `songs`(
   id SERIAL PRIMARY KEY,
   name_song VARCHAR(255) DEFAULT NULL,
   name_singer VARCHAR(255) DEFAULT NULL,
   text_song TEXT,
   value_song TIME
); 
 
   
   DROP TABLE IF EXISTS `music`;
CREATE TABLE `music` (
  user_id BIGINT UNSIGNED NOT NULL,
  song_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (user_id, song_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES songs(id) ON UPDATE CASCADE ON DELETE CASCADE
);
  
ALTER TABLE `songs` ADD INDEX name_song_singer_idx(name_song, name_singer);



-- 2)  

 DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` ( 
     id  SERIAL PRIMARY KEY,
    name VARCHAR(255) DEFAULT NULL, 
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE CASCADE
);



 -- 3) Записи, посты

DROP TABLE IF EXISTS `type_post`;
 CREATE TABLE `type_post` ( 
    id SERIAL PRIMARY KEY,
   user_id BIGINT UNSIGNED NOT NULL,
  communities_id BIGINT UNSIGNED DEFAULT NULL,
  name VARCHAR(255) DEFAULT NULL,
 body TEXT,
 media_id BIGINT UNSIGNED DEFAULT NULL,
 created_at DATETIME DEFAULT NOW(),
 updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY (media_id) REFERENCES media(id) ON UPDATE CASCADE ON DELETE SET NULL,
 FOREIGN KEY (communities_id) REFERENCES communities(id) ON UPDATE CASCADE ON DELETE SET NULL
  );


   -- 4)
 


 DROP TABLE IF EXISTS `pay_cards`;
 CREATE TABLE `pay_cards`( 
  id SERIAL PRIMARY KEY,
 user_id BIGINT UNSIGNED NOT NULL,
 number_card BIGINT UNSIGNED UNIQUE NOT NULL,
 firstname_user VARCHAR(255),
 lastname_user VARCHAR(255),
 created_at DATETIME DEFAULT NOW(),
 updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
 
 );
 
    DROP TABLE IF EXISTS `card_of_users`;
 CREATE TABLE `card_of_users` (  
 user_id BIGINT UNSIGNED NOT NULL,
 pay_cards_id BIGINT UNSIGNED NOT NULL,
 PRIMARY KEY(user_id, pay_cards_id ),
 FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY (pay_cards_id) REFERENCES pay_cards(id) ON UPDATE CASCADE ON DELETE CASCADE
 );
 




   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   