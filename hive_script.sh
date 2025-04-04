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
BEELINE_PASSWORD="1234"

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
        # NABIL: Añadir comandos aquí
        
        ;;
        
    -modify)
        echo "Ejecutando: Modificación de registro en la tabla PROFILE"
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=true -f modify.hql
        ;;
        
    -extract)
        echo "Ejecutando: Extracción de información con filtros a HDFS y sistema local"
        # ISMAIL: Añadir comandos aquí
        
        ;;
        
    -persistence)
        echo "Ejecutando: Creación de tablas EXTERNAL y carga de datos"
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=true -f persistence.hql
        ;;
        
    -partbuck)
        echo "Ejecutando: Creación de tablas con partición y bucketing"
        beeline -u "$BEELINE_CONNECTION" -n "$BEELINE_USER" -p "$BEELINE_PASSWORD" --verbose=true -f partbuck.hql
        ;;
        
    -views)
        echo "Ejecutando: Creación de vistas (incluyendo una materializada)"
        # NABIL: Añadir comandos aquí
        
        ;;
        
    *)
        echo "Error: Flag no reconocido: $1"
        echo "Uso: ./hive_script.sh [-moveData|-queries|-ingest|-modify|-extract|-persistence|-partbuck|-views]"
        exit 1
        ;;
esac

echo "Proceso completado para el flag $1"