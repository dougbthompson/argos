#!/usr/bin/R

library(RNetCDF)
library(RMySQL)

dbInsertArgMeta <- function(con, filename, ncin) {

  sql <- sprintf("insert into arg_meta (arg_meta_filename,arg_meta_title,arg_meta_institution,arg_meta_source,arg_meta_history,arg_meta_manual_version,arg_meta_conventions,arg_meta_feature_type) values ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');",
                  filename,
                  att.get.nc(ncin,"NC_GLOBAL","title"),
                  att.get.nc(ncin,"NC_GLOBAL","institution"),
                  att.get.nc(ncin,"NC_GLOBAL","source"),
                  att.get.nc(ncin,"NC_GLOBAL","history"),
                  att.get.nc(ncin,"NC_GLOBAL","user_manual_version"),
                  att.get.nc(ncin,"NC_GLOBAL","Conventions"),
                  att.get.nc(ncin,"NC_GLOBAL","featureType"))

  rs <- dbSendQuery(con, sql)
  dbClearResult(rs)

  id <- dbGetQuery(con, "select last_insert_id();")[1,1]
  return(id)

}

