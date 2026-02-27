#!/bin/bash
# Script para crear la estructura de directorios del proyecto

echo "Creando estructura de directorios..."
mkdir -p data/raw data/processed models/ src/features src/models tests/
echo "¡Directorios creados con éxito!"
