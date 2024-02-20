## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(gpkg)
library(terra)

dem <- system.file("extdata", "dem.tif", package = "gpkg")
stopifnot(nchar(dem) > 0)
gpkg_tmp <- tempfile(fileext = ".gpkg")

if (file.exists(gpkg_tmp))
  file.remove(gpkg_tmp)

# write a gpkg with two DEMs in it
gpkg_write(
  dem,
  destfile = gpkg_tmp,
  RASTER_TABLE = "DEM1",
  FIELD_NAME = "Elevation"
)

gpkg_write(
  dem,
  destfile = gpkg_tmp,
  append = TRUE,
  RASTER_TABLE = "DEM2",
  FIELD_NAME = "Elevation",
  NoData = -9999
)

## -----------------------------------------------------------------------------
# add bounding polygon vector layer via named list
r <- gpkg_tables(geopackage(gpkg_tmp))[['DEM1']]
v <- terra::as.polygons(r, ext = TRUE)
gpkg_write(list(bbox = v), destfile = gpkg_tmp, append = TRUE)

## -----------------------------------------------------------------------------
z <- data.frame(a = 1:10, b = LETTERS[1:10])
gpkg_write(list(myattr = z), destfile = gpkg_tmp, append = TRUE)

## -----------------------------------------------------------------------------
g <- geopackage(gpkg_tmp, connect = TRUE)
g
class(g)

## -----------------------------------------------------------------------------
g2 <- geopackage(list(dem = r, bbox = v))
g2
class(g2)

## -----------------------------------------------------------------------------
# enumerate tables
gpkg_list_tables(g)

# inspect tables
gpkg_tables(g)

# inspect a specific table
gpkg_table(g, "myattr", collect = TRUE)

## -----------------------------------------------------------------------------
gpkg_collect(g, "DEM1")

## -----------------------------------------------------------------------------
gpkg_tbl(g, "gpkg_contents")

## -----------------------------------------------------------------------------
head(gpkg_table_pragma(g))

## -----------------------------------------------------------------------------
gpkg_vect(g, 'bbox')

## -----------------------------------------------------------------------------
gpkg_vect(g, 'gpkg_ogr_contents')

## -----------------------------------------------------------------------------
res <- gpkg_ogr_query(g, "SELECT 
                           ST_MinX(geom) AS xmin,
                           ST_MinY(geom) AS ymin, 
                           ST_MaxX(geom) AS xmax, 
                           ST_MaxY(geom) AS ymax 
                          FROM bbox")
as.data.frame(res)

## -----------------------------------------------------------------------------
gpkg_rast(g)

## -----------------------------------------------------------------------------
gpkg_table(g, "gpkg_contents")

## -----------------------------------------------------------------------------
library(dplyr, warn.conflicts = FALSE)

gpkg_table(g, "gpkg_2d_gridded_tile_ancillary") %>% 
  filter(tpudt_name == "DEM2") %>% 
  select(mean, std_dev) %>% 
  collect()

## -----------------------------------------------------------------------------
# still connected
gpkg_is_connected(g)

# disconnect geopackage
gpkg_disconnect(g)

# reconnect
gpkg_connect(g)

# disconnect
gpkg_disconnect(g)

