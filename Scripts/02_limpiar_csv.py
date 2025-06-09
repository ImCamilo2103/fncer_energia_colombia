import  pandas as pd
fname = 'C:/Users/Asus/Documents/data analysis/Portafolio/fncer_energia_colombia/datasets_originales/fncer_datos_generacion.csv'
df = pd.read_csv(fname, encoding="utf-8")
print(df.head())

# Limpia nombres de columnas y guarda
df.columns = (
    df.columns
    .str.strip()
    .str.replace(' ', '_')
    .str.replace(r'[^\w\s]', '', regex=True)
    .str.lower()
)

df.to_csv("C:/Users/Asus/Documents/data analysis/Portafolio/fncer_energia_colombia/datasets_originales/meta_fncer_clean.csv", index=False, encoding='utf-8')
