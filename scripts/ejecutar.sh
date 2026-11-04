#!/usr/bin/env bash
# ==============================================================================
# Script de ejecución para el ejemplo de Pi por Monte Carlo en Hadoop 3.3.6
# Equipo 4 - Big Data Analytics
# ==============================================================================

set -e

# Parámetros por defecto (se pueden pasar como argumentos al script)
# Uso: ./ejecutar.sh [num_maps] [num_samples_per_map]
MAPS=${1:-10}
SAMPLES=${2:-10000}

echo "=========================================================="
echo "    Cálculo de Pi mediante QuasiMonteCarlo en Hadoop     "
echo "=========================================================="
echo "Número de Maps:     $MAPS"
echo "Muestras por Map:   $SAMPLES"
TOTAL_PUNTOS=$((MAPS * SAMPLES))
echo "Total de puntos:    $TOTAL_PUNTOS"
echo "=========================================================="

# Buscar el archivo JAR de ejemplos de Hadoop
JAR_PATH=""

if [ -n "$HADOOP_HOME" ] && [ -f "$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar" ]; then
    JAR_PATH="$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar"
elif [ -f "/opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar" ]; then
    JAR_PATH="/opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar"
elif [ -f "/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar" ]; then
    JAR_PATH="/usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar"
else
    # Buscar dinámicamente si no está en las rutas usuales
    echo "Buscando hadoop-mapreduce-examples-*.jar en el sistema..."
    JAR_PATH=$(find / -name "hadoop-mapreduce-examples-*.jar" 2>/dev/null | head -n 1)
fi

if [ -z "$JAR_PATH" ]; then
    echo "❌ Error: No se encontró el JAR de ejemplos de Hadoop."
    echo "Verifica que Hadoop esté instalado y las variables de entorno configuradas."
    exit 1
fi

echo "✔ JAR encontrado en: $JAR_PATH"
echo ""
echo "🚀 Iniciando Job de MapReduce..."
echo ""

START_TIME=$(date +%s)

# Ejecutar el job de Hadoop
hadoop jar "$JAR_PATH" pi "$MAPS" "$SAMPLES"

END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

echo ""
echo "=========================================================="
echo "✔ Ejecución finalizada con éxito."
echo "⏱ Tiempo total transcurrido: ${DURATION} segundos."
echo "=========================================================="
