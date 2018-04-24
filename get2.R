#!/usr/bin/R

suppressPackageStartupMessages({
  suppressWarnings(library(sqldf))
  library(ncdf4)
  suppressWarnings(library(RMySQL))
})

add_db_connect <- function() {
    con <- dbConnect(RMySQL::MySQL(), dbname='argos', username='ruser', password='MBay860!',
                     unix.socket='/var/run/mysqld/mysqld.sock')
    return (con)
}

# main program -----

main = function() {
    # db_connect = add_db_connect()

    ncfname <- "20180101_prof.nc"
    ncin    <- nc_open(ncfname)

    x_vars <- attributes(ncin$var)$names
    for (i in 1:length(x_vars)) {
        # print (x_vars[i])
    }

    x_gattrs <- ncatt_get(ncin, 0)
    x_gattrs_names <- names(x_gattrs)
    for (i in 1:length(x_gattrs_names)) {
        print (paste0('Attribute: ',x_gattrs_names[i],' - Value: ',x_gattrs[[i]]))
    }

    # dbDisconnect(db_connect)
}

main()

