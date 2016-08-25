library(testthat)

# Binarise the fails dataframe according to criteria of interest

binarise <- function(x, case) {
  
  case <- paste0(case, collapse = '|')
  ifelse(grepl(case, x), 1 , 0)
  
}

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

# Get combinations and concatenate into a vector for naming the output dataframe.

get_combos <- function(x, n) {
  
  combos <- combn(x, n)
  
  out <- character(ncol(combos))
  
  for (i in 1:ncol(combos)) {
    
    out[i] <- Reduce(paste, combos[,i])   
    
  }
  return(out)
}

test_that(
  'get_combos function works as expected',
  {
    expect_identical(
      get_combos(1:3, 2),
      c("1 2","1 3","2 3")
    )
    expect_is(
      get_combos(1:3, 2),
      'character'
    )
  }
)

# Unlist the columns received from combn and use them to subset the df

get_row_sums <- function(x, df) {
  
  return(rowSums(df[,unlist(x)]))
  
}

# Rolled into a single function: 

foo <-  function(
  df, 
  term = 'error_found', 
  range = 2:11, 
  m = 2
) {
  
  df <- df %>%
    dplyr::mutate_each(
      funs = funs(binarise(., term)),
      2:11
    )
  
  # Calculate rowsums, and label columns
  # Get rowsums for all the possible combinations of tools
  
  rowsums_ <- combn(
    x = 2:11, 
    m = m, 
    FUN = function(x) get_row_sums(x, df = df)
  )
  
  # Where two or more tools both detect the same fault, this needs to be re-binarised
  
  rowsums_ <- ifelse(rowsums_ >= 1, 1, 0)
  
  # Now convert to a dataframe, and add colnames
  
  rowsums_ <- rowsums_ %>% 
    as_data_frame %>%
    set_colnames(
      get_combos(2:11, m)
    ) 
  
  # Add in key column here? This is not onerous, and gets in the way of 
  # some mutate operations, so excluded for now...
  
  # %>%
  #   mutate(
  #     Test_case = fails_data$Test_case
  #   )
  
  return(rowsums_)
}

# Wrap it all up for passing to map_df

foobar <- function(x, terms) {
  
  scores <- fails_data %>%
    foo(
      term = terms,
      m = x
    ) %>% 
    colSums %>%
    as.data.frame
  
  # dplyr::mutate throws an unexpected error here... so use base R instead
  
  scores$tools = rownames(scores)
  
  scaores <- scores %>%
    arrange(desc(.)) %>%
    as_data_frame 
  
  return(scores)
}

# Function to rename integers back to characters

argh <- function(x) {
  
  return(tool_names[x - 1])
  
}