# Proyecto: Análisis de Energía Renovable en Colombia (FNCER)

## 🌍 Descripción General
Este proyecto analiza el impacto, distribución y características de los proyectos de energía renovable desarrollados en Colombia, basándose en los datos publicados por el Gobierno Nacional sobre Fuentes No Convencionales de Energía Renovable (FNCER).

## 📂 Estructura del Proyecto
```
fncer_energia_colombia/
├── data_limpia/                # Datos procesados y limpios en formato .json
├── documentos/                # Documentación complementaria (SOW, 5 porqués, etc.)
├── scripts/                   # Scripts de análisis en Python y R
├── informes/                  # Informes PDF e imágenes de dashboards
├── README.md                  # Este archivo
```

## 📊 Dataset Utilizado
- **Nombre:** Meta FNCER - Fuentes No Convencionales de Energía Renovable
- **Fuente:** [datos.gov.co](https://www.datos.gov.co/resource/vy9n-w6hc.json)
- **Formato original:** CSV / JSON (API REST)
- **Año de extracción:** 2025

## 🧰 Tecnologías Utilizadas
- **PostgreSQL:** Modelado relacional, consultas SQL y normalización.
- **Python:** Análisis y visualización (pandas, seaborn, matplotlib, sqlalchemy).
- **R:** Análisis estadístico y visualización con `ggplot2` y `dplyr`.
- **Tableau / Power BI:** Dashboards interactivos.
- **Git / GitHub:** Control de versiones y publicación del proyecto.

## ⚙️ Flujo de Trabajo
1. 📥 Descarga automática del dataset desde API REST.
2. 🧹 Limpieza de datos (Python + SQL):
   - Conversión de columnas mal codificadas (UTF-8)
   - Eliminación de duplicados
   - Sustitución de valores nulos por referencias cruzadas
3. 🗃 Normalización en PostgreSQL:
   - `departamentos`, `municipios`, `tipos_proyectos`, `proyectos`, `proyectos_municipios`
4. 📈 Análisis Exploratorio:
   - Total y promedio de capacidad instalada
   - Distribución por tipo de energía
   - Relación capacidad vs inversión
   - Beneficiarios por departamento
5. 📊 Visualización en Tableau y Power BI
6. 📄 Documentación de insights y generación de informes

## 📌 Resultados y Hallazgos
- 🌞 **La energía solar** representa la mayor parte de la capacidad instalada.
- 📈 Alta correlación entre capacidad instalada e inversión en COP.
- 🧑‍🤝‍🧑 Departamentos como **La Guajira y Cesar** concentran la mayoría de beneficiarios.

## 📎 Recursos Clave
- 🔗 [Dataset Original en Datos.gov](https://www.datos.gov.co/resource/vy9n-w6hc.json)
- 🧠 [Dashboard interactivo en Tableau (próximamente)](https://public.tableau.com/app/profile/tu_usuario)
- 📂 [Repositorio GitHub](https://github.com/ImCamilo2103/fncer_energia_colombia)

## 🧾 Documentos Adicionales
- [✔️ SOW - Alcance del Proyecto (sow.md)](documentos/sow.md)
- [❓ SMART Questions](documentos/smart_questions.md)
- [🧠 5 Porqués](documentos/5_porques.md)
- [🗺️ GeoJSON de Colombia](documentos/co.geojson)

## 📷 Captura del Dashboard
![Dashboard FNCER](informes/dashboard_fncer.png)

## 🙋 Autor
**Camilo Garzon M.** — Ingeniero Mecánico con experiencia en manufactura, proyectos industriales, apasionado por los datos, la energía y la analítica.
Camilo Garzon Moreno
