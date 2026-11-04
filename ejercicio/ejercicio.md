# 🎯 Mini Ejercicio: Precisión vs. Paralelismo en el Cálculo de Pi

**Tema:** Estimación de $\pi$ mediante QuasiMonteCarlo en Hadoop  
**Equipo:** 4  
**Objetivo:** Comprender cómo influyen el número de tareas **Map** y el número de **muestras (samples)** en la precisión del resultado matemático y en el tiempo de ejecución en Hadoop.

---

## 📋 Contexto
El comando para estimar $\pi$ recibe dos parámetros enteros:
```bash
hadoop jar hadoop-mapreduce-examples-3.3.6.jar pi <nMaps> <nSamples>
```
* `<nMaps>`: Cantidad de procesos Map que se ejecutarán en paralelo en YARN.
* `<nSamples>`: Cantidad de puntos generados por cada Map individual.
* **Puntos totales evaluados:** $N = \text{nMaps} \times \text{nSamples}$.

---

## 🛠️ Instrucciones

Realiza tres ejecuciones distintas del algoritmo variando los parámetros dentro de tu contenedor Hadoop:

### Experimento 1: Pocas muestras (Muestreo rápido)
Ejecuta el cálculo con:
* **Maps:** 2
* **Muestras por Map:** 1,000  
*(Total de puntos: 2,000)*

### Experimento 2: Incremento de muestras por Map (Mayor precisión)
Ejecuta el cálculo con:
* **Maps:** 2
* **Muestras por Map:** 100,000  
*(Total de puntos: 200,000)*

### Experimento 3: Incremento de Maps (Mayor paralelismo)
Ejecuta el cálculo con:
* **Maps:** 8
* **Muestras por Map:** 25,000  
*(Total de puntos: 200,000)*

---

## 📝 Entregable / Preguntas a responder

1. **Tabla comparativa:** Llena la siguiente tabla con los valores obtenidos en tu entorno:

| Experimento | Maps | Muestras/Map | Puntos Totales | Pi Estimado | Error Relativo (%) | Tiempo (segundos) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **Exp 1** | 2 | 1,000 | 2,000 | | | |
| **Exp 2** | 2 | 100,000 | 200,000 | | | |
| **Exp 3** | 8 | 25,000 | 200,000 | | | |

> *Fórmula de Error Relativo:*  
> $$\text{Error (\%)} = \left| \frac{\text{Pi Estimado} - 3.14159265}{3.14159265} \right| \times 100$$

2. **Pregunta de análisis 1:**  
   Al comparar el **Experimento 1** con el **Experimento 2**, ¿qué ocurrió con el error respecto al valor real de $\pi$? ¿Por qué sucede esto en el método de Monte Carlo?

3. **Pregunta de análisis 2:**  
   El **Experimento 2** y el **Experimento 3** procesan exactamente la misma cantidad total de puntos ($200,000$). ¿Cuál tardó más tiempo y por qué? *(Pista: considera el overhead de iniciar contenedores YARN vs. los núcleos disponibles del contenedor)*.

4. **Pregunta de análisis 3:**  
   ¿Qué pasaría si ejecutamos el comando con `0` Maps o `0` Muestras? Pruébalo y describe el resultado.

