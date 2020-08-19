# Catherine Rauch
# 8/18/20

CONUS <- USAboundaries::us_states() %>%
          filter(!state_name %in% c( "Puerto Rico", "Alaska","Hawaii"))

# cast CONUS into a MULTILINESTRING Geometry set of 1 feature


# preserve internal state boundaries
sboundariesCONUS.ml <-  st_combine(CONUS) %>%
                      st_cast("MULTILINESTRING")

sboundariesCONUS.ml
plot(sboundariesCONUS.ml)


# dissolve internal state boundaries
nboundariesCONUS.ml = st_union(CONUS) %>%
                      st_cast("MULTILINESTRING")
nboundariesCONUS.ml
plot(nboundariesCONUS.ml)
