#' Get a reading order for MONSTRUM
#'
#' @param openings Include the opening text of each chapter.
#' @param labels Include chapter labels.
#' @param save Write a UTF-8 tab-separated text file in the current working
#'   directory, or to `file` if supplied.
#' @param print Print the resulting table to the console.
#' @param language Language of the contents. Currently only `"Czech"` is
#'   available.
#' @param file Optional output path used when `save = TRUE`.
#' @return A data frame in reading order. `str` is the page number.
#' @export
contentsChronological <- function(openings = TRUE, labels = FALSE,
                                  save = TRUE, print = TRUE,
                                  language = "Czech", file = NULL) {
  .check_language(language)
  .contents(.chapters, openings, labels, save, print, file,
            "contentsChronological.txt")
}

#' @rdname contentsChronological
#' @export
contentsKairological <- function(openings = TRUE, labels = FALSE,
                                save = TRUE, print = TRUE,
                                language = "Czech", file = NULL) {
  .check_language(language)
  .contents(.chapters[.kairological_index, , drop = FALSE], openings,
            labels, save, print, file, "contentsKairological.txt")
}

#' @rdname contentsChronological
#' @param seed Integer seed for a reproducible random reading order. With the
#'   default `NA`, each call uses the current random-number state. When a seed
#'   is supplied, the caller's random-number state is restored.
#' @export
contentsRandom <- function(openings = TRUE, labels = FALSE,
                           save = TRUE, print = TRUE, seed = NA,
                           language = "Czech", file = NULL) {
  .check_language(language)
  if (length(seed) != 1L || !(is.numeric(seed) || is.logical(seed))) {
    stop("`seed` must be NA or one finite integer.", call. = FALSE)
  }
  if (is.na(seed)) {
    order <- sample.int(nrow(.chapters))
  } else {
    if (!is.numeric(seed) || !is.finite(seed) ||
        seed < -2147483647 || seed > 2147483647 || seed != trunc(seed)) {
      stop("`seed` must be NA or one finite integer.", call. = FALSE)
    }
    had_seed <- exists(".Random.seed", envir = .GlobalEnv,
                       inherits = FALSE)
    if (had_seed) old_seed <- get(".Random.seed", envir = .GlobalEnv)
    on.exit({
      if (had_seed) {
        assign(".Random.seed", old_seed, envir = .GlobalEnv)
      } else if (exists(".Random.seed", envir = .GlobalEnv,
                        inherits = FALSE)) {
        rm(".Random.seed", envir = .GlobalEnv)
      }
    })
    set.seed(as.integer(seed))
    order <- sample.int(nrow(.chapters))
  }
  .contents(.chapters[order, , drop = FALSE], openings, labels, save,
            print, file, "contentsRandom.txt")
}

.check_language <- function(language) {
  if (!identical(language, "Czech")) {
    stop("Only `language = \"Czech\"` is available.", call. = FALSE)
  }
}

.contents <- function(chapters, openings, labels, save, print, file,
                      default_file) {
  for (nm in c("openings", "labels", "save", "print")) {
    value <- get(nm)
    if (!is.logical(value) || length(value) != 1L || is.na(value)) {
      stop(sprintf("`%s` must be TRUE or FALSE.", nm), call. = FALSE)
    }
  }
  columns <- c(if (labels) "label", if (openings) "opening", "str")
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
