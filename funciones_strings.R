# Título: Las 5 funciones del tidyverse
# Fecha: 21 de agosto de 2021


## Ctrl + Shift + R


# 1. Bibliotecas ----------------------------------------------

install.packages("pacman")
install.packages("tidyverse")
install.packages("readxl")
#library(tidverse)
#library(readxl)


pacman::p_load(tidyverse, readxl)

# 2. Datos ----------------------------------------------------

textos <- read_excel("01_datos/tablas/baseDatosCandidatos.xls")


glimpse(textos)


# 3. 5 funciones del tidyverse --------------------------------

## 3.1 filter -----------------------------------------------------------------

## ¿Cómo identifico a aquellas candidatas que toquen el tema de las drogas?

drogas <- textos %>% # Ctrl + Shift + M
  mutate(propuestas.completas = str_c(PROPUESTA_1, # Pegar cadenas de texto
                                      PROPUESTA_2, 
                                      PROPUESTA_GENERO,
                                      sep = " ")) %>% 
  filter(str_detect(propuestas.completas, "droga(s)|DROGA(s)|Droga(s)")) #REGEX, | = ó
  

str_view(drogas$propuestas.completas[6], "droga(s)|DROGA(s)|Droga(s)")


infancias_trans <- textos %>% # Ctrl + Shift + M
  mutate(propuestas.completas = str_c(PROPUESTA_1, # Pegar cadenas de texto
                                      PROPUESTA_2, 
                                      PROPUESTA_GENERO,
                                      sep = " ")) %>% 
  filter(str_detect(propuestas.completas, "infancias.*?trans"))

str_view(infancias_trans$propuestas.completas, "infancias.*?trans")


## 3.2 select -----------------------------------------------------------

textos %>% 
  select(PARTIDO_COALICION, PROPUESTA_1, PROPUESTA_2, 
         PROPUESTA_GENERO) 

textos %>% 
  select(matches("\\bPROPUESTA"))


recorte <- textos %>% 
  select(starts_with("PROPUESTA"))

## 3.3 mutate ---------------------------------------------------------------

minus <- textos %>% 
  mutate(propuesta_gen_min = str_to_lower(PROPUESTA_GENERO)) %>% # convertir a minúscula
  mutate(propuesta_gen_min = str_replace_all(propuesta_gen_min, "[^a-záéíóúüñ1-9]", " ")) %>% 
  mutate(propuesta_gen_min = str_squish(propuesta_gen_min))




#minus <- textos %>% 
 # mutate(propuesta_gen_min = str_to_lower(PROPUESTA_GENERO)) %>% # convertir a minúscula
#  mutate(propuesta_gen_min = str_remove_all(propuesta_gen_min, "[^a-záéíóúüñ1-9]"))


ej <- "    aire

fuego

eternidad   "

str_squish(ej)
