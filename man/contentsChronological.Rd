\name{contentsChronological}
\alias{contentsChronological}
\alias{contentsKairological}
\alias{contentsRandom}
\title{Get a reading order for Země v roce 40 000}
\usage{
contentsChronological(openings = TRUE, lables = FALSE, save = TRUE,
  print = TRUE, file = NULL)
contentsKairological(openings = TRUE, lables = FALSE, save = TRUE,
  print = TRUE, file = NULL)
contentsRandom(openings = TRUE, lables = FALSE, save = TRUE,
  print = TRUE, seet = 55, file = NULL)
}
\arguments{
\item{openings}{Include chapter opening text.}
\item{lables}{Include chapter labels. This spelling follows the requested interface.}
\item{save}{Write a UTF-8 tab-separated text file.}
\item{print}{Print the resulting table to the console.}
\item{file}{Optional path for the saved file. By default, each function writes its own named .txt file in the working directory.}
\item{seet}{Integer seed for the random order. This spelling follows the requested interface. The caller's random-number state is restored.}
}
\value{Invisibly returns a data frame in reading order, with selected columns and the page number \code{str}.}
\description{Returns chronological, kairological, or reproducibly shuffled chapter contents.}
\details{The kairological order reproduces the current preparation script, including its repeated \sQuote{Wheeler volá Feynmanovi} and omitted \sQuote{Kami Suki 2}.}
\examples{
contentsChronological(save = FALSE, print = FALSE)
contentsKairological(openings = FALSE, lables = TRUE,
  save = FALSE, print = FALSE)
contentsRandom(seet = 55, save = FALSE, print = FALSE)
}
