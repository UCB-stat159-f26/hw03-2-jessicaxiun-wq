# Private helpers: turn the raw JS text into a data frame of raw columns

extract_dob <- function(js_text) {
  if (is.null(js_text)) return(as.Date(NA))
  hit <- regmatches(js_text, regexec("dob\\s*=\\s*['\"]?([0-9]{8})", js_text))[[1]]
  if (length(hit) < 2) return(as.Date(NA))
  as.Date(hit[2], format = "%Y%m%d")
}

extract_match_blocks <- function(js_text) {
    pattern <- "(?s)matchmx\\s*=\\s*\\[\\s*\\[.*?\\]\\s*\\]"
  blocks <- regmatches(js_text, gregexpr(pattern, js_text, perl = TRUE))[[1]]
  if (length(blocks) == 0) stop("No match data found in the JS file.", call. = FALSE)
  sub("^[^\\[]*", "", blocks)
}

block_to_rows <- function(block) {
  rows <- jsonlite::fromJSON(block, simplifyVector = FALSE)
  lapply(rows, function(r) unlist(r)[seq_len(19)])
}

parse_matches <- function(js_text) {
  rows <- unlist(lapply(extract_match_blocks(js_text), block_to_rows), recursive = FALSE)
  as.data.frame(do.call(rbind, rows), stringsAsFactors = FALSE)
}
