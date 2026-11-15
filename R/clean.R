# Private helpers: build the clean data frame from the raw columns

is_birth_date <- function(x) {
  grepl("^[0-9]{8}$", x)
}

years_between <- function(from, to) {
  as.numeric(difftime(to, from, units = "days")) / 365.25
}

# Female files give the opponent's date of birth; male files give the age
opponent_age <- function(raw_value, match_date) {
  from_dob <- years_between(as.Date(raw_value, format = "%Y%m%d"), match_date)
  from_age <- suppressWarnings(as.numeric(raw_value))
  ifelse(is_birth_date(raw_value), from_dob, from_age)
}

select_match_columns <- function(raw, player_dob, player_name) {
  match_date <- as.Date(raw[[1]], format = "%Y%m%d")
  data.frame(
    player        = player_name,
    date          = match_date,
    tournament    = raw[[2]],
    surface       = raw[[3]],
    round         = raw[[9]],
    result        = raw[[5]],
    score         = raw[[10]],
    opponent      = raw[[12]],
    opponent_rank = suppressWarnings(as.integer(raw[[13]])),
    opponent_age  = opponent_age(raw[[17]], match_date),
    player_age    = years_between(player_dob, match_date),
    stringsAsFactors = FALSE
  )
}

add_age_difference <- function(matches) {
  matches$age_diff <- matches$opponent_age - matches$player_age
  matches
}

clean_career_js <- function(js_text, player_dob, player_name) {
  raw <- parse_matches(js_text)
  matches <- select_match_columns(raw, player_dob, player_name)
  matches <- add_age_difference(matches)
  matches[order(matches$date), ]
}
