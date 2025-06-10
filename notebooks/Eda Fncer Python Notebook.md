# EDA - FNCER Colombia en Python

## 📦 Importar módulos
Primero importamos los modulos que vamos a trabajar eto con el fin que los llamemos a medida que los utilicemos.
```Python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sqlalchemy import create_engine
```

## 🔌 Conexión a PostgreSQL
Me conecto a los modulos de PostgreSQLesto con el fin de trabajar desde la base de datos que esta alli
```Python
engine = create_engine('postgresql://postgres:''@localhost:5432/¿')
```

## ✅ Pregunta 1: Capacidad total y promedio
En esta parte vamos a reponder un par de preguntas que nos realizamos antes de empezar analizar los datos.
```Python
query = "SELECT capacidad FROM proyectos"
df = pd.read_sql(query, engine)

total = df['capacidad'].sum()
promedio = df['capacidad'].mean()
print(f"🔋 Capacidad total: {total:.2f} MW")
print(f"📊 Capacidad promedio: {promedio:.2f} MW")
```

## ✅ Pregunta 2: Distribución por tipo de proyecto
Realizamos la consulta desde python hacia la base de datos y de alli al ver el estilo de pregunta nos disponmos a realizar una grafica de pastel para ver cual tipo de energia se adapta mas al mercado.
```Python
query_tipo = """
SELECT p.capacidad, tp.nombre_tipo
FROM proyectos p
JOIN tipos_proyectos tp ON p.id_tipo = tp.id
"""
df_tipo = pd.read_sql(query_tipo, engine)

contribucion = df_tipo.groupby('nombre_tipo')['capacidad'].sum()
total = contribucion.sum()
contribucion_pct = (contribucion / total * 100).round(2)

print("\nDistribución por tipo de proyecto (% de capacidad):")
print(contribucion_pct)
```

## ✅ Pregunta 3: Correlación capacidad - inversión
Aca vemos como se correlaciona y el tipod e correlacion de la capacidad generada a la inverion realizada por eso generamos este tipode datos con una tendencia lineal.
```Python
query_corr = "SELECT capacidad, inversion_estimada_cop FROM proyectos"

df_corr = pd.read_sql(query_corr, engine)

correlacion = df_corr[['capacidad', 'inversion_estimada_cop']].corr().iloc[0, 1]
print(f"\n📈 Correlación capacidad - inversión: {correlacion:.2f}")
```

## ✅ Pregunta 4: Usuarios beneficiarios por departamento
Aca vemos como se benefician los diferentes departamentos con relacion a los proyectos ejecutados.
```Python
query_usuarios = """
SELECT d.departamento, SUM(p.usuarios) AS usuarios
FROM proyectos p
JOIN proyectos_municipios pm ON p.id = pm.id_proyecto
JOIN municipios m ON pm.id_municipio = m.id
JOIN departamentos d ON m.id_departamento = d.id
GROUP BY d.departamento
"""
df_usuarios = pd.read_sql(query_usuarios, engine)

print("\n👥 Usuarios beneficiarios por departamento:")
print(df_usuarios.sort_values(by='usuarios', ascending=False))
```
