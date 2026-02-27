# Credit Scoring & MLOps Stress Testing Framework 🚀

Este proyecto es un ecosistema completo de Machine Learning diseñado para un sistema de **Credit Scoring**, aplicando principios **SOLID**, **Programación Orientada a Objetos** y metodologías modernas de **MLOps & Chaos Engineering**.

## 🌟 Características Principales

1. **Pipeline de Machine Learning de Extremo a Extremo**:
   - Generación de datos sintéticos realistas.
   - Ingeniería de características robusta (Cálculo de DTI, Target Encoding, Escalado).
   - Entrenamiento usando **LightGBM** con Validación Cruzada (K-Fold).
   - Inferencia paquetizada en una clase POO (`predict.py`).

2. **Chaos Engineering (Stress Testing)**:
   - Inyección intencional de Data Leakage, errores de División por Cero (ZeroDivisionError) e incompatibilidades extremas y estrictas de Pandas 3.0 para validar la tolerancia a fallos del sistema.

3. **Agente de Autoreparación (Self-Healing)**:
   - Un agente `self_healing_agent.py` que ejecuta pruebas unitarias de `pytest`, detecta excepciones de código, y reescribe dinámicamente el código fuente (`build_features.py`) inyectando soluciones robustas (como `np.where`).

4. **Retraining Iterativo e Hiper-Optimización**:
   - Orquestador automático que simula *Data Drift* (p. ej. Inflación económica global) y ejecuta re-entrenamientos.
   - Integración nativa con **Optuna** para búsqueda Bayesiana de hiperparámetros y superación de métricas de Baseline.

## 📂 Estructura del Directorio

```bash
📦credit_scoring
 ┣ 📂data
 ┃ ┣ 📂processed         # Datos listos para el modelo
 ┃ ┗ 📂raw               # Datos sintéticos crudos (synthetic_data.csv)
 ┣ 📂logs                # Historial de métricas MLOps (training_history.json)
 ┣ 📂models              # Artefactos del modelo (lgb_model.txt, transformer.pkl)
 ┣ 📂src
 ┃ ┣ 📂features
 ┃ ┃ ┗ 📜build_features.py # Transformers compatibles con scikit-learn
 ┃ ┣ 📂models
 ┃ ┃ ┣ 📜predict.py        # Clase POO para Inferencia en Producción
 ┃ ┃ ┗ 📜train_model.py    # Main training loop (K-Fold + Optuna)
 ┃ ┣ 📂utils
 ┃ ┃ ┣ 📜chaos_injector.py # Inyector de bugs
 ┃ ┃ ┗ 📜self_healing_agent.py # Reparador automático usando AST parsing
 ┃ ┣ 📜data_gen.py         # Generador de datos sintéticos
 ┃ ┗ 📜pipeline.py         # Pipeline de reentrenamiento de 3 fases
 ┣ 📂tests
 ┃ ┗ 📜test_features.py    # Pruebas Unitarias Pytest
 ┣ 📜.gitignore
 ┣ 📜Dockerfile            # Entorno para despliegue en Contenedores
 ┣ 📜Makefile              # Comandos rápidos de acceso
 ┣ 📜requirements.txt      # Paquetes de Python
 ┗ 📜setup.sh              # Script de arranque bash
```

## 🛠️ Instalación y Uso

### 1. Requisitos
- Python 3.11+
- Git

### 2. Configurar el Entorno
Ejecuta el Makefile incluido para levantar toda la infraestructura del proyecto en segundos (Crea directorios e instala las librerías).
```bash
make setup
```

### 3. Pipeline de Entrenamiento y MLOps
Puedes operar manualmente los pasos de inferencia y datos:
```bash
make data   # Genera 20,000 registros sintéticos en data/raw/
make train  # Entrena el modelo Base de LightGBM (AUC ~0.7810)
make test   # Corre la suite de pruebas unitarias
```

**Para ejecutar el Ecosistema Completo de Pruebas MLOps:**
Ejecuta los siguientes scripts en orden para ver el sistema estresarse y curarse a sí mismo:
```bash
# 1. Inyecta el Caos
python src/utils/chaos_injector.py

# 2. Permite que el Agente se cure a sí mismo usando Pytest
python src/utils/self_healing_agent.py

# 3. Corre las iteraciones simulando Inflación y optimizando con Optuna
python src/pipeline.py
```

## 🚀 Puesta en Producción

El proyecto está preparado para CI/CD y despliegue:
* **Inferencia Local:** `python src/models/predict.py` inicializará la clase `CreditScorer` cargando los artefactos guardados en `models/` y devolviendo el score.
* **Docker:** Ejecuta `docker build -t credit-scoring:latest .` para empaquetar el generador y el pipeline, totalmente aislado y listo para subir a un Google Cloud Run o un pod de Kubernetes.
