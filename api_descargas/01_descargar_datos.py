import requests
import pandas as pd
import os

# URL de la API
url = "https://www.datos.gov.co/resource/vy9n-w6hc.json"

# Carpeta de destino
carpeta_destino = "C:/Users/Asus/Documents/data analysis/Portafolio/fncer_energia_colombia/datasets_originales"
os.makedirs(carpeta_destino, exist_ok=True)

# Solicitud a la API
response = requests.get(url)
data = response.json()

# Convertir a DataFrame
df = pd.DataFrame(data)

# Guardar como CSV
archivo_salida = os.path.join(carpeta_destino, "fncer_datos_generacion.csv")
df.to_csv(archivo_salida, index=False, encoding='utf-8-sig')

print(f"👍Datos guardados correctamente en: {archivo_salida}")
