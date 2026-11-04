# 📁 Carpeta de Datos: Estimación de Pi por Monte Carlo

En el caso particular del ejemplo `pi` de Hadoop MapReduce (**QuasiMonteCarlo**), **no se requiere un archivo de datos de entrada externo** (a diferencia de ejemplos como `wordcount` o `grep` que leen archivos de texto desde HDFS).

---

### ¿Cómo obtiene los datos de entrada el ejemplo `pi`?

1. **Generación en memoria:**
   Los puntos muestrales $(x, y)$ se generan de forma determinista y paralela en cada Mapper utilizando la **secuencia de Halton** (un generador de números cuasi-aleatorios de baja discrepancia).
   
2. **Entrada de los Mappers:**
   Los parámetros que se le pasan al programa son:
   * **`nMaps`**: Número de tareas Map que se lanzarán en paralelo.
   * **`nSamples`**: Cantidad de puntos muestrales que cada Map generará e inspeccionará.

3. **Sin sobrecarga de I/O de disco:**
   Hadoop crea internamente un directorio temporal en HDFS (por ejemplo, `/user/hadoop/QuasiMonteCarlo_...`) para almacenar las especificaciones de los splits y las salidas intermedias, pero los datos numéricos de los puntos se generan al vuelo en la memoria RAM de cada nodo.

---

### Script de Apoyo Local (`simular_montecarlo.py`)
Para entender intuitivamente el método antes o después de ejecutar Hadoop, se incluye en esta carpeta el script `simular_montecarlo.py`, el cual realiza una simulación básica de Monte Carlo en Python de manera local para comparar conceptos.

