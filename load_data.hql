-- Script para cargar datos en Hive usando RegexSerDe
-- Ajustado para manejar el separador literal "\t"

-- Crear tabla Actor
CREATE TABLE IF NOT EXISTS Actor (
  id_actor INT,
  nombre STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^\\\\t]*)\\\\t(.*)"
)
STORED AS TEXTFILE
TBLPROPERTIES(
  "skip.header.line.count"="1",
  "serialization.null.format"="NULL"
);

-- Cargar datos en tabla Actor
LOAD DATA LOCAL INPATH '/home/hadoop/comandos_practica_hive/tablas_mariadb_exportadas/Actor.txt'
OVERWRITE INTO TABLE Actor;

-- Crear tabla Contrato
CREATE TABLE IF NOT EXISTS Contrato (
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
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t(.*)"
)
STORED AS TEXTFILE
TBLPROPERTIES(
  "skip.header.line.count"="1",
  "serialization.null.format"="NULL"
);

-- Cargar datos en tabla Contrato
LOAD DATA LOCAL INPATH '/home/hadoop/comandos_practica_hive/tablas_mariadb_exportadas/Contrato.txt'
OVERWRITE INTO TABLE Contrato;

-- Crear tabla Genero
CREATE TABLE IF NOT EXISTS Genero (
  id_genero INT,
  nombre_genero STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^\\\\t]*)\\\\t(.*)"
)
STORED AS TEXTFILE
TBLPROPERTIES(
  "skip.header.line.count"="1",
  "serialization.null.format"="NULL"
);

-- Cargar datos en tabla Genero
LOAD DATA LOCAL INPATH '/home/hadoop/comandos_practica_hive/tablas_mariadb_exportadas/Genero.txt'
OVERWRITE INTO TABLE Genero;

-- Crear tabla Pelicula
CREATE TABLE IF NOT EXISTS Pelicula (
  id_pelicula INT,
  titulo STRING,
  director STRING,
  duracion INT,
  color INT,
  relacion_aspecto STRING,
  anio_estreno STRING,
  calificacion_edad STRING,
  pais_produccion STRING,
  idioma_vo STRING,
  presupuesto DECIMAL,
  ingresos_brutos DECIMAL,
  link_imdb STRING,
  palabras_clave_descripcion STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t(.*)"
)
STORED AS TEXTFILE
TBLPROPERTIES(
  "skip.header.line.count"="1",
  "serialization.null.format"="NULL"
);

-- Cargar datos en tabla Pelicula
LOAD DATA LOCAL INPATH '/home/hadoop/comandos_practica_hive/tablas_mariadb_exportadas/Pelicula.txt'
OVERWRITE INTO TABLE Pelicula;

-- Crear tabla Pelicula_Actor
CREATE TABLE IF NOT EXISTS Pelicula_Actor (
  id_pelicula INT,
  id_actor INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^\\\\t]*)\\\\t(.*)"
)
STORED AS TEXTFILE
TBLPROPERTIES(
  "skip.header.line.count"="1",
  "serialization.null.format"="NULL"
);

-- Cargar datos en tabla Pelicula_Actor
LOAD DATA LOCAL INPATH '/home/hadoop/comandos_practica_hive/tablas_mariadb_exportadas/Pelicula_Actor.txt'
OVERWRITE INTO TABLE Pelicula_Actor;

-- Crear tabla Pelicula_Genero
CREATE TABLE IF NOT EXISTS Pelicula_Genero (
  id_pelicula INT,
  id_genero INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^\\\\t]*)\\\\t(.*)"
)
STORED AS TEXTFILE
TBLPROPERTIES(
  "skip.header.line.count"="1",
  "serialization.null.format"="NULL"
);

-- Cargar datos en tabla Pelicula_Genero
LOAD DATA LOCAL INPATH '/home/hadoop/comandos_practica_hive/tablas_mariadb_exportadas/Pelicula_Genero.txt'
OVERWRITE INTO TABLE Pelicula_Genero;

-- Crear tabla Perfil
CREATE TABLE IF NOT EXISTS Perfil (
  id_perfil INT,
  id_usuario INT,
  nombre STRING,
  apellidos STRING,
  edad INT,
  telefono STRING,
  dni STRING,
  fecha_nacimiento DATE
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t(.*)"
)
STORED AS TEXTFILE
TBLPROPERTIES(
  "skip.header.line.count"="1",
  "serialization.null.format"="NULL"
);

-- Cargar datos en tabla Perfil
LOAD DATA LOCAL INPATH '/home/hadoop/comandos_practica_hive/tablas_mariadb_exportadas/Perfil.txt'
OVERWRITE INTO TABLE Perfil;

-- Crear tabla Producto
CREATE TABLE IF NOT EXISTS Producto (
  id_producto INT,
  tipo STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^\\\\t]*)\\\\t(.*)"
)
STORED AS TEXTFILE
TBLPROPERTIES(
  "skip.header.line.count"="1",
  "serialization.null.format"="NULL"
);

-- Cargar datos en tabla Producto
LOAD DATA LOCAL INPATH '/home/hadoop/comandos_practica_hive/tablas_mariadb_exportadas/Producto.txt'
OVERWRITE INTO TABLE Producto;

-- Crear tabla Usuario
CREATE TABLE IF NOT EXISTS Usuario (
  id_usuario INT,
  nickname STRING,
  contrasena STRING,
  email STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t(.*)"
)
STORED AS TEXTFILE
TBLPROPERTIES(
  "skip.header.line.count"="1",
  "serialization.null.format"="NULL"
);

-- Cargar datos en tabla Usuario
LOAD DATA LOCAL INPATH '/home/hadoop/comandos_practica_hive/tablas_mariadb_exportadas/Usuario.txt'
OVERWRITE INTO TABLE Usuario;

-- Crear tabla Visualizacion
CREATE TABLE IF NOT EXISTS Visualizacion (
  id_visualizacion INT,
  id_contrato INT,
  id_pelicula INT,
  fecha_visualizacion TIMESTAMP
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  "input.regex" = "([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t([^\\\\t]*)\\\\t(.*)"
)
STORED AS TEXTFILE
TBLPROPERTIES(
  "skip.header.line.count"="1",
  "serialization.null.format"="NULL"
);

-- Cargar datos en tabla Visualizacion
LOAD DATA LOCAL INPATH '/home/hadoop/comandos_practica_hive/tablas_mariadb_exportadas/Visualizacion.txt'
OVERWRITE INTO TABLE Visualizacion;