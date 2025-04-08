create database practica_hive_script;
use practica_hive_script;

CREATE TABLE Usuario (
    id_usuario INT,
    nickname STRING,
    contrasena STRING,
    email STRING
)
ROW FORMAT DELIMITED  
FIELDS TERMINATED BY '|'  
STORED AS TEXTFILE  
LOCATION '/practica_hive/mariadb_hive_script/MovieBind/Usuario';

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
LOCATION '/practica_hive/mariadb_hive_script/MovieBind/Perfil';

CREATE TABLE Genero (
    id_genero INT,
    nombre_genero STRING
)
ROW FORMAT DELIMITED  
FIELDS TERMINATED BY '|'  
STORED AS TEXTFILE  
LOCATION '/practica_hive/mariadb_hive_script/MovieBind/Genero';

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
LOCATION '/practica_hive/mariadb_hive_script/MovieBind/Pelicula';

CREATE TABLE Actor (
  id_actor INT,
  nombre STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive_script/MovieBind/Actor';

CREATE TABLE Pelicula_Actor (
  id_pelicula INT,
  id_actor INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive_script/MovieBind/Pelicula_Actor';

CREATE TABLE Producto (
  id_producto INT,
  tipo STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive_script/MovieBind/Producto';

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
LOCATION '/practica_hive/mariadb_hive_script/MovieBind/Contrato';

CREATE TABLE Visualizacion (
  id_visualizacion INT,
  id_contrato INT,
  id_pelicula INT,
  fecha_visualizacion TIMESTAMP
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/practica_hive/mariadb_hive_script/MovieBind/Visualizacion';