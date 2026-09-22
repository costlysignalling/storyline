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
#'   is supplied, the caller's random-number state is restored. Unless `file`
#'   is supplied, a saved file includes the seed in its name.
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
  default_file <- if (is.na(seed)) "contentsRandom.txt" else
    sprintf("contentsRandom%d.txt", as.integer(seed))
  .contents(.chapters[order, , drop = FALSE], openings, labels, save,
            print, file, default_file)
}

#' Get a contributed reading order
#'
#' A named order is registered by adding a UTF-8 text file with one chapter
#' label per line at `inst/orders/<name>.txt` in the package source. For a
#' proposal that has not yet been included in the package, supply `order_file`.
#' Chapter labels may appear more than once.
#'
#' @param name Order name, using lowercase letters, numbers, hyphens or
#'   underscores and starting with a letter or number.
#' @param order_file Optional path to a local UTF-8 text file of chapter labels,
#'   one per line. If omitted, the installed named order is used.
#' @inheritParams contentsChronological
#' @return A data frame in the suggested reading order. `str` is the page number.
#' @export
contentsNew <- function(name, openings = TRUE, labels = FALSE,
                        save = TRUE, print = TRUE, language = "Czech",
                        file = NULL, order_file = NULL) {
  .check_language(language)
  if (!is.character(name) || length(name) != 1L || is.na(name) ||
      !grepl("^[a-z0-9][a-z0-9_-]*$", name)) {
    stop("`name` must start with a lowercase letter or number and contain only lowercase letters, numbers, hyphens or underscores.",
         call. = FALSE)
  }
  if (is.null(order_file)) {
    order_file <- system.file("orders", paste0(name, ".txt"),
                              package = "storyline")
    if (!nzchar(order_file)) {
      stop(sprintf("No registered order named '%s'. Supply `order_file` to try a proposal.", name),
           call. = FALSE)
    }
  }
  if (!is.character(order_file) || length(order_file) != 1L ||
      is.na(order_file) || !nzchar(order_file) || !file.exists(order_file)) {
    stop("`order_file` must be an existing text file.", call. = FALSE)
  }
  con <- base::file(order_file, open = "r", encoding = "UTF-8")
  on.exit(close(con))
  proposed <- readLines(con, warn = FALSE)
  if (!length(proposed) || anyNA(proposed) || any(!nzchar(proposed))) {
    stop("The order file must contain one or more nonempty chapter labels, one per line.",
         call. = FALSE)
  }
  positions <- match(proposed, .chapters$label)
  if (anyNA(positions)) {
    stop("The order file contains a chapter label not found in this package.",
         call. = FALSE)
  }
  .contents(.chapters[positions, , drop = FALSE], openings, labels, save,
            print, file, paste0("contentsNew_", name, ".txt"))
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
