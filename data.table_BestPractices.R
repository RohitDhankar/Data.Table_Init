##Data.Table_IMP
#
# sample data
df <- data.frame(
  X1 = c("1996-01-04", "1996-01-05", "1996-01-08", "1996-01-09", "1996-01-10", "1996-01-11"), 
  X2 = c("02/01/1996", "03/01/1996", "04/01/1996", "05/01/1996", "08/01/1996", "09/01/1996"), 
  stringsAsFactors = FALSE)

df

library(data.table)
# convert date columns
date_cols <- c("X1", "X2")
setDT(df)[, (date_cols) := lapply(.SD, anytime::anydate), .SDcols = date_cols]
df
#
## SOURCE --- Data.Table --- PDF Vigenette 
#
DT = data.table(A=5:1,B=letters[5:1])
DT

setkey(DT,B)
DT
## J : the same result as calling list. J is a direct alias for list 
## but results in clearer more readable code.

# re-orders table and marks it sorted.
DT[J("b")]
# returns the 2nd row
DT[.("b")]
# same. Style of package plyr. -- returns the 2nd row
DT[list("b")]
# same
DT[J("e")] # OK -- 1: 5 e
#
##

setkey(DT,A)
DT[J(2)] # OK -- 1: 2 b
DT[.(2)] # OK -- 1: 2 b
DT[list(2)] # OK -- 1: 2 b
#
DT[J(5)] # OK -- 1: 5 e
DT[.(5)] # OK -- 1: 5 e
DT[list(5)] # OK -- 1: 5 e

#DT[J(e)] # NOT OK -- ?? Only works when setkey(DT,B)
# Error in eval(.massagei(isub), x, parent.frame()) : object 'e' not found

#
setkey(DT)
DT[J(2)] # OK -- 1: 2 b
DT[J(5)] # OK -- 1: 5 e
DT[.(5)] # OK -- 1: 5 e
DT[list(5)] # OK -- 1: 5 e
#DT[J("e")] # NOT OK -- ?? Only works when setkey(DT,B)

### Pg - 57 -- like - Convenience function for calling regexpr.
#
DT = data.table(Name=c("Mary","George","Martha","Mavis","Odema","Stigma","Summary"), Salary=c(1:7))
DT[Name %like% "^Mar"]  # Pattern to MATCH - only Begining of STRING
DT[Name %like% "ma$"]   # Pattern to MATCH - only END of STRING
DT[Name %like% "ma"]    # Pattern to MATCH - anywhere in STRING
#

### Pg - 57 -- like - Convenience function for calling regexpr.
#

