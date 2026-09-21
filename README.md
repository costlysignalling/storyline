# storyline

Reading orders for *MONSTRUM: Stručná zpráva o stavu příběhu v roce 52 000 ± 200 let*.

## Installation

Install from GitHub with:

```r
install.packages("remotes")
remotes::install_github("costlysignalling/storyline")
```

## Use

```r
library(storyline)

contentsChronological(openings = TRUE, labels = FALSE,
                      save = TRUE, print = TRUE, language = "Czech")
contentsKairological(openings = TRUE, labels = FALSE,
                     save = TRUE, print = TRUE, language = "Czech")
contentsRandom(openings = TRUE, labels = FALSE,
               save = TRUE, print = TRUE, language = "Czech")

# Reproduce a particular random order:
contentsRandom(seed = 55, save = FALSE, print = FALSE)

# Return a table without printing or saving it:
chapters <- contentsChronological(save = FALSE, print = FALSE)

# Save to a chosen location:
contentsRandom(print = FALSE, file = "my-reading-order.txt")
```

The functions return a data frame. With `print = TRUE`, they also display it
in the console. With `save = TRUE`, they write a UTF-8, tab-separated text
file with column headers in the current working directory:
`contentsChronological.txt`, `contentsKairological.txt`, or
`contentsRandom.txt`. The `str` column is the page number.

`contentsRandom()` generates a new order on each call. Set `seed` to an integer
to reproduce an order. Currently, `"Czech"` is the only available language.

## Open a saved file in Microsoft Excel

In Excel, select **Data → From Text/CSV**, choose the saved `.txt` file, set
the file origin or encoding to **UTF-8** and the delimiter to **Tab**, then
select **Load**. Importing this way keeps the Czech characters and columns
separate. See [Microsoft's text import instructions](https://support.microsoft.com/en-us/excel/get-started/import-or-export-text-txt-or-csv-files).
