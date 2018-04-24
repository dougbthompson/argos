#!/usr/bin/R

library(RNetCDF)

# ----------------------------------
countCharOccurrences <- function(char, s) {
    s2 <- gsub(char,"",s)
    return (nchar(s) - nchar(s2))
}
# ----------------------------------
func_categorize_entry = function (p_val_type, p_val_spec) {
    a_comma <- regexpr(',', p_val_spec)
    n_comma <- countCharOccurrences(',', p_val_spec) + 1
    a_colon <- regexpr(':', p_val_spec)
    n_colon <- countCharOccurrences(':', p_val_spec)

    # print(paste0('Spec: ', p_val_spec, ' Comma: ',a_comma, ' Colon: ', a_colon, ' # Colons: ', n_colon))
    a_dims <- n_comma
    a_dim1 <- 0
    a_dim2 <- 0
    a_dim3 <- 0
    a_dim4 <- 0

    setClass ("cat_entry", representation(
        val_type="character",   # chr, num
        val_spec="character",   # one of the 7 types

        ent_dims="numeric",     # number of dimensions
        ent_dim1="numeric",     # 
        ent_dim2="numeric",     # 
        ent_dim3="numeric",     # 
        ent_dim4="numeric",     # 

        ent_eor ="character"    # end of record, place holder
    ))

    entry <- new("cat_entry", val_type=p_val_type, val_spec=p_val_spec,
                 ent_dims=a_dims, ent_dim1=10, ent_dim2=11, ent_dim3=12, ent_dim4=13,
                 ent_eor="")
    return (entry)
}
# ----------------------------------
app_val_spec_01 = function(val_spec) {
}
app_val_spec_02 = function(val_spec) {
}
app_val_spec_03 = function(val_spec) {
}
app_test1 = function(val_type) {
    # print(paste0('Function: app_test1 value: ',val_type))
    return ('02')
}
# ----------------------------------

ncfname <- "outgoing/2018/01/20180101_prof.nc"

ncin <- open.nc(ncfname)
ncdata <- read.nc(ncin, unpack=F)

# print.nc(ncin)
# names(ncdata)

ncdata$PSAL_ADJUSTED[2,1:32]
str(ncdata$PSAL_ADJUSTED)
ncdata$SCIENTIFIC_CALIB_COMMENT[3,1:3]

ncnames <- names(ncdata)

for (i in 1:length(ncnames)) {
    print(ncnames[i])
}

s <- summary(ncdata$PRES_QC)
sn <- s[[1]]

# for (i in 1:sn) {
for (i in 1:3) {
    print(trimws(ncdata$PRES_QC[i]))
}

co <- capture.output(str(ncdata))
# for (i in 2:65) {
for (i in 2:65) {
  co[i]

  pos_start1 <- regexpr(":", co[i]) + 1
  pos_end1   <- regexpr("\\[", co[i]) - 1
  val_type   <- trimws(substr(co[i], pos_start1, pos_end1))

  pos_start2 <- regexpr("\\[", co[i])
  pos_end2   <- regexpr("\\]", co[i])
  val_spec   <- trimws(substr(co[i], pos_start2, pos_end2))

  # print(paste0(' - ', trimws(substr(co[i], pos_start1, pos_end1)), ' - ', trimws(substr(co[i], pos_start2, pos_end2))))

  if (val_type == 'chr') {
      # print ('Value is a [character] type')
      x <- 1
  } else {
    if (val_type == 'num') {
        # print ('Value is a [numeric] type')
        x <- 2
    } else {
      # print ('Value is unknown')
      x <- 3
    }
  }

  class_val <- func_categorize_entry(val_type, val_spec)
  # print (paste0('Spec: ', class_val@val_spec, ' Dimensions: ', class_val@ent_dim))
  print (class_val@ent_dims)

  which_val_spec <- '01'
  switch (val_spec,
          '[1(1d)]'         = val_spec_type <- app_test1(val_spec),
          '[1:220, 0 ]'     = val_spec_type <- app_test1(val_spec),
          '[1:220(1d)]'     = val_spec_type <- app_test1(val_spec),
          '[1:3, 1:220]'    = val_spec_type <- app_test1(val_spec),
          '[1:220, 0 ]'     = val_spec_type <- app_test1(val_spec),
          '[1:2604, 1:220]' = val_spec_type <- app_test1(val_spec),
          print(paste0('Unknown type: ',val_spec))
  )
  switch (val_spec_type,
          '01' = app_val_spec_01(val_spec),
          '02' = app_val_spec_02(val_spec),
          '03' = app_val_spec_03(val_spec),
          print(paste0('Unknown type: ',val_spec))
  )
}

# only 7 different (type, spec) combinations
# [1] " - chr - [1(1d)]" .............. (1d) indicates a single string of values .................... (one value)
# [2] " - chr - [1:220, 0 ]" .......... a one dimensional character array of NO values .............. (no values)
# [3] " - chr - [1:220(1d)]" .......... a one dimensional array (a character string) ................ (one value)
# [4] " - chr - [1:3, 1:220]" ......... a 3 X 220 matrix of character strings (also use trimws) ..... (many values)
# [5] " - num - [1:220, 0 ]" .......... a one dimensional integer array of NO values ................ (no values)
# [6] " - num - [1:220(1d)]" .......... a one dimensional integer array (a character string) ........ (many values in a string)
# [7] " - num - [1:2604, 1:220]" ...... a 2604 X 220 matrix of numeric values (integeers or floats) . (many values)

# only 3 spec types:
# [1] [1:2604, 1:220] .... with 1 comma, with 2 colons
# [2] [1:220(1d)] ........ no comma, with 1 colon
# [3] [1(1d)] ............ else neither!

# eof

