# Catherine Rauch
# 8/14/2020
# daily assignment 8

url <- 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid <-  read_csv(url)

head(covid)

state.of.interest = "Washington"

WAcovidnewcases <- covid %>%
  filter(state == state.of.interest) %>%  # filter data for cases in Washington state only
  group_by(date) %>%
  summarise(ncases = sum(cases), .groups = 'drop') %>%
  mutate(newCases = ncases - lag(ncases),
         roll7 = rollmean(newCases, 7, fill = NA, align="right")) %>%
  ggplot(aes(x = date)) +
  geom_col(aes(y = newCases), col = NA, fill = "#F5B8B5") +
  geom_line(aes(y = roll7), col = "darkred", size = 1) +
  ggthemes::theme_wsj() +
  labs(title = paste("New Reported cases by day in", state.of.interest)) +
  theme(plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(size = 14, face = 'bold')) +
  theme(aspect.ratio = .5)


png("WAcovidnewcases.png")
print(WAcovidnewcases)
dev.off()
