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
        # NABIL: Añadir comandos aquí
        
        ;;
        
    -queries)
        echo "Ejecutando: Consultas sobre la base de datos"
        # ISMAIL: Añadir comandos aquí
        
        ;;
        
    -ingest)
    echo "Ejecutando: Ingestión de datos mediante Sqoop y Flume"
    
    echo "1. Importando tablas de MariaDB a HDFS mediante Sqoop..."
    sqoop import-all-tables \
      --connect "jdbc:mysql://localhost/MovieBind" \
      --username sqoop --password pavilion+U \
      --warehouse-dir /practica_hive/mariadb_hive/MovieBind \
      --fields-terminated-by '|' \
      --lines-terminated-by '\n'
    
    echo "2. Creando tablas en Hive y enlazando con datos en HDFS..."
    beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=false -f ingest.hql
    
    echo "Ingestión de datos completada."
    ;;
        
    -modify)
        echo "Ejecutando: Modificación de registro en la tabla PROFILE"
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=false -f modify.hql
        ;;
        
    -extract)
        echo "Ejecutando: Extracción de información con filtros a HDFS y sistema local"
        # ISMAIL: Añadir comandos aquí
        
        ;;
        
    -persistence)
        echo "Ejecutando: Creación de tablas EXTERNAL y carga de datos"
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=false -f persistence.hql
        ;;
        
    -partbuck)
        echo "Ejecutando: Creación de tablas con partición y bucketing"
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=false -f partbuck.hql

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
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=false -f views_insert.hql
        
        echo "2. Creando vistas..."
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=false -f views_create.hql
    
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