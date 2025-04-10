CREATE DATABASE IF NOT EXISTS practica_hive;
USE practica_hive;

DROP TABLE IF EXISTS Usuario;
CREATE TABLE Usuario (
    id_usuario INT,
    nickname STRING,
    contrasena STRING,
    email STRING
)
ROW FORMAT DELIMITED  
FIELDS TERMINATED BY '|'  
STORED AS TEXTFILE  
LOCATION '/practica_hive/mariadb_hive/MovieBind/Usuario';

DROP TABLE IF EXISTS Perfil;
CREATE TABLE Perfil (
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

DROP TABLE IF EXISTS Genero;
CREATE TABLE Genero (
    id_genero INT,
    nombre_genero STRING
)
ROW FORMAT DELIMITED  
FIELDS TERMINATED BY '|'  
STORED AS TEXTFILE  
LOCATION '/practica_hive/mariadb_hive/MovieBind/Genero';

DROP TABLE IF EXISTS Pelicula;
CREATE TABLE Pelicula (
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

DROP TABLE IF EXISTS Pelicula_Genero;
CREATE TABLE Pelicula_Genero (
  id_pelicula INT,
  id_genero INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive/MovieBind/Pelicula_Genero';


DROP TABLE IF EXISTS Actor;
CREATE TABLE Actor (
  id_actor INT,
  nombre STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive/MovieBind/Actor';

DROP TABLE IF EXISTS Pelicula_Actor;
CREATE TABLE Pelicula_Actor (
  id_pelicula INT,
  id_actor INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive/MovieBind/Pelicula_Actor';

DROP TABLE IF EXISTS Producto;
CREATE TABLE Producto (
  id_producto INT,
  tipo STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive/MovieBind/Producto';

DROP TABLE IF EXISTS Contrato;
CREATE TABLE Contrato (
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

DROP TABLE IF EXISTS Visualizacion;
CREATE TABLE Visualizacion (
  id_visualizacion INT,
  id_contrato INT,
  id_pelicula INT,
  fecha_visualizacion TIMESTAMP
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive/MovieBind/Visualizacion';