test_that("get_player_matches returns clean data (no live server)", {
  local_mocked_bindings(
    fetch_js = function(url) if (grepl("Career", url)) female_js else "var dob = 19800101;"
  )
  df <- get_player_matches("serena williams")
  expect_equal(nrow(df), 3)
  expect_equal(unique(df$player), "Serena Williams")
})

test_that("unknown players give a meaningful error", {
  local_mocked_bindings(fetch_js = function(url) NULL)
  expect_error(get_player_matches("GastonSanchez"), "Could not find career data")
})

test_that("plot_player_matches returns a ggplot", {
  df <- clean_career_js(male_js, male_dob, "Test Player")
  expect_s3_class(plot_player_matches(df), "ggplot")
})

test_that("plot_player_matches validates its input", {
  expect_error(plot_player_matches(data.frame(x = 1)), "missing")
  expect_error(plot_player_matches("not a data frame"), "get_player_matches")
})
