

acc_fail <- setClass(
  
  # Set name of the class
  'acc_fail',
  
  # Define the slots
  slots = c(
    raw = "data.frame",
    bin = "data.frame"
  ),
  
  # Set the default values for the slots. (optional)
  # prototype=list(
  #   x = 0.0,
  #   y = 0.0
  # ),
  
  # Make a function that can test to see if the data is consistent.
  # This is not called if you have an initialize function defined!
  validity = function(object)
  {
    if(!is.data.frame(object@raw) || !is.data.frame(object@bin)) {
      return("Raw and binary must be dataframes.")
    }
    return(TRUE)
  }
)

# Define function for class
# Set generic method to reserve name

setGeneric(
  'bla', 
  function(object) standardGeneric('bla')
  )

# Set method

setMethod(
  'bla', 
  signature('acc_fail'), 
  function(object) {
    
    object@bin = object@raw %>%
      dplyr::mutate_each(
        funs = funs(binarise(.,'error_found')),
        2:11
      )
    
    
  })

