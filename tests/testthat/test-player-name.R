test_that("different spellings give the same slug", {
  expect_equal(clean_player_name("serena williams"), "SerenaWilliams")
  expect_equal(clean_player_name("Serena Williams"), "SerenaWilliams")
  expect_equal(clean_player_name("SerenaWilliams"), "SerenaWilliams")
  expect_equal(clean_player_name("  RAFAEL   NADAL "), "RafaelNadal")
})

test_that("invalid names are rejected", {
  expect_error(clean_player_name(""), "empty")
  expect_error(clean_player_name(123), "single character")
  expect_error(clean_player_name(c("a", "b")), "single character")
})

test_that("display name and urls are built correctly", {
  expect_equal(display_player_name("SerenaWilliams"), "Serena Williams")
  expect_match(career_url("SerenaWilliams"), "jsmatches/SerenaWilliamsCareer\\.js$")
  expect_match(bio_url("SerenaWilliams"), "jsmatches/SerenaWilliams\\.js$")
})
