bubba <- list(first="one", second="two", third="third")
class(bubba) <- append(class(bubba),"Flamboyancy")

GetFirst <- function(x)
{
  UseMethod("GetFirst",x)
}

GetFirst.Flamboyancy <- function(x)
{
  return(x$first)
}

GetFirst(bubba)