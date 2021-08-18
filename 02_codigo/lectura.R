# Primera sesión ACT: Leer archivos ----

# Autor: MT
# Fecha:
# Título: 

if(!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               tidytext,
               tm,
               gutenbergr,
               readtext,
               epubr,
               here)


## Datos --------------

amlo <- readtext("01_datos/politica/Hacia una economía moral.pdf")

fecal <- epub("01_datos/politica/Decisiones difíciles.epub")

fecal.txt <- fecal$data[[1]]

enriquez_fuego <- epub("01_datos/literatura/Las cosas que perdimos en el fuego by Enríquez, Mariana (z-lib.org).epub")


## Limpieza --------------

amlo_limpio <- amlo %>% 
  tibble() %>% 
  mutate(text = str_replace_all(text, "\\n", " "),
         text = str_remove_all(text, "[^a-zA-ZáéíóúAÉÍÓÚñÑ., ]"),
         text = str_squish(text))

fecal_limpio <- fecal.txt %>% 
  tibble() %>% 
  mutate(text = str_replace_all(text, "\\n", " "),
         text = str_remove_all(text, "[^a-zA-ZáéíóúAÉÍÓÚñÑ ]"),
         text = str_squish(text))


enriquez_limpio <- enriquez_fuego %>% 
  unnest(data) %>% 
  filter(str_detect(section, "Section")) %>% 
  tibble() %>% 
  mutate(text = str_replace_all(text, "\\n", " "),
         text = str_remove_all(text, "[^a-zA-ZáéíóúAÉÍÓÚñÑ ]"),
         text = str_squish(text))


### Función --------

# fnc = function(data, col) {
#   col = enquo(col)
#   data %>% 
#     mutate(text = str_replace_all(!!col, "\\n", " "),
#            text = str_remove_all(!!col, "[^a-zA-ZáéíóúAÉÍÓÚñÑ ]"),
#            text = str_squish(!!col))
# }
# 
# fnc(fecal.txt, text)


## Frecuencias ------


enriquez_tokens <- enriquez_limpio %>% 
  unnest_tokens(tokens, text) %>% 
  count(tokens) %>% 
  arrange(-n) %>% 
  filter(!tokens %in% tm::stopwords("es")) 


amlo_tokens <- amlo_limpio %>% 
  unnest_tokens(tokens, text) %>% 
  count(tokens) %>% 
  arrange(-n) %>% 
  filter(!tokens %in% tm::stopwords("es")) 


fecal_tokens <- fecal_limpio  %>% 
  unnest_tokens(tokens, text) %>% 
  count(tokens) %>% 
  arrange(-n) %>% 
  filter(!tokens %in% tm::stopwords("es")) 
