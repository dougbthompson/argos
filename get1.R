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
}
attnames
q()

# -----

> ncdata$CYCLE_NUMBER
  [1] 304 154 222 416 381 342 289 289 146 110 208 207 147 130 138  40  36 138
 [19] 134 134 136  34  33  40  37  37  14   9 413 281 265 265 170 161  98  86
 [37]  86  67  55  61  40  42  11  11  39  35  38  12  12  12 410 413 385 385
 [55] 387 355 338 329 326 299 299  87  86  47  46 223 227 223 224 226 231 229
 [73] 223 206 226 228 206 215 184 183 161 140 128 561 160 212 180 184 175 130
 [91] 174 308 184 128 164 112 218 220 206 206 207 215 201 155 122 198  84  84
[109]  83  82  59  58  57  91  46  53  53  55 154  53  55  57  49  49  39 143
[127]  37  70  78  37  32  37  27  24  15  12 758 759 760 761 762 763 764 765
[145]  21  10  11  11  10   7   7   5   4   3 110 110 107 107  99  64  35  35
[163] 288 111 110 110 155  71 128 210  81   4   9 344 274 252 255 247 232 206
[181] 164 164  86  74  61  57   3 264  77  63 217 178 107  93 119  18  60  25
[199] 158  99 195 196  23 192  29  26  25 422 161 178 177 178  50  52 163  91
[217]  91  57  18  32
> dimnames
 [1] "DATE_TIME" "STRING256" "STRING64"  "STRING32"  "STRING16"  "STRING8"  
 [7] "STRING4"   "STRING2"   "N_PROF"    "N_PARAM"   "N_LEVELS"  "N_CALIB"  
[13] "N_HISTORY"
> dim.inq.nc(ncin, "N_PROF")
$id
[1] 8

$name
[1] "N_PROF"

$length
[1] 220

$unlim
[1] FALSE

> v_cycle_number <- var.inq.nc(ncin, 10)
> dimnames[v_cycle_number$dimids]
[1] "STRING2"
> dimnames[v_cycle_number$dimids+1]
[1] "N_PROF"
> dim.inq.nc(ncin, dimnames[v_cycle_number$dimids+1])
$id
[1] 8

$name
[1] "N_PROF"

$length
[1] 220

$unlim
[1] FALSE

> dim.inq.nc(ncin, dimnames[v_cycle_number$dimids+1])$length
[1] 220

