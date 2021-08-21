if(!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               tidytext,
               rvest,
               here)



url <- "https://www.constituteproject.org/constitutions?lang=es"

## Paso 1 --------

enlaces <- read_html(url) %>% 
  html_nodes("a") %>% 
  html_attr('href') %>% 
  tibble(direccion=.) %>% 
  filter(str_detect(direccion, "constitution\\/[a-zA-Z]+")) %>% 
  mutate(nombres = str_extract(direccion, "(?<=constitution\\/)(.*)(?=\\?)")) %>% 
  mutate(direccion = str_c("https://www.constituteproject.org", direccion)) %>% 
  select(nombres, direccion)

## Paso 2 ----

txt <- lapply(enlaces$direccion[1:2], function(url){
 art <-  tryCatch(
    url %>%
      as.character() %>% 
      read_html() %>% 
      html_nodes('.float-left , p') %>% 
      html_text() %>% 
      tibble(), 
    error = function(e){NA}    # a function that returns NA regardless of what it's passed
  )
})


txt.list <- txt %>% 
  bind_rows()
  
