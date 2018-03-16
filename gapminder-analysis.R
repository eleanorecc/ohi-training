## gapminder-analysis.R
## analysis with gapminder data
## Ellie Campbell eleanorecampbell@ucsb.edu

## load libraries
library(tidyverse)
library(ggplot2)

## read in gapminder data
gapminder <- readr::read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/gapminder.csv')

# group_by() in dplyr is good for automating through groups but is no good for things like plotting...
# so, need to use a for loop!

# ex with one country
gap_to_plot <- gapminder %>% 
  filter(country == "Afghanistan")

my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpPercap)) + 
  geom_point() +
  labs(x = ("Year"), y = "GDP per Capita", title = paste("Afghanistan", "GDP per Capita", sep = " ")) +
  theme_bw()

ggsave(filename = "images/afghanistan_gdpPercap.png", plot = my_plot)
