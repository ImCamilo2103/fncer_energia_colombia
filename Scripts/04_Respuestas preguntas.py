# Cargar Modulos necesarios
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns       

# Conexion a PostgreSQL
from sqlalchemy import create_engine
engine = create_engine('postgresql://postgres:""@localhost:5432/""')

# Consulta: respuesta 1
query = """
SELECT capacidad FROM proyectos
"""
df = pd.read_sql(query, engine)

total = df['capacidad'].sum()
promedio = df['capacidad'].mean()
print(f"Total: 🔋 {total:.2f} MW\nPromedio: 📊 {promedio:.2f} MW")

# Consulta respuesta 2
query1 = """
SELECT p.capacidad, tp.nombre_tipo
FROM proyectos p
JOIN tipos_proyectos tp ON p.id_tipo = tp.id
"""

df = pd.read_sql(query1, engine)

contribucion = df.groupby('nombre_tipo')['capacidad'].sum()
total = contribucion.sum()
contribucion_pct = (contribucion/total * 100).round(2)

contribucion_pct.plot(kind='pie', autopct='%1.1f%%')
plt.title('Distribucion por Tipo de FNCER')
plt.show()

# Consulta 3 Relacion capacidas -inversion
query2 = "SELECT capacidad, inversion_estimada_cop FROM proyectos"
df = pd.read_sql(query2, engine)

correlacion = df[['capacidad', 'inversion_estimada_cop']].corr().iloc[0,1]
print(f"Correlación: {correlacion:.2f}")

sns.regplot(x='capacidad', y='inversion_estimada_cop', data=df)
plt.title('Relación Capacidad-Inversión')
plt.show()

# Consulta 4 Beneficiarios por departamento
query3 = """
SELECT d.departamento, SUM(p.usuarios) AS usuarios
FROM proyectos p
JOIN proyectos_municipios pm ON p.id = pm.id_proyecto
JOIN municipios m ON pm.id_municipio = m.id
JOIN departamentos d ON m.id_departamento = d.id
GROUP BY d.departamento
"""
df = pd.read_sql(query3, engine)

df.plot(kind='barh', x='departamento', y='usuarios')
plt.title('Beneficiarios por Departamento')
plt.show()