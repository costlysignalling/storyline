# storyline

Reading orders for *MONSTRUM: Stručná zpráva o stavu příběhu v roce 52 000 ± 200 let*.

## Basics

Install from GitHub with:

```r
install.packages("remotes")
remotes::install_github("costlysignalling/storyline")
```

And run:

```r
library(storyline)
contentsRandom()
```

## Advanced use

```r
library(storyline)

contentsChronological(openings = TRUE, labels = FALSE,
                      save = TRUE, print = TRUE, language = "Czech")
contentsKairological(openings = TRUE, labels = FALSE,
                     save = TRUE, print = TRUE, language = "Czech")
contentsRandom(openings = TRUE, labels = FALSE,
               save = TRUE, print = TRUE, language = "Czech")

# Reproduce a particular random order and save it as contentsRandom55.txt:
contentsRandom(seed = 55, print = FALSE)

# Return a table without printing or saving it:
chapters <- contentsChronological(save = FALSE, print = FALSE)

# Save to a chosen location:
contentsRandom(print = FALSE, file = "my-reading-order.txt")
```

The functions return a data frame. With `print = TRUE`, they also display it
in the console. With `save = TRUE`, they write a UTF-8, tab-separated text
file with column headers in the current working directory:
`contentsChronological.txt`, `contentsKairological.txt`, or
`contentsRandom.txt`. When a seed is supplied, the default random filename
includes it, for example `contentsRandom55.txt`. A path passed through
`file` is used as given. The `str` column is the page number.

`contentsRandom()` generates a new order on each call. Set `seed` to an integer
to reproduce an order. Currently, `"Czech"` is the only available language.

To propose a new chapter order, [fork this repository](https://github.com/costlysignalling/storyline/fork).
All contributed orders belong in the repository's [`inst/orders` folder](inst/orders/).
See [example-ordering.txt](inst/orders/example-ordering.txt) in that folder for a complete example: it is a UTF-8 text file with **one chapter label per line**, in the suggested order, with no header or page numbers.

You can save the original labels as a starting point and rearrange the lines
on your computer:

```r
original <- contentsChronological(labels = TRUE, openings = FALSE,
                                  save = FALSE, print = FALSE)$label
write.table(original, "my-order.txt", row.names = FALSE,
            col.names = FALSE, quote = FALSE, fileEncoding = "UTF-8")
```

After rearranging the lines in `my-order.txt`, give the file an original,
descriptive name to avoid a clash with future contributions. For example,
`master-physics-centered-order.txt` is more distinctive. Names use lowercase
letters, numbers, hyphens and underscores. Repeating a label is allowed if it
is part of your order.

In your fork, open `inst/orders`, select **Add file → Upload files**, and
choose or drag in your prepared `master-physics-centered-order.txt`. You do
not need to type the labels in GitHub's editor. The filename becomes the
order name: after the file is merged and the package is updated,
`contentsNew("master-physics-centered-order")` loads it.

To try the file locally from the repository root before submitting it, run:

```r
contentsNew("master-physics-centered-order",
            order_file = "inst/orders/master-physics-centered-order.txt")
```

Commit the uploaded file in your fork, then select **Contribute → Open pull
request** to send your proposal here. The default saved output filename for
an accepted order is `contentsNew_master-physics-centered-order.txt`.

## Open the saved file in Excel

In Excel, select **File → Open → Browse**. Change the file type to
**All files**, select the saved `.txt` file (for example,
`contentsRandom.txt`), and select **Open**. If Excel asks for an encoding,
choose **UTF-8** unless it is already selected, then select **Open**.
