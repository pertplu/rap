% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zest_join.R
\name{zest_join}
\alias{zest_join}
\title{zest join}
\usage{
zest_join(x, y, ...)
}
\arguments{
\item{x}{a tibble}

\item{y}{another tibble}

\item{...}{named predicate formulas

The rhs of the formulas is used y \code{\link[dplyr:filter]{dplyr::filter()}} on \code{y} for each row of \code{x}.
\itemize{
\item Literal column names refer to columns of \code{y}. Alternatively you can use \code{.data$}.
\item To use the current value for a column of \code{x} you can use unquoting, e.g. \code{!!cyl}
}}
}
\value{
a tibble that contains all columns and rows of \code{x}, plus an additional list column per formula:
\itemize{
\item its name is given by the name of the formula
\item each element of the column is a tibble
\item each of the tibbles is a subset of \code{y} according to the rhs of the formula
}
}
\description{
a zest join is similar to a \code{\link[dplyr:nest_join]{dplyr::nest_join()}} but the rows of \code{y} that are
included in the list column are controlled by a predicate.
}
\examples{

tbl <- tibble::tibble(cyl = c(4, 6, 8), mpg = c(30, 25, 20))

# zest join of tbl and mtcars
# - the created column is called `data`
# - each element of the data column is the result of filter(mtcars, cyl == !!cyl & mpg < !!mpg)
#    - `cyl` and `mpg` refer to columns of `y`
#    - `!!cyl` and `!!mpg` refer to the current
tbl \%>\%
  zest_join(mtcars, data = ~cyl == !!cyl & mpg < !!mpg)

# similar to
tbl \%>\%
  rap(data = ~filter(mtcars, cyl == !!cyl & mpg < !!mpg))

# multiple zest
tbl \%>\%
  zest_join(mtcars,
    one = ~cyl == !!cyl & mpg < !!mpg,
    two = ~cyl <  !!cyl & mpg > !!mpg
  )

}
