#' Get a reading order for Země v roce 40 000
#'
#' @param openings Include the opening text of each chapter.
#' @param lables Include chapter labels. The spelling follows the original
#'   interface.
#' @param save Write a UTF-8 tab-separated text file in the current working
#'   directory, or to `file` if supplied.
#' @param print Print the resulting table to the console.
#' @param file Optional output path used when `save = TRUE`.
#' @return A data frame in reading order. `str` is the page number.
#' @export
contentsChronological <- function(openings = TRUE, lables = FALSE,
                                  save = TRUE, print = TRUE, file = NULL) {
  .contents(.chapters, openings, lables, save, print, file,
            "contentsChronological.txt")
}

#' @rdname contentsChronological
#' @export
contentsKairological <- function(openings = TRUE, lables = FALSE,
                                save = TRUE, print = TRUE, file = NULL) {
  .contents(.chapters[.kairological_index, , drop = FALSE], openings,
            lables, save, print, file, "contentsKairological.txt")
}

#' @rdname contentsChronological
#' @param seet Integer seed for the random reading order. The spelling follows
#'   the original interface. The caller's random-number state is restored.
#' @export
contentsRandom <- function(openings = TRUE, lables = FALSE,
                           save = TRUE, print = TRUE, seet = 55, file = NULL) {
  if (!is.numeric(seet) || length(seet) != 1L || is.na(seet) ||
      !is.finite(seet) || seet < -2147483647 || seet > 2147483647 ||
      seet != trunc(seet)) {
    stop("`seet` must be one finite integer.", call. = FALSE)
  }
  had_seed <- exists(".Random.seed", envir = .GlobalEnv, inherits = FALSE)
  if (had_seed) old_seed <- get(".Random.seed", envir = .GlobalEnv)
  on.exit({
    if (had_seed) {
      assign(".Random.seed", old_seed, envir = .GlobalEnv)
    } else if (exists(".Random.seed", envir = .GlobalEnv,
                      inherits = FALSE)) {
      rm(".Random.seed", envir = .GlobalEnv)
    }
  })
  set.seed(as.integer(seet))
  order <- sample.int(nrow(.chapters))
  .contents(.chapters[order, , drop = FALSE], openings, lables, save,
            print, file, "contentsRandom.txt")
}

#' Chapter descriptions
#'
#' @return A data frame with the chapter label and its short description in
#'   chronological order. Missing descriptions are represented by `NA`.
#' @export
chapterDescriptions <- function() {
  .chapters[c("label", "descript")]
}

.contents <- function(chapters, openings, lables, save, print, file,
                      default_file) {
  for (nm in c("openings", "lables", "save", "print")) {
    value <- get(nm)
    if (!is.logical(value) || length(value) != 1L || is.na(value)) {
      stop(sprintf("`%s` must be TRUE or FALSE.", nm), call. = FALSE)
    }
  }
  columns <- c(if (lables) "label", if (openings) "opening", "str")
  result <- chapters[columns]
  rownames(result) <- NULL
  if (save) {
    if (is.null(file)) file <- default_file
    if (!is.character(file) || length(file) != 1L || is.na(file) ||
        !nzchar(file)) {
      stop("`file` must be one nonempty path.", call. = FALSE)
    }
    utils::write.table(result, file = file, sep = "\t", row.names = FALSE,
                       col.names = TRUE, quote = TRUE, na = "",
                       fileEncoding = "UTF-8")
  }
  if (print) base::print(result, row.names = FALSE)
  invisible(result)
}
