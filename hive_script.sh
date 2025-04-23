#!/bin/bash
# Verificar que se ha proporcionado un argumento
if [ $# -eq 0 ]; then
    echo "Error: Se requiere un flag como argumento"
    echo "Uso: ./hive_script.sh [-moveData|-queries|-ingest|-modify|-extract|-persistence|-partbuck|-views]"
    exit 1
fi

# Configuración de conexión a Beeline
BEELINE_CONNECTION="jdbc:hive2://localhost:10001/;transportMode=http;httpPath=cliservice"
BEELINE_USER="sqoop"
BEELINE_PASSWORD="pavilion+U"

case "$1" in
    -moveData)
        echo "Ejecutando: Pasar datos de MariaDB a Apache Hive pasando por HDFS"
        
        # Configuración de MariaDB
        DB_USER="sqoop"
        DB_PASS="pavilion+U"
        DB_NAME="MovieBind"
        EXPORT_DIR="/home/hadoop/comandos_practica_hive/tablas_mariadb_exportadas"
        
        # Asegurarse de que el directorio de exportación existe
        mkdir -p $EXPORT_DIR
        
        echo "1. Exportando tablas desde MariaDB a archivos de texto..."
        # Obtener lista de tablas
        TABLES=$(mysql -u$DB_USER -p$DB_PASS $DB_NAME -e "SHOW TABLES;" | grep -v "Tables_in")
        
        # Exportar cada tabla a un archivo de texto
        for TABLE in $TABLES
        do
          echo "▶ Exportando tabla $TABLE a $EXPORT_DIR/$TABLE.txt"
          
          # Exportar datos a archivo de texto delimitado por tabuladores
          mysql -u$DB_USER -p$DB_PASS $DB_NAME -e "SELECT * FROM $TABLE;" | sed 's/\t/\\t/g' > $EXPORT_DIR/$TABLE.txt
        
        done
        
        echo "2. Creando tablas en Hive y cargando datos desde archivos de texto..."
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=true -f load_data.hql
        
        echo "Exportación de MariaDB a Hive completada. Los datos están disponibles en Hive."
        ;;
        
    -queries)
        echo "Ejecutando: Consultas sobre la base de datos"
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=true -f queries.hql
        echo "Consultas ejecutadas correctamente."
        
        ;;
        
    -ingest)
    echo "Ejecutando: Ingestión de datos mediante Sqoop y Flume"
    
    echo "1. Importando tablas de MariaDB a HDFS mediante Sqoop..."
    sqoop import-all-tables \
      --connect "jdbc:mysql://localhost/MovieBind" \
      --username sqoop --password pavilion+U \
      --warehouse-dir /practica_hive/mariadb_hive_script/MovieBind \
      --fields-terminated-by '|' \
      --lines-terminated-by '\n'
    
    echo "2. Creando tablas en Hive y enlazando con datos en HDFS..."
    beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=true -f ingest.hql
    
    echo "Ingestión de datos completada."
    ;;
        
    -modify)
        echo "Ejecutando: Modificación de registro en la tabla PROFILE"
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=true -f modify.hql
        ;;
        
    -extract)
        echo "Ejecutando: Extracción de información con filtros a HDFS y sistema local"
        echo "▶ Creando directorio en HDFS..."
        hdfs dfs -mkdir -p /home/hadoop/practica_hive_filter/perfiles_mayores_30

        echo "▶ Ejecutando consulta Hive para perfiles con edad > 30..."
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=true -f extract.hql

        echo "▶ Archivos generados en HDFS:"
        hdfs dfs -ls /home/hadoop/practica_hive_filter/perfiles_mayores_30

        echo "▶ Mostrando contenido:"
        hdfs dfs -cat /home/hadoop/practica_hive_filter/perfiles_mayores_30/000000_0

        echo "▶ Creando carpeta local si no existe..."
        mkdir -p /home/hadoop/practica_hive_filter

        echo "▶ Copiando archivos desde HDFS al sistema de ficheros local..."
        hdfs dfs -get /home/hadoop/practica_hive_filter/perfiles_mayores_30 /home/hadoop/practica_hive_filter/

        echo "▶ Archivos en sistema local:"
        ls /home/hadoop/practica_hive_filter/perfiles_mayores_30/
        cat /home/hadoop/practica_hive_filter/perfiles_mayores_30/000000_0
        
        ;;
        
    -persistence)
        echo "Ejecutando: Creación de tablas EXTERNAL y carga de datos"
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=true -f persistence.hql
        ;;
        
    -partbuck)
        echo "Ejecutando: Creación de tablas con partición y bucketing"
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=true -f partbuck.hql

        echo "Tablas con partición y bucketing creadas y datos cargados correctamente."
        echo "Las tablas se han optimizado de la siguiente manera:"
        echo " - Usuario: Bucketing por id_usuario"
        echo " - Perfil: Particionado por edad y bucketing por id_usuario"
        echo " - Pelicula: Particionado por año de estreno y bucketing por director"
        echo " - Actor: Bucketing por id_actor"
        echo " - Pelicula_Actor y Pelicula_Genero: Bucketing por id_pelicula"
        echo " - Contrato: Particionado por país y año de contratación, bucketing por id_perfil"
        echo " - Visualizacion: Particionado por año y mes de visualización, bucketing por id_pelicula"
        ;;
        
    -views)
        echo "Ejecutando: Creación de vistas (incluyendo una materializada)"
        
        echo "1. Realizando inserciones de datos para las vistas..."
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=true -f views_insert.hql
        
        echo "2. Creando vistas..."
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=true -f views_create.hql
    
        echo "Vistas creadas correctamente:"
        echo " - historial_visualizacion_usuario: Historial de visualización de películas por usuario"
        echo " - top5_peliculas_por_idioma: Top 5 películas con más ingresos brutos por idioma"
        echo " - peliculas_multigenero: Películas que pertenecen a más de un género"
        echo " - usuarios_contrato_activo: Lista de usuarios con contrato activo"
        echo " - top3_generos_por_usuario: Top 3 géneros más vistos por cada usuario"
        echo " - top5_directores_por_peliculas: Top 5 directores que más películas han dirigido"
        echo " - top5_contratos_mas_largos: Top 5 contratos de más larga duración"
        echo " - top10_palabras_clave: Top 10 palabras clave más usadas en las películas"
        echo " - ingresos_por_director: Ingresos brutos generados por cada director"
        ;;
        
    *)
        echo "Error: Flag no reconocido: $1"
        echo "Uso: ./hive_script.sh [-moveData|-queries|-ingest|-modify|-extract|-persistence|-partbuck|-views]"
        exit 1
        ;;
esac

echo "Proceso completado para el flag $1"