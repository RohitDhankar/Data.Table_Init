# New York Flights official tute - 
#

fl_14 <- as.data.table(flights14)
rm(flights14)
#
dim(fl_14)
summary(fl_14)
head(fl_14,n=10)
tail(fl_14,n=10)
#
# Get all the flights with “JFK” as the origin airport in the month of June.
#
ans <- fl_14[origin == "JFK" & month == 6L]
class(ans)
summary(ans)
head(ans)

# Within the frame of a data.table, columns can be referred to as if they are variables. 
# Therefore, we simply refer to dest and month as if they are variables. 
# We do not need to add the prefix flights$ each time. 
# However using flights$dest and flights$month would work just fine.
#
ans <- fl_14[1:2]
ans
# Sorting on TWO COLMNs at the same time - ORIGIN - Ascending and DESTINATION - Decending
# Use “-” on -- character columns - to sort in decreasing order.
#
sort_ans <- fl_14[order(origin, -dest)] 
head(sort_ans,n=10)
tail(sort_ans,n=10)
#
rm(sort_ans)
#
odt = data.table(col = sample(1e7))
str(odt)
#
(t1 <- system.time(ans1 <- odt[base::order(col)]))  ## uses order from base R
#    user  system elapsed 
#   0.384   0.000   0.384
#
(t2 <- system.time(ans2 <- odt[order(col)]))        ## uses data.table's forder
#    user  system elapsed 
#   0.360   0.004   0.364

# OWN -- 
# user  system elapsed 
# 0.828   0.040   0.867

# OWN -- NOT LESS THAN BASE:ORDER
# user  system elapsed 
# 1.008   0.004   1.012 

(identical(ans1, ans2))
# [1] TRUE
rm(odt)
rm(ans1)
rm(ans2)
##
## YES --- IMP 
##  Select column(s) in j --- in DT - DT[i,j,by]  ### So below SELECTING COLUMN == arr_delay from "j"
## Take DT, subset rows using "i", then calculate "j", grouped by "by".
## – Select arr_delay column, but return it as a vector.

delay_ans <- fl_14[, arr_delay]
head(delay_ans)
class(delay_ans)
#
rm(delay_ans)
#
#Since columns can be referred to as if they are variables within the frame of data.tables, 
#we directly refer to the variable we want to subset. Since we want all the rows, we simply skip "i".
# OWN exp with "i"
delay_ans1 <- fl_14[1,arr_delay] ## GET 1st ROW of COLMN == arr_delay
head(delay_ans1)
class(delay_ans1)
delay_ans1 ## GOT 1st ROW COLMN == arr_delay
head(fl_14)
#
rm(delay_ans1)
#
delay_ans2 <- fl_14[1:3,arr_delay] ## GET 1st TO 3rd - ROWs of COLMN == arr_delay
head(delay_ans2)
class(delay_ans2)
delay_ans2 ## GOT 1st TO 3rd - ROWs of COLMN == arr_delay
#
rm(delay_ans2)
#
## USING - list ... Select FIRST 3 ROWS from --- COL == arr_delay - RETURN a data.table.
#
delay_ans2 <- fl_14[1:3,list(arr_delay)] ## GET 1st TO 3rd - ROWs of COLMN == arr_delay
head(delay_ans2)
class(delay_ans2)
delay_ans2
#

## USING -a PERIOD in place of  "list" ... Select FIRST 3 ROWS from --- COL == arr_delay - RETURN a data.table.
#
delay_ans3 <- fl_14[1:3,.(arr_delay)] ## GET 1st TO 3rd - ROWs of COLMN == arr_delay
head(delay_ans3)
class(delay_ans3)
delay_ans3
#

## data.tables (and data.frames) are internally == lists.  
## but with -- columns of equal length and EACH COLUMN having a - "class attribute". 
## Which means all COLUMNS can have a DIFFERENT CLASS - some CHAR some INT etc etc. 
## 
# Allowing "j" to return a list enables converting and returning a data.table very efficiently.
#

## As the -  "j-expression" -- RETURNS a LIST , each element of this LIST is Converted to a COLMN in "data.table".
## This makes j quite powerful, as we will see shortly.
#
delay_ans <- fl_14[1:3, .(arr_delay, dep_delay)]
head(delay_ans)
#
# Above - 
# GOT 1st - 3 ROWS of COLMNs - arr_delay and dep_delay AND RETURN DATA.TABLE using PERIOD in place of LIST on "j-expression"
#
delay_ans1 <- fl_14[5:7, .(arr_delay, dep_delay)]
head(delay_ans1)
head(fl_14$arr_delay,n=10)
#
# Above - 
# GOT ROWS with RANGE 5:7 from COLMNs - arr_delay and dep_delay AND RETURN DATA.TABLE using PERIOD in place of LIST on "j-expression"
#
## – Select both arr_delay and dep_delay columns and rename them to delay_arr and delay_dep.
#
delay_ans2 <- fl_14[5:7, .(arr_delay=renamed_col1, dep_delay=renamed_col2)]
# Error in eval(jsub, SDenv, parent.frame()) : 
#   object 'renamed_col1' not found
#
# ERROR - Above --- am Assigning with "=" in Wrong Direction
## NEW COLMN Name to be LH-Side and OLD COLMN Name to be RH-Side
## Corrected below ---
#
delay_ans3 <- fl_14[, .(renamed_col1=arr_delay, renamed_col2=dep_delay)]
head(delay_ans3)
rm(delay_ans3)
delay_ans4 <- fl_14[5:7, .(renamed_col1=arr_delay, renamed_col2=dep_delay)]
head(delay_ans4)
#
#
## Compute or do in j --- CALCULATE in "j"
##– How many trips have had total delay < 0?
## REMOVE THE "PERIOD" or "LIST" Notation - as we dont want a DATA.TABLE SLICE - but want a CALCULATION or COMPUTATION 
##  COLMNS referred to as VARIABLES. WE Compute by calling functions on thes variables.
#

calc_1 <- fl_14[, sum((arr_delay+dep_delay)<0)]
class(calc_1)
calc_1
#
calc_2 <- fl_14[, sum((arr_delay+dep_delay)<5)]
class(calc_2)
calc_2
#

## Subset in i and do in j
##– Calculate the average arrival and departure delay for all flights with “JFK” as the origin airport in the month of June.
#
calc_3 <- fl_14[origin =="JFK" & month == 6L , .(sum((arr_delay+dep_delay)<5))]
#calc_3 <- fl_14[origin == "JFK" & month == 6L,.(m_arr = mean(arr_delay), m_dep = mean(dep_delay))]
calc_3


### Below Gives - SUM of ARR_DELAY + DEP_DELAY == TOTAL DELAY -- being LESS than 5 , WHERE ORIGIN == JFK and MONTH == 6L
calc_4 <- fl_14[origin =="JFK" & month == 6L , .(sum((arr_delay+dep_delay)<5))]
calc_4 ## 5334
#
### Below Gives - SUM of ARR_DELAY + DEP_DELAY == TOTAL DELAY -- being LESS than 50 , WHERE ORIGIN == JFK and MONTH == 6L
calc_4a <- fl_14[origin =="JFK" & month == 6L , .(sum((arr_delay+dep_delay)<50))]
calc_4a ## 7224

###
