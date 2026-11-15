# tennismatches

Get the career matches of a tennis player from [Tennis Abstract](https://www.tennisabstract.com)
and plot the age difference with each opponent.

## Installation

```r
# install.packages("pak")
pak::pak("jessicaxiun-wq/tennismatches")

# or
devtools::install_github("jessicaxiun-wq/tennismatches")
```

## Usage

```r
library(tennismatches)

serena <- get_player_matches("serena williams")
plot_player_matches(serena)

rafa <- get_player_matches("Rafael Nadal")
plot_player_matches(rafa)

# meaningful error message
get_player_matches("GastonSanchez")
```

## Functions

- `get_player_matches(player_name)`: downloads and cleans a player's career data.
- `plot_player_matches(player_data)`: scatter plot of player age vs. age difference with the opponent.

## Personal Reflections

Working on this assignment taught me how different building a package is from writing a one-off analysis script. I had to split the work into small, single-purpose private functions (none longer than 20 lines) and keep only two public functions, which made the code much easier to test and read. I learned to write tests against mock data instead of the live website, so my tests run fast and don't depend on the internet. The mock data also helped me understand the difference between the female and male career files: one gives the opponent's date of birth and the other gives the age directly, so I had to handle both. My unit tests all passed, but the first real download from Tennis Abstract still failed with "No match data found." The real file ended its data array slightly differently from my mock files (whitespace between the closing brackets), so my regular expression missed it. That showed me that passing tests on mock data doesn't guarantee the code works on real data, and that my mock data should look like the real files. 
