-- Script para la flag -partbuck
-- Habilitar las configuraciones necesarias para bucketing y particiones
SET hive.enforce.bucketing = true;
SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.max.dynamic.partitions = 1000;
SET hive.exec.max.dynamic.partitions.pernode = 1000;

-- Crear una base de datos específica para tablas particionadas y con bucketing
CREATE DATABASE IF NOT EXISTS moviebind_partbuck;
USE moviebind_partbuck;

-- Usuario con bucketing (por id_usuario)
CREATE TABLE Usuario (
    id_usuario INT,
    nickname STRING,
    contrasena STRING,
    email STRING
)
CLUSTERED BY (id_usuario) INTO 4 BUCKETS
ROW FORMAT DELIMITED  
FIELDS TERMINATED BY '|'  
STORED AS ORC;

-- Perfil con partición por edad y bucketing por id_usuario
CREATE TABLE Perfil (
    id_perfil INT,
    id_usuario INT,
    nombre STRING,
    apellidos STRING,
    telefono STRING,
    dni STRING,
    fecha_nacimiento DATE
)
PARTITIONED BY (edad INT)
CLUSTERED BY (id_usuario) INTO 4 BUCKETS
ROW FORMAT DELIMITED  
FIELDS TERMINATED BY '|'  
STORED AS ORC;

-- Genero (tabla pequeña, no necesita partición ni bucketing)
CREATE TABLE Genero (
    id_genero INT,
    nombre_genero STRING
)
ROW FORMAT DELIMITED  
FIELDS TERMINATED BY '|'  
STORED AS ORC;

-- Pelicula con partición por año_estreno y bucketing por director
CREATE TABLE Pelicula (
  id_pelicula INT,
  titulo STRING,
  director STRING,
  duracion INT,
  color BOOLEAN,
  relacion_aspecto STRING,
  calificacion_edad STRING,
  pais_produccion STRING,
  idioma_vo STRING,
  presupuesto DECIMAL(15,2),
  ingresos_brutos DECIMAL(15,2),
  link_imdb STRING,
  palabras_clave_descripcion STRING
)
PARTITIONED BY (anio_estreno INT)
CLUSTERED BY (director) INTO 8 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS ORC;

-- Actor (tabla de dimensión)
CREATE TABLE Actor (
  id_actor INT,
  nombre STRING
)
CLUSTERED BY (id_actor) INTO 4 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS ORC;

-- Pelicula_Actor (tabla de hechos)
CREATE TABLE Pelicula_Actor (
  id_pelicula INT,
  id_actor INT
)
CLUSTERED BY (id_pelicula) INTO 8 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS ORC;

-- Pelicula_Genero (tabla de hechos)
CREATE TABLE Pelicula_Genero (
  id_pelicula INT,
  id_genero INT
)
CLUSTERED BY (id_pelicula) INTO 8 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS ORC;

