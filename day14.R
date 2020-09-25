# Catherine Rauch
# daily assignment 14
# 8/25/20


# define functions


get_conus = function(data, var){
  conus = filter(data, !get(var) %in% c("Hawaii", "Puerto Rico", "Alaska"))
  return(conus)
}


point_in_polygon3 = function(points, polygon, group){
  st_join(polygon, points) %>%
    st_drop_geometry() %>%
    count(get(group)) %>%
    setNames(c(group, "n")) %>%
    left_join(polygon, by = group) %>%
    st_as_sf()
}




plot_pip = function(data){
  ggplot() +
    geom_sf(data = data, aes(fill = log(n)), alpha = .9, size = .2)+
    theme_void() +
    theme(legend.position = 'none',
          plot.title = element_text(face = "bold", color = "black", hjust = .5, size = 24))
}



# Use the uscities.csv to create your points

citydata = read_csv("~/github/geog-176A-labs/data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  get_conus("state_name") %>%
  select(city)


# Use USAboundaries::us_states() to define your polygons

polygon = get_conus(us_states()) %>%
  select(name)


counties = get_conus(us_counties(), "state_name") %>%
  st_transform(st_crs(citydata))


# MODIFY the plot_pip function to plot your data

point_in_polygon3(citydata, counties, "geoid") %>%
  plot_pip() + scale_fill_gradient(low = "yellow", high = "darkred") +
  labs(title = " ")  +
  geom_sf(data = citydata, size = .25, alpha = .05, col = 'grey')


ggsave("pipplot.png", last_plot())


