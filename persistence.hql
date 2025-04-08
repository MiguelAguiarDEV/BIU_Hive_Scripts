-- Script para la flag -persistence
-- Crear una base de datos específica para tablas externas
CREATE DATABASE IF NOT EXISTS moviebind_external;
USE moviebind_external;

-- Usuario - Tabla externa
CREATE EXTERNAL TABLE Usuario (
    id_usuario INT,
    nickname STRING,
    contrasena STRING,
    email STRING
)
ROW FORMAT DELIMITED  
FIELDS TERMINATED BY '|'  
STORED AS TEXTFILE  
LOCATION '/practica_hive/mariadb_hive/MovieBind/Usuario';

-- Perfil - Tabla externa
CREATE EXTERNAL TABLE Perfil (
    id_perfil INT,
    id_usuario INT,
    nombre STRING,
    apellidos STRING,
    edad INT,
    telefono STRING,
    dni STRING,
    fecha_nacimiento DATE
)
ROW FORMAT DELIMITED  
FIELDS TERMINATED BY '|'  
STORED AS TEXTFILE  
LOCATION '/practica_hive/mariadb_hive/MovieBind/Perfil';

-- Genero - Tabla externa
CREATE EXTERNAL TABLE Genero (
    id_genero INT,
    nombre_genero STRING
)
ROW FORMAT DELIMITED  
FIELDS TERMINATED BY '|'  
STORED AS TEXTFILE  
LOCATION '/practica_hive/mariadb_hive/MovieBind/Genero';

-- Pelicula - Tabla externa
CREATE EXTERNAL TABLE Pelicula (
  id_pelicula INT,
  titulo STRING,
  director STRING,
  duracion INT,
  color BOOLEAN,
  relacion_aspecto STRING,
  anio_estreno INT,
  calificacion_edad STRING,
  pais_produccion STRING,
  idioma_vo STRING,
  presupuesto DECIMAL(15,2),
  ingresos_brutos DECIMAL(15,2),
  link_imdb STRING,
  palabras_clave_descripcion STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive/MovieBind/Pelicula';

-- Actor - Tabla externa
CREATE EXTERNAL TABLE Actor (
  id_actor INT,
  nombre STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive/MovieBind/Actor';

-- Pelicula_Actor - Tabla externa
CREATE EXTERNAL TABLE Pelicula_Actor (
  id_pelicula INT,
  id_actor INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive/MovieBind/Pelicula_Actor';

-- Pelicula_Genero - Tabla externa
CREATE EXTERNAL TABLE Pelicula_Genero (
  id_pelicula INT,
  id_genero INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive/MovieBind/Pelicula_Genero';

-- Producto - Tabla externa
CREATE EXTERNAL TABLE Producto (
  id_producto INT,
  tipo STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive/MovieBind/Producto';

-- Contrato - Tabla externa
CREATE EXTERNAL TABLE Contrato (
  id_contrato INT,
  id_perfil INT,
  id_producto INT,
  direccion_postal STRING,
  ciudad STRING,
  codigo_postal STRING,
  pais STRING,
  fecha_contratacion DATE,
  fecha_fin DATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive/MovieBind/Contrato';

-- Visualizacion - Tabla externa
CREATE EXTERNAL TABLE Visualizacion (
  id_visualizacion INT,
  id_contrato INT,
  id_pelicula INT,
  fecha_visualizacion TIMESTAMP
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive/MovieBind/Visualizacion';

-- Verificación (opcional)
SELECT 'Usuario' AS tabla, COUNT(*) AS registros FROM moviebind_external.Usuario
UNION ALL
SELECT 'Perfil' AS tabla, COUNT(*) AS registros FROM moviebind_external.Perfil
UNION ALL
SELECT 'Genero' AS tabla, COUNT(*) AS registros FROM moviebind_external.Genero
UNION ALL
SELECT 'Pelicula' AS tabla, COUNT(*) AS registros FROM moviebind_external.Pelicula
UNION ALL
SELECT 'Actor' AS tabla, COUNT(*) AS registros FROM moviebind_external.Actor
UNION ALL
SELECT 'Pelicula_Actor' AS tabla, COUNT(*) AS registros FROM moviebind_external.Pelicula_Actor
UNION ALL
SELECT 'Pelicula_Genero' AS tabla, COUNT(*) AS registros FROM moviebind_external.Pelicula_Genero
UNION ALL
SELECT 'Producto' AS tabla, COUNT(*) AS registros FROM moviebind_external.Producto
UNION ALL
SELECT 'Contrato' AS tabla, COUNT(*) AS registros FROM moviebind_external.Contrato
UNION ALL
SELECT 'Visualizacion' AS tabla, COUNT(*) AS registros FROM moviebind_external.Visualizacion;

