# Private helpers: talk to tennisabstract.com (never called in tests)

fetch_js <- function(url) {
  resp <- httr2::request(url) |>
    httr2::req_error(is_error = function(r) FALSE) |>
    httr2::req_perform()
  if (httr2::resp_status(resp) != 200) return(NULL)
  httr2::resp_body_string(resp)
}

has_match_data <- function(js_text) {
    !is.null(js_text) && grepl("matchmx\\s*=\\s*\\[\\s*\\[", js_text)
}

fetch_player_dob <- function(clean_name, career_js) {
  dob <- extract_dob(career_js)
  if (!is.na(dob)) return(dob)
  dob <- extract_dob(fetch_js(bio_url(clean_name)))
  if (is.na(dob)) {
    stop("Could not find the date of birth of '", clean_name, "'.", call. = FALSE)
  }
  dob
}
