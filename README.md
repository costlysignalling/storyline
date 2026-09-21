# storyline

Reading orders for *Země v roce 40 000*.

## Installation

Once this repository is published on GitHub, install with:

```r
install.packages("remotes")
remotes::install_github("costlysignalling/storyline")
```

## Use

```r
library(storyline)

contentsChronological(openings = TRUE, lables = FALSE,
                      save = TRUE, print = TRUE)
contentsKairological(openings = TRUE, lables = FALSE,
                    save = TRUE, print = TRUE)
contentsRandom(openings = TRUE, lables = FALSE,
               save = TRUE, print = TRUE, seet = 55)

# To return data without printing or saving:
chapters <- contentsChronological(save = FALSE, print = FALSE)

# To save to a chosen location:
contentsRandom(seet = 77, print = FALSE, file = "my-reading-order.txt")

# Optional short descriptions:
chapterDescriptions()
```

The returned value is a data frame (returned invisibly to avoid printing it
twice). Saved files are UTF-8, tab separated,
and have column headers. The `str` column is the page number. With the
defaults, files are saved in the current working directory as
`contentsChronological.txt`, `contentsKairological.txt`, or
`contentsRandom.txt`.

The argument spellings `lables` and `seet` follow the requested interface.
For random orders, using the same `seet` returns the same order without
changing the caller's random-number state.

The kairological order reproduces the source preparation script exactly.
That route includes “Wheeler volá Feynmanovi” twice and omits “Kami Suki 2”.

The package contains only the chapter labels, openings, page numbers,
descriptions, and the derived kairological order. It does not contain the
source Excel workbook or the other planning columns.
