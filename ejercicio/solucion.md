# 💡 Solución del Mini Ejercicio: Precisión vs. Paralelismo

**Tema:** Estimación de $\pi$ mediante QuasiMonteCarlo en Hadoop  
**Equipo:** 4  

---

## 1. Comandos Utilizados

### Experimento 1 (2 Maps, 1,000 muestras)
```bash
# 🐳 Dentro del contenedor:
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar pi 2 1000
```

### Experimento 2 (2 Maps, 100,000 muestras)
```bash
# 🐳 Dentro del contenedor:
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar pi 2 100000
```

### Experimento 3 (8 Maps, 25,000 muestras)
```bash
# 🐳 Dentro del contenedor:
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar pi 8 25000
```

---

## 2. Tabla Comparativa (Valores de Referencia)

> *Nota: Los tiempos pueden variar ligeramente según las características del equipo anfitrión y los recursos asignados a Docker.*

| Experimento | Maps | Muestras/Map | Puntos Totales | Pi Estimado | Error Relativo (%) | Tiempo aprox. |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Exp 1** | 2 | 1,000 | 2,000 | `3.1480000000` | $\approx 0.2039\%$ | $\approx 18 \text{ s}$ |
| **Exp 2** | 2 | 100,000 | 200,000 | `3.1415800000` | $\approx 0.0004\%$ | $\approx 22 \text{ s}$ |
| **Exp 3** | 8 | 25,000 | 200,000 | `3.1415700000` | $\approx 0.0007\%$ | $\approx 31 \text{ s}$ |

---

## 3. Respuestas a las Preguntas de Análisis

### Pregunta 1: Comparación Exp 1 vs. Exp 2 (Efecto de la cantidad de muestras)
* **Respuesta:** En el Experimento 2 el error disminuye drásticamente (pasa de $\approx 0.20\%$ a menos del $0.001\%$).
* **Justificación teórica:** El método de Monte Carlo se rige por la **Ley de los Grandes Números**. La varianza del estimador es inversamente proporcional al número total de muestras ($O(1/\sqrt{N})$ en Monte Carlo tradicional o incluso menor con secuencias de baja discrepancia como Halton). A mayor cantidad de puntos generados, la proporción muestral converge al área geométrica real de la circunferencia.

---

### Pregunta 2: Comparación Exp 2 vs. Exp 3 (Mismo número de puntos, diferente paralelismo)
* **Respuesta:** Aunque ambos procesaron 200,000 puntos en total, el Experimento 3 (8 Maps) suele tardar **más tiempo** que el Experimento 2 (2 Maps) en un entorno de práctica local (contenedor en Docker).
* **Justificación técnica:** 
  1. **Sobrecarga de gestión (Overhead):** Lanzar cada tarea Map en YARN requiere crear, instanciar y monitorear un contenedor JVM independiente. Inicializar 8 contenedores toma más tiempo que inicializar 2.
  2. **Límite de núcleos de CPU en Docker:** En una computadora personal, el contenedor típicamente tiene asignados entre 2 y 4 núcleos lógicos. Por lo tanto, 8 Maps no se ejecutan todos de forma simultánea, sino que deben esperar en la cola del ResourceManager/NodeManager. En un clúster físico real de decenas de nodos, el Exp 3 se ejecutaría más rápido porque habría suficientes núcleos para ejecutar los 8 Maps concurrentemente.

---

### Pregunta 3: ¿Qué ocurre con parámetros en cero?
* **Respuesta:** Si se ejecuta con `0` Maps o `0` Muestras:
  ```bash
  hadoop jar hadoop-mapreduce-examples-3.3.6.jar pi 0 1000
  ```
  Hadoop arroja una excepción de validación o finaliza con un error indicando que los parámetros deben ser enteros positivos mayores a cero (`IllegalArgumentException` o división por cero al calcular la fracción de puntos).
