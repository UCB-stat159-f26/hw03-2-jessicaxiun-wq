test_that("female file: opponent age is derived from date of birth", {
  df <- clean_career_js(female_js, female_dob, "Test Player")
  expect_equal(nrow(df), 3)
  expect_lt(abs(df$opponent_age[1] - 18.78), 0.01)
  expect_lt(abs(df$player_age[1] - 15.83), 0.01)
  expect_lt(abs(df$age_diff[1] - 2.95), 0.02)
})

test_that("male file: opponent age is used as given", {
  df <- clean_career_js(male_js, male_dob, "Test Player")
  expect_equal(df$opponent_age[1], 22.264202601, tolerance = 1e-6)
  expect_equal(df$age_diff, df$opponent_age - df$player_age)
})

test_that("clean data has the expected columns and types", {
  df <- clean_career_js(male_js, male_dob, "Test Player")
  expect_named(df, c("player", "date", "tournament", "surface", "round",
                     "result", "score", "opponent", "opponent_rank",
                     "opponent_age", "player_age", "age_diff"))
  expect_s3_class(df$date, "Date")
  expect_type(df$opponent_rank, "integer")
  expect_equal(df$result, c("L", "L", "W"))
  expect_false(is.unsorted(df$date))
})
