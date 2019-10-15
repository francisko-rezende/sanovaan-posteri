# THIS SCRIPT WON'T RUN IF YOU DON'T USE GOOGLE'S API

source(here::here("R", "02_libraries.R"))

# getting map -------------------------------------------------------------

# ggmap::register_google(key = "")

jyv_map <- ggmap::get_map("jyvaskyla", zoom = 14, maptype = "toner") 


# points ------------------------------------------------------------------

kir <- ggmap::geocode("Jyväskylän pääkirjasto - Jyväskylän kaupunginkirjasto")

locs <- tibble::tribble(~lab, ~lat, ~lon,
        "Proxima (X talo)", 62.236969, 25.730617,
        "Jyväskylän kaupunginkirjasto", kir[[2]], kir[[1]],
        "Kirkkopuisto",  62.240435, 25.745094)

# final map ---------------------------------------------------------------

# ---- jyv-map ----
kartta <- ggmap(jyv_map) +
  geom_point(data = locs,
             aes(x = lon, y = lat),
             color = '#f1573f',
             size = 2) +
  # geom_text(data = locs, aes(label = lab, x = lon, y = lat), nudge_y = .001) +
  # geom_mark_circle() +
  geom_mark_circle(
    data = locs,
    aes(label = lab, group = lab, color = '#f1573f'),
    con.size = 1,
    con.linetype = 2,
    con.colour = '#f1573f',
    show.legend = F
    
    
  ) +
  theme_map()


# saving as rds -----------------------------------------------------------

save(kartta, file = here::here("data","01_kartta.RData"))
