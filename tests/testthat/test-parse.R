test_that("female JS is parsed into raw rows", {
  raw <- parse_matches(female_js)
  expect_equal(nrow(raw), 3)
  expect_equal(raw[[12]], c("Anne Miller", "Alexia Dechaume Balleret", "Magui Serna"))
  expect_equal(raw[[17]][1], "19770119")
})

test_that("male JS is parsed into raw rows", {
  raw <- parse_matches(male_js)
  expect_equal(nrow(raw), 3)
  expect_equal(raw[[12]][3], "Israel Matos Gil")
  expect_equal(raw[[17]][1], "22.264202601")
})

test_that("text without match data gives a clear error", {
  expect_error(parse_matches("var foo = 1;"), "No match data")
})

test_that("has_match_data detects valid and invalid files", {
  expect_true(has_match_data(female_js))
  expect_false(has_match_data("<html>Not found</html>"))
  expect_false(has_match_data(NULL))
})

test_that("date of birth is extracted when present", {
  expect_equal(extract_dob("var dob = 19810926;"), as.Date("1981-09-26"))
  expect_true(is.na(extract_dob("var foo = 1;")))
  expect_true(is.na(extract_dob(NULL)))
})
