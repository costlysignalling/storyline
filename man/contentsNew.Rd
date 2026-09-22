\name{contentsNew}
\alias{contentsNew}
\title{Get a contributed reading order}
\usage{
contentsNew(name, openings = TRUE, labels = FALSE, save = TRUE,
  print = TRUE, language = "Czech", file = NULL, order_file = NULL)
}
\arguments{
\item{name}{Order name, using lowercase letters, numbers, hyphens or underscores and starting with a letter or number.}
\item{openings}{Include chapter opening text.}
\item{labels}{Include chapter labels.}
\item{save}{Write a UTF-8 tab-separated text file.}
\item{print}{Print the resulting table to the console.}
\item{language}{Language of the contents. Currently only \code{"Czech"} is available.}
\item{file}{Optional output path used when \code{save = TRUE}. The default is \code{contentsNew_<name>.txt}.}
\item{order_file}{Optional path to a local UTF-8 text file of chapter labels, one per line. If omitted, the installed named order is used.}
}
\value{Invisibly returns a data frame in the suggested reading order, with selected columns and the page number \code{str}.}
\description{Loads a contributed reading order from an installed named file or a local proposal file.}
\details{A named order is registered by adding a UTF-8 text file with one chapter label per line at \file{inst/orders/<name>.txt} in the package source. Chapter labels may appear more than once.}