-- Producto (tabla pequeña de dimensión)
CREATE TABLE Producto (
  id_producto INT,
  tipo STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS ORC;

-- Contrato con partición por país y año de contratación
CREATE TABLE Contrato (
  id_contrato INT,
  id_perfil INT,
  id_producto INT,
  direccion_postal STRING,
  ciudad STRING,
  codigo_postal STRING,
  fecha_contratacion DATE,
  fecha_fin DATE
)
PARTITIONED BY (pais STRING, anio_contratacion INT)
CLUSTERED BY (id_perfil) INTO 8 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS ORC;

-- Visualizacion con partición por año y mes de visualización
CREATE TABLE Visualizacion (
  id_visualizacion INT,
  id_contrato INT,
  id_pelicula INT,
  fecha_visualizacion TIMESTAMP
)
PARTITIONED BY (anio_visualizacion INT, mes_visualizacion INT)
CLUSTERED BY (id_pelicula) INTO 16 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS ORC;

-- Comandos para insertar datos desde las tablas originales a las tablas particionadas

-- Insertar datos en la tabla Usuario
INSERT INTO TABLE moviebind_partbuck.Usuario
SELECT * FROM practica_hive.Usuario;

-- Insertar datos en la tabla Perfil con partición
INSERT INTO TABLE moviebind_partbuck.Perfil PARTITION (edad)
SELECT id_perfil, id_usuario, nombre, apellidos, telefono, dni, fecha_nacimiento, edad
FROM practica_hive.Perfil;

-- Insertar datos en la tabla Genero
INSERT INTO TABLE moviebind_partbuck.Genero
SELECT * FROM practica_hive.Genero;

-- Insertar datos en la tabla Pelicula con partición
INSERT INTO TABLE moviebind_partbuck.Pelicula PARTITION (anio_estreno)
SELECT id_pelicula, titulo, director, duracion, color, relacion_aspecto, 
       calificacion_edad, pais_produccion, idioma_vo, presupuesto, 
       ingresos_brutos, link_imdb, palabras_clave_descripcion, anio_estreno
FROM practica_hive.Pelicula;

-- Insertar datos en la tabla Actor
INSERT INTO TABLE moviebind_partbuck.Actor
SELECT * FROM practica_hive.Actor;

-- Insertar datos en la tabla Pelicula_Actor
INSERT INTO TABLE moviebind_partbuck.Pelicula_Actor
SELECT * FROM practica_hive.Pelicula_Actor;

-- Insertar datos en la tabla Pelicula_Genero
INSERT INTO TABLE moviebind_partbuck.Pelicula_Genero
SELECT * FROM practica_hive.Pelicula_Genero;

-- Insertar datos en la tabla Producto
INSERT INTO TABLE moviebind_partbuck.Producto
SELECT * FROM practica_hive.Producto;

-- Insertar datos en la tabla Contrato con partición
INSERT INTO TABLE moviebind_partbuck.Contrato PARTITION (pais, anio_contratacion)
SELECT id_contrato, id_perfil, id_producto, direccion_postal, 
       ciudad, codigo_postal, fecha_contratacion, fecha_fin,
       pais, YEAR(fecha_contratacion) as anio_contratacion
FROM practica_hive.Contrato;

-- Insertar datos en la tabla Visualizacion con partición
INSERT INTO TABLE moviebind_partbuck.Visualizacion PARTITION (anio_visualizacion, mes_visualizacion)
SELECT id_visualizacion, id_contrato, id_pelicula, fecha_visualizacion,
       YEAR(fecha_visualizacion) as anio_visualizacion,
       MONTH(fecha_visualizacion) as mes_visualizacion
FROM practica_hive.Visualizacion;

-- Verificación (opcional)
SELECT 'Usuario' AS tabla, COUNT(*) AS registros FROM moviebind_partbuck.Usuario
UNION ALL
SELECT 'Perfil' AS tabla, COUNT(*) AS registros FROM moviebind_partbuck.Perfil
UNION ALL
SELECT 'Genero' AS tabla, COUNT(*) AS registros FROM moviebind_partbuck.Genero
UNION ALL
SELECT 'Pelicula' AS tabla, COUNT(*) AS registros FROM moviebind_partbuck.Pelicula
UNION ALL
SELECT 'Actor' AS tabla, COUNT(*) AS registros FROM moviebind_partbuck.Actor
UNION ALL
SELECT 'Pelicula_Actor' AS tabla, COUNT(*) AS registros FROM moviebind_partbuck.Pelicula_Actor
UNION ALL
SELECT 'Pelicula_Genero' AS tabla, COUNT(*) AS registros FROM moviebind_partbuck.Pelicula_Genero
UNION ALL
SELECT 'Producto' AS tabla, COUNT(*) AS registros FROM moviebind_partbuck.Producto
UNION ALL
SELECT 'Contrato' AS tabla, COUNT(*) AS registros FROM moviebind_partbuck.Contrato
UNION ALL
SELECT 'Visualizacion' AS tabla, COUNT(*) AS registros FROM moviebind_partbuck.Visualizacion;