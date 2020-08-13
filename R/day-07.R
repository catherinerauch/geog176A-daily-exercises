# Catherine Rauch
# 8/13/2020
# Geog 176A Daily Assignment 07

url <- 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv' # read in COVID-19 data

covid <-  read_csv(url)
head(covid)

region = data.frame(state = state.name, region = state.region) # create new data.frame using state.name, state.region data


regioncovid <- covid %>%
  inner_join(region, by = c("state" = "state" )) # join data.frame to raw COVID data

covidbyregion <- regioncovid %>%
  group_by(date, region) %>%
  summarise(ncases = sum(cases), ndeaths = sum(deaths), .groups = 'drop') %>%  # calculate daily, cumulative cases and death by region
  pivot_longer(cols = c('ncases', 'ndeaths')) %>%  # pivot from wide to long
  ggplot(aes(x = date, y = value)) +
  geom_line(aes(col = region)) +
  facet_grid(name~region, scale = "free_y") +
  theme_linedraw() +
  theme(legend.position = "bottom") +
  theme(legend.position = "NA") +
  labs(title = "Cummulative Cases and Deaths: Region", y = "Daily Cumulative Count", x = "Date",
       caption = "Daily Exercise 07", subtitle = "COVID-19 Data: NY-Times" ) +
  theme(plot.subtitle = element_text(color = "gray50", face = "bold")) +
  theme(plot.caption  = element_text(color = "gray50", face = "italic")) + theme_grey()

png("covidbyregion.png")
print(covidbyregion)
dev.off()
