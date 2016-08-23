
# Reproducibility stuff

library(checkpoint)
setSnapshot('2016-08-22')



library(dplyr)
library(readr)
library(digest)
library(magrittr)
library(ggplot2)

source('tools.R')


fails_data <- 'accessibility_fail_data.csv' %>%
  read_csv %>%  
  dplyr::select(
    -WCAG_Level
  )

tool_names <- names(fails_data)[-1]
fails_data$`Google_Accessibility_Developer_Tools_/AccessLint` %>% unique

output <- 2:10 %>%
  purrr::map_df(
    ~ foobar(x = .x, 'error_found'), 
    .id = "n_tools"
  ) %>%
  set_colnames(
    c('n_tools', 'score', 'tools')
  ) %>%
  tidyr::separate(
    tools,
    into = as.character(1:10)
  ) %>%
  as_data_frame

output %>%
  group_by(n_tools) %>%
  summarise(
    max = max(score)
  ) %>%
  ggplot + 
  aes(
    x = n_tools,
    y = max,
    group = 1
  ) +
  geom_line() +
  xlab('Number of tools used') +
  ylab('Total number of fails identified') +
  ggtitle('Error found')

