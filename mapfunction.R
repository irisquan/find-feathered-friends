library("leaflet")
library("tidyverse")
library("naturecounts")

map_maker <- function(spec_number, start_year, end_year, province){

mydata <-nc_data_dl(species=spec_number, years = c(start_year, end_year), region=list(statprov=province), username="jackieee", info="reason")

locations <-select(mydata, "longitude", "latitude")
date <- select(mydata, "survey_year", "survey_month", "survey_day")
test<-vector(mode="list", length=nrow(date))

for(val in 1:nrow(date)){
  test[[val]] <- paste(date[val,1],date[val,2], date[val,3], sep="/")
}

birdIcon <- makeIcon(
  iconUrl = "https://i.ibb.co/MSMJ24J/Bird-Marker.png",
  iconWidth = 65, iconHeight = 70,
  iconAnchorX = 37.5, iconAnchorY = 70
)

m<-leaflet() %>%
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addProviderTiles(providers$Stamen.TonerHybrid, options=providerTileOptions(opacity=90))
m<-addMarkers(m, data=locations, label=test, icon=birdIcon, clusterOptions = markerClusterOptions())

return(m)
}

print(map_maker(spec_number = 13640, start_year = 2000, end_year = 2010, province = "ON"))

