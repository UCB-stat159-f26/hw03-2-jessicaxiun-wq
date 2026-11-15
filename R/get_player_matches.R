#' Get the career matches of a tennis player
#'
#' Downloads the career file of a player from tennisabstract.com and returns
#' a clean data frame with one row per match.
#'
#' @param player_name Name of the player, e.g. `"serena williams"`,
#'   `"Serena Williams"` or `"SerenaWilliams"`.
#' @return A data frame with columns `player`, `date`, `tournament`,
#'   `surface`, `round`, `result`, `score`, `opponent`, `opponent_rank`,
#'   `opponent_age`, `player_age` and `age_diff` (opponent age minus player
#'   age, so positive means the opponent was older).
#' @examples
#' \dontrun{
#' serena <- get_player_matches("serena williams")
#' }
#' @export
get_player_matches <- function(player_name) {
  clean_name <- clean_player_name(player_name)
  career_js <- fetch_js(career_url(clean_name))
  if (!has_match_data(career_js)) {
    stop("Could not find career data for player '", player_name,
         "'. Check the spelling of the name.", call. = FALSE)
  }
  dob <- fetch_player_dob(clean_name, career_js)
  clean_career_js(career_js, dob, display_player_name(clean_name))
}
