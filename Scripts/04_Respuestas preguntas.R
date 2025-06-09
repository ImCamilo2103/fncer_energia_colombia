library(DBI)
library(dplyr)

con <- dbConnect(RPostgreSQL::PostgreSQL(),
                 dbname ="proyectos",
                 host = "localhost",
                 port = 5432,
                 user = "postgres",
                 password = "Mom1012%")

df <- tbl(con, "proyectos") %>% collect()
total <- sum(df$capacidad)
promedio <- mean(df$capacidad)
cat(sprintf("Total; 🔋%.2f MW\nPromedio: 📊%.2f MW", total, promedio))


library(ggplot2)

df <- tbl(con, sql("
  SELECT p.capacidad, tp.nombre_tipo
  FROM proyectos p
  JOIN tipos_proyectos tp ON p.id_tipo = tp.id
")) %>% collect()

contribucion <- df %>%
  group_by(nombre_tipo) %>%
  summarise(total = sum(capacidad)) %>%
  mutate(porcentaje = total / sum(total) * 100)

ggplot(contribucion, aes(x = "", y = porcentaje, fill = nombre_tipo)) +
  geom_bar(stat = "identity") +
  coord_polar("y") +
  labs(title = "Distribución por Tipo de FNCER")

library(scales)

df <- tbl(con, "proyectos") %>% 
  select(capacidad, inversion_estimada_cop) %>% collect()

correlacion <- cor(df$capacidad, df$inversion_estimada_cop)
cat(sprintf("Correlación: %.2f", correlacion))

ggplot(df, aes(x = capacidad, y = inversion_estimada_cop)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_y_continuous(labels = dollar_format(prefix = "$")) +
  labs(title = "Relación Capacidad-Inversión")


library(DBI)
library(dplyr)
library(ggplot2)
df <- tbl(con, sql("
  SELECT d.departamento, SUM(p.usuarios) as usuarios
  FROM proyectos p
  JOIN proyectos_municipios pm ON p.id = pm.id_proyecto
  JOIN municipios m ON pm.id_municipio = m.id
  JOIN departamentos d ON m.id_departamento = d.id
  GROUP BY d.departamento
")) %>% collect()

ggplot(df, aes(x = reorder(departamento, usuarios), y = usuarios)) +
  geom_col() +
  coord_flip() +
  labs(title = "Beneficiarios por Departamento")

