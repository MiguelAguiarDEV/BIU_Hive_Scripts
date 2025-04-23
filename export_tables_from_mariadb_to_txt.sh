#!/bin/bash

# Configuración de MariaDB
DB_USER="sqoop"
DB_PASS="pavilion+U"
DB_NAME="MovieBind"
EXPORT_DIR="/home/hadoop/comandos_practica_hive/tablas_mariadb_exportadas"

# Asegurarse de que el directorio de exportación existe
mkdir -p $EXPORT_DIR

# Obtener lista de tablas
TABLES=$(mysql -u$DB_USER -p$DB_PASS $DB_NAME -e "SHOW TABLES;" | grep -v "Tables_in")

# Exportar cada tabla a un archivo de texto
for TABLE in $TABLES
do
  echo "Exportando tabla $TABLE a $EXPORT_DIR/$TABLE.txt"
  
  # Exportar datos a archivo de texto delimitado por tabuladores
  mysql -u$DB_USER -p$DB_PASS $DB_NAME -e "SELECT * FROM $TABLE;" | sed 's/\t/\\t/g' > $EXPORT_DIR/$TABLE.txt

done

echo "Exportación completada. Los archivos están en $EXPORT_DIR"