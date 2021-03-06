% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nassqs.R
\name{nassqs_check}
\alias{nassqs_check}
\title{Check the request.}
\usage{
nassqs_check(req)
}
\arguments{
\item{req}{request result returned from quickstats}
}
\value{
parsed request result as json
}
\description{
Check that the request is valid, i.e. that it doesn't exceed 50,000 records and that all the parameter values are valid. This is helpful for checking a query before submitting it so that you don't have to wait for the query to fail.
}
