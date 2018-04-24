#!/usr/bin/R

library(RNetCDF)
library(RMySQL)

classGlobalAttr = function() {

  setClass("ngatts",
           representation(
           file_name = "character", title = "character", institution = "character", source = "character",
           history = "character", version = "character", conventions = "character", feature_type = "character"))
}
setCGA <- function (fi, ti, ins, so, hi, ve, co, fe) {
  cga <- new("ngatts",
             file_name    = fi,
             title        = ti,
             institution  = ins,
             source       = so,
             history      = hi,
             version      = ve,
             conventions  = co,
             feature_type = fe)

  return (cga)
}

# con <- dbConnect(RMySQL::MySQL(), dbname='argos', username='ruser', password='MBay860!', unix.socket='/var/run/mysqld/mysqld.sock')
# dbGetInfo(con)
# cg <- classGlobalAttr("a","b","c","d","e","f","g")
# str(cg)

# q()

# [1] "Term: title - Value: Argo float vertical profile"
# [1] "Term: institution - Value: US GDAC"
# [1] "Term: source - Value: Argo float"
# [1] "Term: history - Value: 2018-02-23T06:38:13Z"
# [1] "Term: user_manual_version - Value: 3.1"
# [1] "Term: Conventions - Value: Argo-3.1 CF-1.6"
# [1] "Term: featureType - Value: trajectoryProfile"

