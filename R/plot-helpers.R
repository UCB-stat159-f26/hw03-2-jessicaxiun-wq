# Private helpers for plot_player_matches()

check_plot_data <- function(player_data) {
  needed <- c("player", "player_age", "age_diff", "result")
  missing <- setdiff(needed, names(player_data))
  if (!is.data.frame(player_data) || length(missing) > 0) {
    stop("`player_data` must come from get_player_matches(); missing: ",
         paste(missing, collapse = ", "), call. = FALSE)
  }
  if (nrow(player_data) == 0) stop("`player_data` has no rows.", call. = FALSE)
}

result_color_scale <- function() {
  ggplot2::scale_color_manual(
    values = c(W = "#2b7bba", L = "#d9534f"),
    labels = c(W = "Won", L = "Lost"),
    name = NULL
  )
}

plot_labels <- function(player_data) {
  ages <- range(player_data$player_age, na.rm = TRUE)
  ggplot2::labs(
    title = paste0(player_data$player[1], "'s Professional Matches"),
    subtitle = sprintf("Age %d to %d", floor(ages[1]), ceiling(ages[2])),
    x = "Player's age",
    y = "Opponent's age minus player's age (years)",
    caption = "Source: Tennis Abstract"
  )
}
