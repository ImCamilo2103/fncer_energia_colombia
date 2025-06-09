# Proyecto: Análisis de la Matriz Energética con FNCER en Colombia

## Descripción General
Este proyecto tiene como objetivo estructurar, normalizar, limpiar y analizar los datos provenientes del dataset de Fuentes No Convencionales de Energía Renovable (FNCER) de Colombia, publicado por el gobierno nacional a través de datos.gov.co. El objetivo final es preparar una base de datos adecuada para el análisis de la evolución, impacto y distribución de la energía renovable en el país, utilizando tanto Python como R.

## Fuente de Datos
- **Nombre del dataset:** Meta FNCER - Nueva capacidad instalada a partir de FNCER
- **Fuente:** [datos.gov.co](https://www.datos.gov.co/resource/vy9n-w6hc.json)
- **Formato original:** CSV y JSON (API)
- **Codificación del archivo:** UTF-8
- **Descarga automatizada:** El dataset fue descargado mediante un script Python a través de la API de datos.gov.co.

## Estructura del Proyecto
```
api_descargas
|       01_descargar_datos.py
|       
+---datasets_originales
|       fncer_datos_generacion.csv
|       meta_fncer_clean.csv
|       
+---data_limpia
|       departamentos.csv
|       departamentos.json
|       meta_fncer.csv
|       meta_fncer.json
|       meta_fncer__raw.csv
|       meta_fncer__raw.json
|       municipios.csv
|       municipios.json
|       proyectos.csv
|       proyectos.json
|       proyectos_municipios.csv
|       proyectos_municipios.json
|       tipos_proyectos.csv
|       tipos_proyectos.json
|       
+---documentos
|       5_porques.md
|       co.geojson
|       Colombia.geojson
|       preguntas analisis estatdistico.md
|       registro_limpieza_datos_fncer.xlsx
|       smart_questions.md
|       sow.md
|       
+---informes
|       Conclusiones del Análisis de FNCER en Colombia.md
|       Conclusiones del Análisis de FNCER en Colombia.pdf
|       
+---notebooks
|       Eda Fncer Python Notebook.md
|       Eda Fncer Rmarkdown.Rmd
|       
+---Scripts
|       02_limpiar_csv.py
|       03_normalizar_dataset.sql
|       04_Respuestas preguntas.py
|       04_Respuestas preguntas.R
|       
\---visualizaciones
        Análisis FNCER - Energías Renovables en Colombia.twb
        Análisis FNCER - Energías Renovables en Colombia.twbx
        fncer.twb

```

## Proceso de Trabajo
1. **Descarga del dataset** usando Python desde la API oficial.
2. **Carga de datos crudos** desde el CSV original a la tabla `meta_fncer__raw`.
3. **Creación de estructura normalizada** en PostgreSQL:
   - `departamentos`
   - `municipios`
   - `tipos_proyectos`
   - `proyectos`
   - `proyectos_municipios`
4. **Inserción de datos** desde la tabla cruda a las tablas normalizadas.
5. **Creación de vista `meta_fncer`** para simplificar el análisis.
6. **Eliminación de duplicados** y corrección de valores inválidos (como `"""` en municipios).

## Limpieza de Datos
- Conversión de tipos de datos.
- Normalización de nombres de columnas.
- Eliminación de registros duplicados.
- Validación de datos faltantes y consistencia referencial.
- Corrección de valores anómalos usando reglas de negocio y códigos DANE.

## Análisis Exploratorio (EDA)

Se realizó utilizando **Python** y **R** para mostrar dominio en ambas herramientas:

- **Python** (`pandas`, `seaborn`, `matplotlib`): distribución de capacidad, inversión, emisiones, correlaciones.
- **R** (`dplyr`, `ggplot2`): análisis descriptivo complementario, visualización comparativa.

## Vista para Análisis
```sql
CREATE VIEW meta_fncer AS
SELECT
    p.id AS proyecto_id,
    p.proyecto,
    p.capacidad,
    p.fecha_estimada_fpo,
    p.energia_kwhdia,
    p.usuarios,
    p.inversion_estimada_cop,
    p.empleos_estimados,
    p.emisiones_co2_tonano,
    tp.nombre_tipo AS tipo_proyecto,
    m.municipio,
    m.codigo_municipio,
    d.departamento,
    d.codigo_departamento
FROM proyectos p
JOIN tipos_proyectos tp ON p.id_tipo = tp.id
JOIN proyectos_municipios pm ON p.id = pm.id_proyecto
JOIN municipios m ON pm.id_municipio = m.id
JOIN departamentos d ON m.id_departamento = d.id;
```

## Herramientas Utilizadas
- PostgreSQL 15+
- Python 3.11 (pandas, matplotlib, seaborn)
- R (ggplot2, dplyr)
- VS Code / DBeaver
- Git y Markdown

## Estado Actual
✅ Datos normalizados  
✅ Datos cargados y limpiados  
✅ Vista creada para análisis  
✅ Exploración de datos con Python y R  
🔜 Conclusiones y visualizaciones finales  

## Autor
**Camilo Garzon Moreno**  
Ingeniero Mecánico con experiencia en manufactura, proyectos industriales, análisis y proyectos de datos.
