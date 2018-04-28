#Own_R_InAction.R
#
y <- matrix(1:20, nrow=5, ncol=4)
str(y) ## By Default Filled in By COLUMNS
y
#
cells<- c(1,2,3,4)
rnames <- c("R1", "R2")
cnames <- c("C1", "C2")
mymatrix <- matrix(cells, nrow=2, ncol=2, byrow=TRUE, dimnames=list(rnames, cnames))
mymatrix ## ## Filled in By ROWS -- byrow=TRUE
#
mymatrix <- matrix(cells, nrow=2, ncol=2, byrow=FALSE, dimnames=list(rnames, cnames))
mymatrix ## ## By Default Filled in By COLUMNS
#
mm <- matrix(1:40, nrow=5, ncol=4)
mm
#
x1<- mm[1,] ## 1st ROW - All COLS
x1
#
x2<- mm[,1] ## ALL ROW - Only 1st  COL
x2
#
x3<- mm[1,c(1,2)] ## 1st ROW -of -- COLs - 1st and 2nd
x3

## MATRIX == ARRAY -- Can have only 1 MODE - Storage Mode of DATA.
# Array -1 - 3 D ARRAY --- 2X3X4 
dim1 <- c("A1_1st_DIM", "A2_1st_DIM")                            ## 1st_DIM - LABELS 
dim2 <- c("B1_2nd_DIM", "B2_2nd_DIM", "B3_2nd_DIM")              ## 2nd_DIM - LABELS 
dim3 <- c("C1_3rd_DIM", "C2_3rd_DIM", "C3_3rd_DIM", "C4_3rd_DIM") ## 3rd_DIM - LABELS 
arr_1 <- array(1:24, c(2, 3, 4), dimnames=list(dim1, dim2, dim3))
arr_1
#
#
## DATAFRAME - -- Can have MULTIPLE MODE - Storage Mode of DATA.
#



## Global and Local ENV Objects and Objs assigned to Variables --- 

# To create objects that exist outside of the with() construct, use the
# special assignment operator <<- instead of the standard one (<-). 
# It will save the object to the global environment outside of the with() call.
#
with(mtcars, {
  nokeepstats <- summary(mpg)
  print(nokeepstats)             ## Will Print --> nokeepstats
  keepstats <<- summary(mpg)
})
nokeepstats ## As expected --- Error: object 'nokeepstats' not found 
## Will NOT Print --> nokeepstats
#
keepstats ## Found as STORED in GLOBAL Env.
#


### PAtient Data --- 

patientID <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c("Type1", "Type2", "Type1", "Type1")
status <- c("Poor", "Improved", "Excellent", "Poor")
patientdata <- data.frame(patientID, age, diabetes, status)
patientdata
#
## CASE IDENTIFIERS -- or OBSERVATION IDENTIFIERS - with ROW NAMES 
#
patientdata <- data.frame(patientID, age, diabetes, status,
                          row.names=status) ## status
patientdata
## ERROR -- as the ROW NAMES -- Cant be DUPLICATES - we have STATUS == Poor - for Two Patients --- thus cant have STATUS as - row.names 
# Error in data.frame(patientID, age, diabetes, status, row.names = status) : 
#   duplicate row.names: Poor
#

# Nominal variables are categorical, without an implied order. Diabetes ( Type1, Type2 ) is
# an example of a nominal variable. Even if Type1 is coded as a 1 and Type2 is coded
# as a 2 in the data, no order is implied.


# Ordinal variables imply order but not amount.
# Status ( poor, improved, excellent ) is a good example of an ordinal variable. You
# know that a patient with a poor status isn’t doing as well as a patient with an improved
# status, but not by how much.

#
str(patientdata$status) ## Factor w/ 3 levels "Excellent","Improved",..: 3 2 1 3
patientdata$status <- factor(patientdata$status, ordered=TRUE)
str(patientdata$status) ## Ord.factor w/ 3 levels "Excellent"<"Improved"<..: 3 2 1 3 
## NOTE - >> "Excellent"<"Improved"<"Poor"
#
## By default, factor levels for character vectors are created in alphabetical order.
## Need to provide --- LEVELS --->> levels=c("Poor", "Improved", "Excellent")
#
patientdata$status <- factor(patientdata$status, ordered=TRUE,levels=c("Poor", "Improved", "Excellent"))
str(patientdata$status) ## Ord.factor w/ 3 levels "Poor"<"Improved"<..: 1 2 3 1 ## LEVELS == "Poor"<"Improved"<"Excellent"
#
g <- "My First List"
h <- c(25, 26, 18, 39)         ## NUM VECTOR as LIST ELEMENT
j <- matrix(1:10, nrow=5)     ## MATRIX as LIST ELEMENT
k <- c("one", "two", "three") ## CHAR VECTOR as LIST ELEMENT
mylist <- list(title=g, ages=h, j, k)
mylist
#
#
## Assign value to NON Existent ELEMENT of VECTOR 
#
xa <- c(8, 6, 4)
print(xa)
xa[7] <- 10
print(xa) ## 8  6  4 NA NA NA 10
#
xa <- xa[1:5]
print(xa) ## 8  6  4 NA NA ## SHRINKS Back to the FIRST - Five Elements 
#
#
xa <- c(8, 6, 4)
print(xa)
xa[7] <- 10
print(xa) ## 8  6  4 NA NA NA 10
#
xa <- xa[2:5]
xa               ## SHRINKS Back to RANGE -- 2nd to 5th ELEMENT
#
#
## Variables can’t be declared. They come into existence on first assignment.
## Can be assigned NULL Values ?? 

var1 <- NULL
print(var1)

var1 <- ""
print(var1)
var1 <- "*"
print(var1)

#
#
## RODBC -- for WINDOWS -- https://cran.r-project.org/web/packages/RODBC/RODBC.pdf
## PDF Doc --Done Down 
## MySQL + ODBC == https://www.mysql.com/products/connector/
## https://gist.github.com/EarlGlynn/8487321
#
# XML Imports in R --- Done Down --> http://www.omegahat.net/RSXML/description.pdf
# https://github.com/omegahat
#
## Adding a New Variable Named == gender 
#
gender <- c("male","female")
patientdata$gender <- gender
head(patientdata,n=10)
# Absolutely RANDOM Assignemnt of GENDER ?? Not Ok 
#
## Creating and ADDING New Variables to existing DF 
#
df1<-data.frame(x1 = c(2, 2, 6, 4),
                   x2 = c(3, 4, 2, 8))

df1                                              ## DF Created 
#
df1 <- transform(df1,
                    sumx = x1 + x2,
                    meanx = (x1 + x2)/2)
df1                                             ## 2 New Variables Added - sumx and meanx 
#


### DF - Inner Join , Merge and CBIND - Column Bind 
#

