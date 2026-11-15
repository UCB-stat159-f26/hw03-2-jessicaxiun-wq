# Private helpers: turn a user-supplied name into the Tennis Abstract slug

clean_player_name <- function(player_name) {
  if (!is.character(player_name) || length(player_name) != 1) {
    stop("`player_name` must be a single character string.", call. = FALSE)
  }
  words <- strsplit(trimws(player_name), "\\s+")[[1]]
  words <- gsub("[^A-Za-z]", "", words)
  words <- words[nzchar(words)]
  if (length(words) == 0) stop("`player_name` is empty.", call. = FALSE)
  if (length(words) > 1) words <- tolower(words)
  paste0(toupper(substring(words, 1, 1)), substring(words, 2), collapse = "")
}

display_player_name <- function(clean_name) {
  gsub("([a-z])([A-Z])", "\\1 \\2", clean_name)
}

career_url <- function(clean_name) {
  paste0("https://www.tennisabstract.com/jsmatches/", clean_name, "Career.js")
}

bio_url <- function(clean_name) {
  paste0("https://www.tennisabstract.com/jsmatches/", clean_name, ".js")
}
