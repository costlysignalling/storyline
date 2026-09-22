\name{contentsChronological}
\alias{contentsChronological}
\alias{contentsKairological}
\alias{contentsRandom}
\title{Get a reading order for MONSTRUM}
\usage{
contentsChronological(openings = TRUE, labels = FALSE, save = TRUE,
  print = TRUE, language = "Czech", file = NULL)
contentsKairological(openings = TRUE, labels = FALSE, save = TRUE,
  print = TRUE, language = "Czech", file = NULL)
contentsRandom(openings = TRUE, labels = FALSE, save = TRUE,
  print = TRUE, seed = NA, language = "Czech", file = NULL)
}
\arguments{
\item{openings}{Include chapter opening text.}
\item{labels}{Include chapter labels.}
\item{save}{Write a UTF-8 tab-separated text file.}
\item{print}{Print the resulting table to the console.}
\item{language}{Language of the contents. Currently only \code{"Czech"} is available.}
\item{file}{Optional path for the saved file. By default, each function writes its own named .txt file in the working directory.}
\item{seed}{Integer seed for a reproducible random order. With the default \code{NA}, each call uses the current random-number state. When a seed is supplied, the caller's random-number state is restored. Unless \code{file} is supplied, a saved file includes the seed in its name, for example \file{contentsRandom55.txt}.}
}
\value{Invisibly returns a data frame in reading order, with selected columns and the page number \code{str}.}
\description{Returns chronological, kairological, or reproducibly shuffled chapter contents.}
\examples{
contentsChronological(save = FALSE, print = FALSE)
contentsKairological(openings = FALSE, labels = TRUE,
  save = FALSE, print = FALSE)
contentsRandom(seed = 55, save = FALSE, print = FALSE)
}
