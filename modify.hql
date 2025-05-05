SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.support.concurrency=true;
SET hive.enforce.bucketing=true;
SET hive.exec.dynamic.partition=true;
SET hive.txn.manager=org.apache.hadoop.hive.ql.lockmgr.DbTxnManager;

CREATE DATABASE IF NOT EXISTS practica_hive;
USE practica_hive;

# Eliminar la tabla si existe
DROP TABLE IF EXISTS Perfil_txn;

# Crear la tabla transaccional
CREATE TABLE Perfil_txn (
  id_perfil INT,
  id_usuario INT,
  nombre STRING,
  apellidos STRING,
  edad INT,
  telefono STRING,
  dni STRING,
  fecha_nacimiento DATE
)
STORED AS ORC
TBLPROPERTIES ('transactional'='true');

# Insertar todos los registros de la tabla perfil
INSERT INTO Perfil_txn
SELECT * FROM perfil;

# Mostrar el perfil con la id_usuario = 1 insertado antes del update
SELECT * FROM Perfil_txn WHERE id_usuario = 1;

# Actualizar el usuario con ID 1
UPDATE Perfil_txn 
SET nombre = 'nombre_actualizado', 
    apellidos = 'apellido_prueba', 
    edad = 25, 
    telefono = '123456789', 
    dni = '12345678A', 
    fecha_nacimiento = '1998-01-01'
WHERE id_usuario = 1;

# Mostrar el registro actualizado para verificación
SELECT * FROM Perfil_txn WHERE id_usuario = 1;