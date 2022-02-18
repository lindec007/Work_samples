library("dplyr")
library("ggplot2")
library("gapminder")

vikings <- gapminder %>% filter(country %in% c("Sweden", "Norway", "Netherlands", "New Zealand", "Switzerland"))

ggplot(vikings, aes(x = year, y = gdpPercap, color = country)) + geom_line()
vikings_gdp <- filter(vikings, year %in% c(1952, 2007)) %>% 
  arrange(desc(gdpPercap)) %>% 
  select(country, year, gdpPercap)

ggplot(vikings_gdp, aes(x = year, y = gdpPercap, color = country)) + geom_line()

ggplot(vikings, aes(x = year, y = lifeExp, color = country)) + geom_line() + ylab("Life Expectancy") + ggtitle("Life Expectancy in Five Countries")

gp_medians <- gapminder %>% group_by(year)%>%
  summarise(life_med = median(lifeExp))

vikings_medians <- vikings %>% group_by(year)%>%
  summarise(life_med = median(lifeExp))

gp_medians
vikings_medians

library(Ecdat)
head(Cigarette)
View(Cigarette)
            
            
            