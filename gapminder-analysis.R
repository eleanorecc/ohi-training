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

# cleaning up the code...

# create country variable and use
cntry <- "Afghanistan"
gap_to_plot <- gapminder %>% 
  filter(country == cntry)
my_plot <- ggplot(data = gap_to_plot, aes(year, gdpPercap)) +
  geom_point() +
  labs(x = ("Year"), y = "GDP per Capita", title = paste(cntry, "GDP per Capita", sep = " ")) +
  theme_bw()
ggsave(filename = paste(cntry, "gdpPercap.png", sep = ""), plot = my_plot)


# create new folder in current directory to hold output plots
if(!file.exists("programming_tutorial_plots")){dir.create("programming_tutorial_plots")}

# for loop

country_list <- as.list(unique(gapminder$country))
yvar <- "gdpPercap"
yvar_name <- "GDP per Capita"
plot_folder <- "programming_tutorial_plots"

for(cntry in country_list){
  
  gap_to_plot <- gapminder %>% filter(country == cntry)
  
  my_plot <- ggplot(data = gap_to_plot, aes(cntry, yvar)) +
    geom_point() +
    labs(x = "Year", y = yvar_name, title = paste(cntry, yvar_name, sep = " ")) +
    theme_bw()
  
  ggsave(filename = paste(plot_folder, paste(cntry, paste(yvar, "png", sep = "."), sep = "_"), sep = "/"), plot = my_plot)
  
  print(paste("created plot for", cntry, sep = " "))
  
}

# loop modified to create plots just of countries in Europe

if(!file.exists("./programming_tutorial_plots/figures_europe")){dir.create("./programming_tutorial_plots/figures_europe")}

gap_cntry_europe <- gapminder %>% 
  filter(continent == "Europe")
country_europe <- as.list(unique(gap_cntry_europe$country))

yvar <- "cummean_gdpPercap"
yvar_name <- "Cumulative Mean GDP per Capita"
plot_folder <- "./programming_tutorial_plots/figures_europe"

for(cntry in country_europe){
  gap_to_plot <- gapminder %>% 
    filter(continent == "Europe" & country == cntry) %>% 
    mutate(cummean_gdpPercap = cummean(gdpPercap))
  
  my_plot <- ggplot(data = gap_to_plot, aes(year, cummean_gdpPercap)) +
    geom_point() +
    labs(x = "Year", y = yvar_name, title = paste(cntry, yvar_name, sep = " ")) +
    theme_bw()
  
  ggsave(filename = paste(plot_folder, paste(cntry, paste(yvar, "png", sep = "."), sep = "_"), sep = "/"), plot = my_plot)
  print(paste("created and saved plot for", cntry, sep = " "))
}





































