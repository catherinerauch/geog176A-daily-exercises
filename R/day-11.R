# Catherine Rauch
# 08/20/20
# daily assignment 11

# read in data, make spatial (CRS = 4326), filter to include only Santa Barbara and home town
citydata <- read_csv("~/github/geog-176A-labs/data/lab-01-materials/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  filter(city %in% c("Penngrove","Santa Barbara"))


# calculate distance between two
st_distance(citydata)

# transform locations to equal area projection (EPSG: 5070) and calculate distance
st_distance(st_transform(citydata, 5070))

# transform locations to eqidistance projection and calculate distance
st_distance(st_transform(citydata, '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs'))


# using units package set the units to kilometers
library(units)

(st_distance(citydata) %>%
    set_units("km") %>%
    drop_units())

(st_distance(st_transform(citydata, 5070)) %>%
    set_units("km") %>%
    drop_units())

(st_distance(st_transform(citydata, '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs')) %>%
    set_units("km") %>%
    drop_units())
