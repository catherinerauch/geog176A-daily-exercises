# Catherine Rauch
# 08/24/2020
# daily assignment 11

ark <- us_states(states = 'Arkansas')


# which states touch this arkansa
arkcount = st_filter(us_states(), ark,  .predicate = st_touches)


CONUS <- USAboundaries::us_states() %>%
  filter(!state_name %in% c( "Puerto Rico", "Alaska","Hawaii"))

ggplot() +
  geom_sf(data = CONUS, lty = 3) +
  geom_sf(data = arkcount, fill = 'red', alpha = .5) + theme_gdocs() +
  labs(title = "United States Of America",
       x = "States that Touch Arkansas in red")


ggsave("States that Touch Arkansas", plot = last_plot(), device = "png")
