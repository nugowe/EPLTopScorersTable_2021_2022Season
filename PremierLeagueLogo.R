
library(hrbrthemes)
library(tidyverse)
library(magick)

PremierLeaguelogo <- image_read_svg("https://upload.wikimedia.org/wikipedia/en/f/f2/Premier_League_Logo.svg")

grid::grid.raster(PremierLeaguelogo, x = 0.55, y = 0.03, just = c('left', 'bottom'), width = unit(1, 'inches'))