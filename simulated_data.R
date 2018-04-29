#simulated_data
set.seed(123)
# Scalar Vector Constant - tweak to change DF Dimensions
aa<-20000 # 20 K 
#
## Count of COUNTRY ==IND == 2664 - obtained after creating DF - to be pre-calculated somehow ?
#
d2 <- as.Date("2018/3/15") ## End date 
d1 <- d2 - 2663            ## (len Country IND) - 1
d1                         ## Start date
#
dates_a <- seq(d1,d2,by ="day")
print(head(dates_a,n=20));print(tail(dates_a,n=20));
#"Len"
print(length(dates_a));
#
# Mkt or Retail Store Country Names ...
#
ms_cntry1 <- c(rep("IND",aa/90))
ms_cntry2 <- c(rep("AUS",aa/90))
ms_cntry3 <- c(rep("NZ",aa/90))
ms_cntry4 <- c(rep("RUS",aa/90))
print(str(ms_cntry4)) ; print(length(ms_cntry4)) ; print(head(ms_cntry4)); print(tail(ms_cntry4))
#
# Mkt or Retail Store City Codes for City Names ...
# Count of each City Code to be 4X of Country Names - as we want to Map - 1 Country with 4 Cities each.
#
ms_cty1 <- c(rep("CTY_1",aa/30))
ms_cty2 <- c(rep("CTY_2",aa/30))
ms_cty3 <- c(rep("CTY_3",aa/30))
ms_cty4 <- c(rep("CTY_4",aa/30))
print(str(ms_cty4)) ; print(length(ms_cty4)) ; print(head(ms_cty4)); print(tail(ms_cty4))
#
#
#### Create Simulated Data for Product Sales 
## Use - runif() # runif generates random deviates - from a uniform distribution.
## runif will not generate either of the extreme values unless max = min or max-min is small compared to min,
## and in particular not for the default arguments.

#
set.seed(1234)
psale_a <- runif(aa/3,min=1,max=50000) ## 1-50k
print(str(psale_a)) ; print(length(psale_a)) ; print(head(psale_a)); print(tail(psale_a))
#
# random - foo - needs more deliberation ??
# Create String Codes with Prefix - Str == "T" and "X"
#
str_code_a <- as.integer(runif(aa/3,min=111111,max=999999))
str_code_b <- as.integer(runif(aa/3,min=211111,max=899999))
#length(str_code_a)
str_code_1 = "T"
str_code_2 = "X"
#
require(data.table)
#
mkt_df <- data.table(cnt_nm = rep(c(ms_cntry1,ms_cntry2,ms_cntry3,ms_cntry4),4), 
                     cty_nm = rep(c(ms_cty1,ms_cty2,ms_cty3,ms_cty4,ms_cty4,ms_cty3,ms_cty2,ms_cty1),2),
                     store_code_t = paste(str_code_1,str_code_a),   
                     store_code_x =  paste(str_code_2,str_code_b),     
                     psale_a
                     )
mkt_df$user_id <- paste(mkt_df$cnt_nm,mkt_df$cty_nm,mkt_df$store_code_t,mkt_df$store_code_x,mkt_df$psale_a) 

#
head(mkt_df)
class(mkt_df)
str(mkt_df)
summary(mkt_df)
length(mkt_df$user_id)
length(unique(mkt_df$user_id))
#
write.csv(mkt_df,file="test_data/mkt_df.csv")
## Writes to Sub Directory - DATA_Files
#




