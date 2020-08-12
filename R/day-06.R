# Catherine Rauch
# 8/11/2020
# daily assignment 6

#read in COVID-19 data from URL

url <- 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid <-  read_csv(url)

head(covid)

plotbystate <- covid %>%
  group_by(state, date) %>%
  summarise(ncases = sum(cases), .groups = 'drop') %>%
  filter(state %in% c('California', 'Florida', 'Texas', 'New York', 'Georgia', 'Illinois' )) %>%
  ggplot(aes(x = date, y = ncases)) + geom_line(aes(col = state)) + labs(title = "Cummulative Case Counts: COVID-19 Pandemic",
     x = "Date", y = "Cases", caption = 'Daily Exercise 06') +  facet_wrap( ~ state, ncol = 3) + theme_light()
png("covidplot1.png")
print(plotbystate)
dev.off()


plotbycountry <- covid %>%
  group_by(date) %>%
  ggplot(aes(x = date, y = cases)) + geom_col() + labs(
    title = "National Cummulative Case Counts: COVID-19 Pandemic",
    x = "Date", y = "Cases", caption = 'Daily Exercise 06') + theme_light()

png("covidplot2.png")
print(plotbycountry)
dev.off()
