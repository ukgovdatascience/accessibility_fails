
# Reproducibility stuff

library(checkpoint)
#checkpoint('2016-08-22')
setSnapshot('2016-08-22')

library(dplyr)
library(readr)
library(digest)
library(magrittr)

source('tools.R')

fails_data <- 'accessibility_fail_data.csv' %>%
  read_csv %>%  
  dplyr::select(
    -WCAG_Level
  )
  
error_found <- fails_data1 %>%
  dplyr::mutate_each(
    funs = funs(binarise(.,'error_found')),
    2:11
  )

c2 <-
  


rowsums_ <- combn(2:11, 2, FUN = get_row_sums, simplify = TRUE)
rowsums_totals <- colSums(rowsums_)


rowSums(error_found)

