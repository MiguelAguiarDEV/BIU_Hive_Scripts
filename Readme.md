# MovieBind Hive Project

Este proyecto contiene scripts para gestionar un sistema de base de datos de películas llamado MovieBind usando Apache Hive, HDFS y MariaDB. Incluye operaciones de ingestión, consultas, extracción y optimización de datos.

## Estructura del Proyecto

- `hive_script.sh`: Script principal para ejecutar operaciones mediante flags.
- Archivos `.hql`: Scripts HiveQL para cada operación.

## Flags disponibles y su coherencia

### `-moveData`
- **Descripción:** Exporta todas las tablas de MariaDB (`MovieBind`) a archivos de texto y los importa a Hive.
- **Base de datos Hive:** `practica_hive`
- **Tablas:** Crea y carga todas las tablas principales (`Usuario`, `Perfil`, `Genero`, `Pelicula`, `Actor`, `Pelicula_Actor`, `Pelicula_Genero`, `Producto`, `Contrato`, `Visualizacion`).
- **Notas:** Usa `CREATE DATABASE IF NOT EXISTS practica_hive`.

### `-queries`
- **Descripción:** Ejecuta consultas de análisis y pruebas sobre la base de datos principal.
- **Base de datos Hive:** `practica_hive`
- **Tablas:** Usa todas las tablas principales.

### `-ingest`
- **Descripción:** Realiza ingestión de datos desde MariaDB a HDFS usando Sqoop y crea tablas en Hive enlazadas a los datos en HDFS.
- **Base de datos Hive:** `practica_hive_script`
- **Tablas:** Crea todas las tablas principales en formato TEXTFILE.
- **Notas:** Usa `CREATE DATABASE IF NOT EXISTS practica_hive_script`.

### `-modify`
- **Descripción:** Modifica registros en la tabla `Perfil` usando transacciones.
- **Base de datos Hive:** `practica_hive`
- **Tablas:** Crea y usa `Perfil_txn` (transaccional) y consulta/actualiza datos de `Perfil`.

### `-extract`
- **Descripción:** Extrae perfiles con edad > 30 a HDFS y al sistema local.
- **Base de datos Hive:** `practica_hive`
- **Tablas:** Usa `Perfil`.

### `-persistence`
- **Descripción:** Crea tablas EXTERNAL en Hive enlazadas a datos en HDFS.
- **Base de datos Hive:** `moviebind_external`
- **Tablas:** Crea todas las tablas principales como EXTERNAL.
- **Notas:** Usa `CREATE DATABASE IF NOT EXISTS moviebind_external`.

### `-partbuck`
- **Descripción:** Crea tablas optimizadas con particiones y bucketing para análisis eficiente.
- **Base de datos Hive:** `moviebind_partbuck` (creada si no existe)
- **Tablas:** Crea todas las tablas principales con particiones y/o bucketing. Los datos se copian desde `practica_hive`.
- **Notas:** Usa `CREATE DATABASE IF NOT EXISTS moviebind_partbuck` y requiere que `practica_hive` ya exista.

### `-views`
- **Descripción:** Inserta datos de ejemplo y crea vistas analíticas (incluyendo una materializada).
- **Base de datos Hive:** `practica_hive_script`
- **Tablas:** Usa las tablas principales y crea varias vistas para análisis.
- **Notas:** Usa `CREATE DATABASE IF NOT EXISTS practica_hive_script`.

## Notas de coherencia
- Todos los scripts crean la base de datos si no existe antes de usarla.
- Los nombres de tablas y bases de datos son consistentes entre scripts.
- Puedes ejecutar cualquier flag de forma independiente y el entorno se preparará automáticamente.

## Requisitos
- Apache Hadoop y HDFS
- Apache Hive
- Apache Sqoop
- Apache Flume
- MariaDB
- Beeline client

## Uso
```bash
./hive_script.sh [FLAG]
```
Donde `[FLAG]` es uno de los anteriores.

