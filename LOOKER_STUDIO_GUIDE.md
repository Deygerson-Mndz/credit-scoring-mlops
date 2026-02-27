# Guía de Puesta en Producción: Looker Studio 📊

Dado que **Looker Studio** es una herramienta en la nube administrada por Google, no es posible generar el dashboard gráfico de forma programática con código.

Sin embargo, he generado el archivo **`looker_studio_export.csv`** (Ubicado en la ruta `data/processed/`), el cual contiene tus 50,000 registros junto con las probabilidades de riesgo, segmentaciones (Bajo/Medio/Alto) y las decisiones inferidas algorítmicamente por nuestro MLOps Framework. 

Sigue estos *3 simples pasos* para visualizar tus KPIs:

### Paso 1: Conectar los Datos
1. Entra a [Looker Studio](https://lookerstudio.google.com/) e inicia sesión con tu cuenta de Google.
2. Haz clic en **Crear** > **Informe**.
3. En la ventana "Añadir datos al informe", selecciona **Subida de Archivos** o **Google Sheets** (Si decides importarlo a drive primero).
4. Arrastra y suelta el archivo `data/processed/looker_studio_export.csv` desde tu explorador de Windows.
5. Espera unos segundos a que diga "Añadido" y clic en **Añadir**.

### Paso 2: Crear el Dashboard Analítico de KPIs

La magia de este export es que los datos ya están procesados y categorizados. Agrega los siguientes elementos visuales arrastrándolos desde "Añadir un Gráfico":

#### KPI 1: Tasa de Aprobación vs Denegación
* **Gráfico**: Gráfico de Anillos (Donut Chart)
* **Dimensión**: `Algorithmic_Decision`
* **Métrica**: Record Count (Recuento)
* *Utilidad*: Podrás ver que la herramienta preclasificó alrededor de ~32k como "Denegados" y ~17k como "Aprobados".

#### KPI 2: Matriz de Segmentos de Riesgo Educativo
* **Gráfico**: Gráfico de Barras Apiladas (Stacked Bar Chart)
* **Dimensión**: `education` (High School, Bachelor, etc.)
* **Dimensión de Desglose**: `Risk_Segment` (Alto Riesgo, Riesgo Medio, Bajo Riesgo).
* **Métrica**: Record Count (Recuento)
* *Utilidad*: Permite al departamento de crédito entender cómo se distribuye el riesgo basado en el grado de educación.

#### KPI 3: Deuda vs Probabilidad de Impago
* **Gráfico**: Gráfico de Dispersión (Scatter Plot)
* **Dimensión**: Ninguna o `employment_status` para darle color.
* **Métrica X**: `total_debt`
* **Métrica Y**: `Risk_Probability`
* *Utilidad*: Demuestra visualmente cómo a medida que aumenta la deuda (o el DTI), salta exponenecialmente la probabilidad generada por LightGBM.

### Paso 3: Estéticas y Filtros
1. Añade un **Control de Filtro (Filtro Desplegable)** apuntando a `employment_status` en la parte superior. Al hacerlo, tú y tu equipo podrán ver cambiar los gráficos anteriores si seleccionan solo clientes `Selft-Employed` o `Salaried`.
2. Dale unos toques de estilo oscuro y colores modernos en el menú *Temas y Diseño* a tu gusto.

¡Y eso es todo! De esta manera, todo el motor algorítmico, y los 50,000 datos generados y estresados por MLOps están representados y consumibles en un proyecto Business Intelligence de nivel directivo.
