#' Plot the career matches of a tennis player
#'
#' Scatter plot of the player's age (x) against the age difference with the
#' opponent (y), coloured by match result.
#'
#' @param player_data Data frame returned by [get_player_matches()].
#' @return A ggplot object.
#' @examples
#' \dontrun{
#' plot_player_matches(get_player_matches("Rafael Nadal"))
#' }
#' @export
plot_player_matches <- function(player_data) {
  check_plot_data(player_data)
  ggplot2::ggplot(player_data, ggplot2::aes(
    x = .data$player_age, y = .data$age_diff, color = .data$result
  )) +
    ggplot2::geom_hline(yintercept = 0, color = "grey40") +
    ggplot2::geom_point(alpha = 0.6, size = 2) +
    result_color_scale() +
    plot_labels(player_data) +
    ggplot2::theme_minimal()
}
