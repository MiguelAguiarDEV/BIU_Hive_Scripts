SET hive.auto.convert.join = false;
use practica_hive;

INSERT OVERWRITE DIRECTORY '/home/hadoop/practica_hive_filter/perfiles_mayores_30'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT * FROM perfil WHERE edad > 30;