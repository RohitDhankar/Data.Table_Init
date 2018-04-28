#simulated_data
set.seed(123)
# Scalar Vector Constant - tweak to change DF Dimensions
aa<-20000 # 20 K 
#
dates_aa <-seq(as.Date("2000/1/1"), by = "month", length.out = aa/90)
print(str(dates_aa)) ; print(class(dates_aa)) ; print(length(dates_aa)) ; print(head(dates_aa)); print(tail(dates_aa))
#
# Mkt Stores ID's == ms_ids
ms_cntry1 <- c(rep("IND",aa/90))
ms_cntry2 <- c(rep("AUS",aa/90))
ms_cntry3 <- c(rep("NZ",aa/90))
ms_cntry4 <- c(rep("RUS",aa/90))
print(str(ms_cntry4)) ; print(length(ms_cntry4)) ; print(head(ms_cntry4)); print(tail(ms_cntry4))
#
#
ms_cty1 <- c(rep("CTY_1",aa/30))
ms_cty2 <- c(rep("CTY_2",aa/30))
ms_cty3 <- c(rep("CTY_3",aa/30))
ms_cty4 <- c(rep("CTY_4",aa/30))
print(str(ms_cty4)) ; print(length(ms_cty4)) ; print(head(ms_cty4)); print(tail(ms_cty4))
#
#
## Use - runif() # runif generates random deviates.
## Create Simulated Data for Product Sales 
#
set.seed(1234)
psale_1 <- runif(aa/90,min=1,max=9) ## 
set.seed(1234)
psale_2 <- runif(aa/90,min=10,max=24) ##
set.seed(1234)
psale_3 <- runif(aa/90,min=25,max=99) ##
set.seed(1234)
psale_4 <- runif(aa/90,min=100,max=500) ##
print(str(psale_4)) ; print(length(psale_4)) ; print(head(psale_4)); print(tail(psale_4))
#
 
str_code = runif(aa/3,min=2433,max=9999)
length(str_code)
str_code_1 = "T"
str_code_2 = "X"
#
require(data.table)
#
mkt_df <- data.table(cnt_nm = rep(c(ms_cntry1,ms_cntry2,ms_cntry3,ms_cntry4),4), 
                     cty_nm = rep(c(ms_cty1,ms_cty2,ms_cty3,ms_cty4,ms_cty4,ms_cty3,ms_cty2,ms_cty1),2),
                     store_code = paste(str_code_1,str_code),   
                     store_num =  paste(str_code_2,str_code),     
                     psale_all =rep(c(psale_1,psale_2,psale_3,psale_4),4)
                     )
mkt_df$user_id = paste(mkt_df$cnt_nm,mkt_df$cty_nm,mkt_df$store_code,mkt_df$store_num,mkt_df$psale_all) 

#
head(mkt_df)
class(mkt_df)
str(mkt_df)
summary(mkt_df)
length(mkt_df$user_id)
length(unique(mkt_df$user_id))
#



