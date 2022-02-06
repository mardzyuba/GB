-- пункт 1.
-- СУБД установлена, файл .my.cnf создан и размещен в директории mysql.server
-- Работает без запроса пароля.

-- Добавлен путь mysql в системную переменную Path.

-- пункт 2.

CREATE DATABASE example;

USE example;

CREATE TABLE users ( 
id INT PRIMARY KEY,
name VARCHAR(255)
);

-- пункт 3.

CREATE DATABASE sample;
-- создала БД, открыла командную строку, проверила наличие через show db.
-- далее, создала дамп по видеоуроку 2.
C:\Windows\system32>mysqldump  example > example.sql

-- развернула дамп в БД sample.
C:\Windows\system32>mysql sample < example.sql

-- проверила
mysql> use sample;
Database changed
mysql> show tables;
+------------------+
| Tables_in_sample |
+------------------+
| users            |
+------------------+
1 row in set (0.01 sec)



-- пункт 4.

mysql> use mysql;
Database changed
mysql> show tables;
+------------------------------------------------------+
| Tables_in_mysql                                      |
+------------------------------------------------------+
| columns_priv                                         |
| component                                            |
| db                                                   |
| default_roles                                        |
| engine_cost                                          |
| func                                                 |
| general_log                                          |
| global_grants                                        |
| gtid_executed                                        |
| help_category                                        |
| help_keyword                                         |
| help_relation                                        |
| help_topic                                           |
| innodb_index_stats                                   |
| innodb_table_stats                                   |
| password_history                                     |
| plugin                                               |
| procs_priv                                           |
| proxies_priv                                         |
| replication_asynchronous_connection_failover         |
| replication_asynchronous_connection_failover_managed |
| replication_group_configuration_version              |
| replication_group_member_actions                     |
| role_edges                                           |
| server_cost                                          |
| servers                                              |
| slave_master_info                                    |
| slave_relay_log_info                                 |
| slave_worker_info                                    |
| slow_log                                             |
| tables_priv                                          |
| time_zone                                            |
| time_zone_leap_second                                |
| time_zone_name                                       |
| time_zone_transition                                 |
| time_zone_transition_type                            |
| user                                                 |
+------------------------------------------------------+
37 rows in set (0.00 sec)

mysql> \q
Bye

C:\Windows\system32>mysqldump mysql help_keyword --where="1 limit 100" >100_help_keyword.sql

 Содержимое папки C:\Windows\system32

20.08.2021  14:10             3 679 100_help_keyword.sql

-- в чем отличие от предыдущей?
C:\Windows\system32>mysqldump --where="true limit 100" mysql help_keyword > 100_help_keyword.sql
