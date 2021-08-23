# Titulo: Lectura documentos y limpieza
# Fecha: 2021 - 08 - 21


# Bibliotecas -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

pacman::p_load(tidyverse, 
               tidytext, # herramientas de análisis de texto Julia Silge
               readtext, # Leer documentos en líneas
               epubr, # Leer document epub -- Calibre
               gutenbergr, 
               tm) # Text mining

# Datos -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

cronopios <- readtext("01_datos/literatura/cronopios_famas.pdf")

detectives <- readtext("01_datos/literatura/detectives.pdf")

cosas_fuego <- epub("01_datos/literatura/Las cosas que perdimos en el fuego by Enríquez, Mariana (z-lib.org).epub")

cosas_fuego_txt <- cosas_fuego %>% 
  unnest(data)



# Operaciones -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
head(cronopios$text, 1)

# Desanidar  los tokens
## Desanidar palabras para que cada palabra sea un token

  
cronopios %>% 
  tibble() %>% 
  mutate(text = str_remove_all(text, "\\bde\\b|\\bla\\b|\\blos\\b"))


x <- "Vine a Comala porque me dijeron que acá vivía mi padre, 
un tal Pedro Páramo. Mi madre me lo dijo. Y yo le prometí que vendría a verlo 
en cuanto ella muriera. Le apreté sus manos en señal de que lo haría, pues ella 
estaba por morirse y yo en un plan de prometerlo todo. 'No dejes de ir a visitarlo 
—me recomendó. Se llama de este modo y de este otro. 
Estoy segura de que le dará gusto conocerte.'"

stop_strig<- paste0(stopwords("es"), "\\b", collapse = "|\\b")

str_remove_all(x, stop_strig)

## Desanidar tokens -----------------------------------------------------------

lista_stopwords <- c(stopwords("es"), "si", "ojalá", "aquél", "así", "va", "dijo",
                     "dije", "vez", "después", "entonces","luego",
                     "sólo")

pal_cronopios <- cronopios %>% 
  tibble() %>% 
  unnest_tokens(tokens, text) %>% 
  count(tokens, sort = T) %>% 
  filter(!tokens %in% lista_stopwords) #filtres las palabras que no son stopwords


pal_detectives <- detectives %>% 
  tibble() %>% 
  unnest_tokens(palabras, text) %>% 
  count(palabras, sort = T) %>% 
  filter(!palabras %in% lista_stopwords)

pal_cosas_fuego <- cosas_fuego_txt %>% 
  tibble() %>% 
  select(section, text) %>% 
  unnest_tokens(palabras, text) %>% 
  count(palabras, sort = T) %>% 
  filter(!palabras %in% lista_stopwords)

## N-gramas -----------------------------

tri_cronopios <- cronopios %>% 
  tibble() %>% 
  unnest_tokens(bigram, text, token = "ngrams", n = 3) %>% 
  count(bigram, sort = T) %>% 
  separate(bigram, c("palabra1", "palabra2", "palabra3"), sep = " ")
  filter(!palabra1 %in% lista_stopwords)%>% 
  filter(!palabra2 %in% lista_stopwords) %>% 
  filter(!palabra3 %in% lista_stopwords)


### Ejercicio -------------------------
  
moral <- readtext("01_datos/politica/Hacia una economía moral.pdf")
  
fecal <- epub("01_datos/politica/Decisiones difíciles.epub") %>% 
  unnest(data) %>% 
  tibble()
  

## Tokens

palabras_moral <- moral %>% #Ctrl + shift + M
  tibble() %>% 
  unnest_tokens(palabras, text) %>% 
  count(palabras, sort = T) %>% 
  filter(!palabras %in% stopwords("es"))

## Bigramas

lista_stopwords <- c(stopwords("es"), "000")

bigram_amlo <- moral %>% #Ctrl + shift + M
  tibble() %>% 
  unnest_tokens(bigram, text, token = "ngrams", n = 2) %>% 
  count(bigram, sort = T) %>% 
  separate(bigram, c("palabra1", "palabra2"), sep = " ")  %>% 
  filter(!palabra1 %in% lista_stopwords) %>% 
  filter(!palabra2 %in% lista_stopwords)

  
  




palabras_fecal <- fecal %>% #Ctrl + shift + M
  tibble() %>% 
  unnest_tokens(palabras, text) %>% 
  count(palabras, sort = T) %>% 
  filter(!palabras %in% stopwords("es"))

## Bigramas

lista_stopwords <- c(stopwords("es"), "000")

bigram_fecal <- fecal %>% #Ctrl + shift + M
  tibble() %>% 
  unnest_tokens(bigram, text, token = "ngrams", n = 2) %>% 
  count(bigram, sort = T) %>% 
  separate(bigram, c("palabra1", "palabra2"), sep = " ")  %>% 
  filter(!palabra1 %in% lista_stopwords) %>% 
  filter(!palabra2 %in% lista_stopwords)




