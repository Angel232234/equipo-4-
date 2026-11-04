#!/usr/bin/env python3
"""
Simulación simple del Método de Monte Carlo para calcular Pi.
Este script replica el razonamiento matemático que realiza el Mapper en Hadoop.
"""

import random
import sys

def estimar_pi(num_muestras):
    dentro_circulo = 0

    for _ in range(num_muestras):
        # Generar coordenadas aleatorias en el cuadrante [0, 1] x [0, 1]
        x = random.random()
        y = random.random()

        # Condición: x^2 + y^2 <= 1 (dentro del cuarto de círculo unitario)
        if (x * x + y * y) <= 1.0:
            dentro_circulo += 1

    # pi / 4 = dentro_circulo / num_muestras  =>  pi = 4 * (dentro_circulo / num_muestras)
    pi_estimado = 4.0 * dentro_circulo / num_muestras
    return pi_estimado, dentro_circulo

if __name__ == "__main__":
    n = 1000000
    if len(sys.argv) > 1:
        n = int(sys.argv[1])

    print(f"--- Simulación Monte Carlo (Python local) ---")
    print(f"Muestras totales: {n:,}")
    pi_calculado, dentro = estimar_pi(n)
    pi_real = 3.141592653589793
    error = abs(pi_calculado - pi_real) / pi_real * 100

    print(f"Puntos dentro del cuarto de círculo: {dentro:,}")
    print(f"Valor estimado de Pi: {pi_calculado:.8f}")
    print(f"Valor real de Pi:     {pi_real:.8f}")
    print(f"Error relativo:       {error:.4f}%")

