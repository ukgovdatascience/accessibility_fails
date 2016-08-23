binarise <- function(x, case) {
  
  case <- paste0(case, collapse = '|')
  ifelse(grepl(case, x), 1 , 0)
  
}

library(testthat)

test_that(
  'Binarise function works as expected',
  {
    expect_identical(
      binarise(c('error_found','error_found','error_found'), 'error_found'),
      c(1,1,1)
    )
    expect_identical(
      binarise(c('not_found','error_found','error_found'), 'error_found'),
      c(0,1,1)
    )
    expect_identical(
      binarise(c('not_found','error_found','other'), c('error_found', 'not_found')),
      c(1,1,0)
    )
  }
)


get_row_sums <- function(x) {
  
  y = rowSums(error_found[,unlist(x)])

}