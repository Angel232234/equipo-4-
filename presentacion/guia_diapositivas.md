# 🎤 Guía y Estructura para la Exposición (10 Minutos)

Esta guía contiene la estructura diapositiva por diapositiva para preparar su presentación en **PowerPoint**, **Canva** o **Google Slides**, y luego exportarla como `presentacion.pdf` en la raíz del repositorio.

---

## ⏱️ Distribución del Tiempo (Total: 10 Minutos)

| Diapositiva / Sección | Minutos | Quién Expone |
| :--- | :---: | :---: |
| 1. Portada e Introducción | 1 min | Integrante 1 |
| 2. ¿Qué es el método de Monte Carlo y casos de uso? | 2 min | Integrante 1 |
| 3. Arquitectura MapReduce (Mappers, Reducers y Diagrama) | 2.5 min | Integrante 2 |
| 4. Demostración en vivo en Docker (Comandos y Salida) | 3 min | Integrante 2 o 3 |
| 5. Mini Ejercicio para compañeros y Conclusiones | 1.5 min | Integrante 3 |

---

## 📑 Diapositiva por Diapositiva

### Diapositiva 1: Portada
* **Título:** Estimación de Pi mediante Monte Carlo en Hadoop MapReduce
* **Materia:** Big Data Analytics
* **Equipo:** Equipo 4
* **Integrantes:** [Nombres y Apellidos de los integrantes]
* **Fecha:** Noviembre 2026

---

### Diapositiva 2: ¿Qué hace el ejemplo `pi`?
* **Idea Central:** Estimar el valor del número irracional $\pi$ de manera estadística.
* **Fundamento Matemático:**
  * Se inscribe un cuarto de círculo de radio $r=1$ en un cuadrado unitario de lado $1 \times 1$.
  * Área del cuadrado = $1 \times 1 = 1$.
  * Área del cuarto de círculo = $\frac{\pi r^2}{4} = \frac{\pi}{4}$.
  * Probabilidad de caer dentro = $\frac{\text{Área Círculo}}{\text{Área Cuadrado}} = \frac{\pi}{4}$.
  * Por lo tanto: $\pi \approx 4 \times \frac{\text{Puntos adentro}}{\text{Total de puntos}}$.
* **Caso de Uso Real:**
  * **Finanzas cuantitativas:** Simulación de riesgo crediticio, precios de opciones y derivados complejos (Black-Scholes avanzado).
  * **Física y Química:** Modelado de difusión de partículas y mecánica cuántica.
  * **Integración en alta dimensión:** Donde los métodos numéricos tradicionales sufren la "maldición de la dimensionalidad".

---

### Diapositiva 3: Arquitectura MapReduce (¿Cómo funciona por dentro?)
* **Generación:** Emplea la secuencia cuasi-aleatoria de **Halton** para distribuir puntos uniformemente.
* **Fase MAP (Mappers paralelos):**
  * Cada Mapper toma un rango de muestras independientes.
  * Genera coordenadas $(x, y)$.
  * Evalúa si $x^2 + y^2 \le 1$.
  * Emite dos números: `(Puntos Adentro, Puntos Evaluados)`.
* **Fase SHUFFLE & REDUCE:**
  * El Reducer único suma los puntos adentro de todos los mappers.
  * Suma los puntos totales.
  * Calcula la fórmula final: $4 \times \frac{\sum \text{adentro}}{\sum \text{totales}}$.
* *(Incluir el diagrama conceptual de flujo que está en el README).*

---

### Diapositiva 4: Demo en Vivo en Docker
* **Comando principal:**
  ```bash
  hadoop jar hadoop-mapreduce-examples-3.3.6.jar pi 10 10000
  ```
* **Elementos a resaltar en la terminal durante la demo:**
  1. Número de Maps lanzados (`10 splits`).
  2. Progreso de YARN (`map 0% ... 100%`, `reduce 0% ... 100%`).
  3. Contadores finales (vcores, bytes, tiempo total).
  4. Resultado numérico estimado vs. valor real.

---

### Diapositiva 5: Mini Ejercicio para la Clase
* **Reto:** Comparar Precisión vs. Número de Mappers.
* **Pregunta clave para el grupo:** ¿Por qué 8 maps pueden tardar más tiempo que 2 maps en un contenedor de Docker local a pesar de procesar la misma cantidad de puntos?
* **Respuesta rápida:** Por la sobrecarga (*overhead*) de levantar contenedores YARN y la limitación de núcleos en una máquina virtual.

---

### Diapositiva 6: Conclusiones
* Hadoop permite paralelizar algoritmos masivamente paralelos sin necesidad de comunicación entre mappers (*embarrassingly parallel*).
* A mayor número de muestras, menor error relativo.
* Repositorio Git disponible con guía paso a paso para reproducir la práctica.

---

> 📌 **Recordatorio final:**  
> Una vez diseñada la presentación, guárdala como PDF con el nombre exacto `presentacion.pdf` en la raíz del repositorio antes de hacer `git push`.
