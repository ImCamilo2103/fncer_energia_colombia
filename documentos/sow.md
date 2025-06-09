# Statement of Work (SOW) - Proyecto FNCER Colombia

## 1. Nombre del Proyecto

Análisis de la Matriz Energética con FNCER en Colombia

## 2. Antecedentes

El crecimiento de las Fuentes No Convencionales de Energía Renovable (FNCER) en Colombia ha sido una prioridad estratégica en los últimos años. Sin embargo, los datos disponibles a través de portales oficiales como datos.gov.co no están estructurados ni listos para análisis directo. Este proyecto tiene como finalidad procesar dichos datos, normalizarlos, analizarlos estadísticamente y prepararlos para visualizaciones e interpretación técnica.

## 3. Alcance

* Descarga automatizada del dataset FNCER desde la API de datos.gov.co.
* Carga inicial en PostgreSQL en una tabla cruda.
* Limpieza de datos: corrección de caracteres especiales, eliminación de duplicados y valores inválidos.
* Normalización en tablas relacionadas: departamentos, municipios, tipos de proyecto, proyectos.
* Creación de vista consolidada `meta_fncer`.
* Análisis estadístico exploratorio en Python y R.
* Documentación técnica, preguntas SMART, 5 Porqués y publicación del proyecto.

## 4. Entregables

| Entregable                     | Descripción                                                                           |
| ------------------------------ | ------------------------------------------------------------------------------------- |
| Script de descarga Python      | Automatiza la obtención de datos desde la API oficial**                 |
| Tabla `meta_fncer__raw`        | Tabla cruda en PostgreSQL**                                                             |
| Tablas normalizadas            | `departamentos`, `municipios`, `tipos_proyectos`, `proyectos`, `proyectos_municipios` |
| Vista `meta_fncer`             | Consolidación de datos para análisis                                                  |
| Exploración de datos en Python | Estadísticas, gráficos, correlaciones (`pandas`, `matplotlib`, `seaborn`)             |
| Exploración de datos en R      | Análisis descriptivo y visualización (`ggplot2`, `dplyr`)                             |
| Archivos CSV limpios           | Exportación de las tablas normalizadas                                                |
| README.md                      | Documentación técnica del proyecto                                                    |
| SOW\.md                        | Alcance formal del proyecto                                                           |
| SMART / 5 Porqués              | Objetivos medibles y análisis de causa                                                |

## 5. Objetivos

* Obtener, transformar y analizar datos de **FNCER** en Colombia.
* Crear una base de datos estructurada y replicable.
* Usar herramientas modernas de análisis `(Python y R)` para generar valor desde los datos.
* Presentar hallazgos claros que puedan servir para toma de decisiones o visualizaciones públicas.

## 6. Duración Estimada

**5 días hábiles**:

* **Día 1:** Descarga + limpieza inicial
* **Día 2:** Modelado y normalización
* **Día 3:** Carga y validación de datos
* **Día 4:** Análisis con Python y R
* **Día 5:** Documentación, visualización y publicación

## 7. Tecnologías Utilizadas

* PostgreSQL 17+
* Python 3.13 (pandas, matplotlib, seaborn)
* R (ggplot2, dplyr)
* Visual Studio Code / DBeaver
* Git, Markdown, Excel/Word

## 8. Responsable

**Camilo Garzon Moreno**
Ingeniero Mecánico con experiencia en manufactura, energías renovables, proyectos industriales, análisis y proyectos de datos.
