#!/usr/bin/R

library(RNetCDF)

ncfname <- "20180101_prof.nc"
ncin    <- open.nc(ncfname)
ncdata  <- read.nc(ncin, unpack=F)

fi <- file.inq.nc(ncin)
ndims      <- fi$ndims
nvars      <- fi$nvars
ngatts     <- fi$ngatts
unlimdimid <- fi$unlimdimid

# dimension values
# $id     [1] 0 
# $name   [1] "DATE_TIME"
# $length [1] 14
# $unlim  [1] FALSE

dimnames <- character(ndims)
for (i in seq_len(ndims)) {
  dimnames[i] <- dim.inq.nc(ncin, i-1)$name
  # print(paste0('Idx: ',i,' DName: ',dimnames[i])) 
}
dimnames

# variable values
# $id     [1] 0 
# $name   [1] "DATA_TYPE" 
# $type   [1] "NC_CHAR" 
# $ndims  [1] 1 
# $dimids [1] 4 
# $natts  [1] 3 

varnames <- character(nvars)
for (i in seq_len(nvars)) {
  varnames[i] <- var.inq.nc(ncin, i-1)$name
  # print(paste0('Idx: ',i,' VName: ',varnames[i])) 
}
varnames

# global attribute values
# $id     [1] 0 
# $name   [1] "title" 
# $type   [1] "NC_CHAR" 
# $length [1] 27 

attnames <- character(ngatts)
for (i in seq_len(ngatts)) {
  attnames[i] <- att.inq.nc(ncin, "NC_GLOBAL", i-1)$name
  print( paste0("Term: ",attnames[i]," - Value: ",att.get.nc(ncin, "NC_GLOBAL", attnames[i])) )
}
attnames

print(paste0('values ("',
             ncfname,'","',
             att.get.nc(ncin,"NC_GLOBAL","title"),'","',
             att.get.nc(ncin,"NC_GLOBAL","institution"),'","',
             att.get.nc(ncin,"NC_GLOBAL","source"),'","',
             att.get.nc(ncin,"NC_GLOBAL","history"),'","',
             att.get.nc(ncin,"NC_GLOBAL","user_manual_version"),'","',
             att.get.nc(ncin,"NC_GLOBAL","Conventions"),'","',
             att.get.nc(ncin,"NC_GLOBAL","featureType"),
             '")'))

# q()

