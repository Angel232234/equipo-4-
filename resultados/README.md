# 📊 Resultados Esperados: Ejemplo `pi` en Hadoop

Este directorio contiene las evidencias de ejecución y la explicación del resultado generado por el algoritmo de Monte Carlo.

---

## 1. Salida de Consola
En el archivo [salida_consola.txt](salida_consola.txt) se encuentra la traza completa de la ejecución de MapReduce al ejecutar:
```bash
hadoop jar hadoop-mapreduce-examples-3.3.6.jar pi 10 10000
```

---

## 2. Análisis del Resultado Numérico

| Métrica | Valor Obtenido |
| :--- | :--- |
| **Número de Maps lanzados** | `10` |
| **Muestras por Map** | `10,000` |
| **Total de puntos evaluados** | `100,000` |
| **Valor Estimado de $\pi$** | `3.14120000000000000000` |
| **Valor Real de $\pi$** | `3.14159265358979323846` |
| **Error Absoluto** | $\approx 0.00039265$ |
| **Error Relativo Porcentual** | $\approx 0.0125\%$ |
| **Tiempo de Ejecución** | $\approx 32.5\text{ s}$ |

---

## 3. ¿Dónde guarda Hadoop los resultados intermedios?
A diferencia de otros jobs donde se especifica una carpeta de salida como `/salida` o `/tmp/salida/part-r-00000`, el job de `pi`:
1. Crea un directorio temporal en HDFS:
   ```bash
   /user/hadoop/QuasiMonteCarlo_XXXXX/
   ```
2. Los mappers escriben sus recuentos en ese directorio temporal en formato SequenceFile.
3. El Reducer suma los puntos interiores y el total.
4. El programa calcula internamente $\pi = 4 \times \frac{\text{dentro}}{\text{total}}$, imprime el valor final directamente en la salida estándar (`stdout`) de la terminal y limpia automáticamente el directorio temporal de HDFS.

---

## 4. Cómo guardar y copiar la salida del contenedor a tu máquina local

Si deseas guardar la salida directamente en un archivo de texto dentro del contenedor:
```bash
# 🐳 Dentro del contenedor:
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar pi 10 10000 | tee /tmp/salida_pi.txt
```

Y luego, para copiarlo a tu computadora:
```bash
# 💻 En la terminal de tu computadora:
docker cp hadoop:/tmp/salida_pi.txt resultados/salida_consola.txt
```

