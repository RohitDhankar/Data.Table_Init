#csv_rollup
#
mkt_df <- read.csv("/media/dhankar/Dhankar_1/a2_18/a2____R_Apr18/a2___1/a2_R_1/Own_R_InAction/test_data/mkt_df.csv", stringsAsFactors=FALSE)
#
mkt_df1 <- read.csv("/media/dhankar/Dhankar_1/a2_18/a2____R_Apr18/a2___1/a2_R_1/Own_R_InAction/test_data/mkt_df1.csv", stringsAsFactors=FALSE)
#

require(data.table)
dt_1 <- as.data.table(mkt_df)
dt_2 <- as.data.table(mkt_df1)

#
# random - "House-keeping"
rm(mkt_df,mkt_df1,psale_1,psale_2,psale_3,psale_4,aa)
rm(ms_cntry1,ms_cntry2,ms_cntry3,ms_cntry4)
rm(ms_cty1,ms_cty2,ms_cty3,ms_cty4)
rm(str_code_a,str_code_b,str_code_1,str_code_2)
rm(psale_a,psale_b,dates_a,dates_b)

#
summary(dt_1)
# rename the USER_ID to UNIQUE_ID
#names(dt_1)[7] <- "uniq_id" ### This is the old DF way 
# data.table way == setnames
setnames(dt_1, old = "user_id", new = "uniq_id")
#summary(dt_1)
#head(dt_1,n=20)
print(tail(dt_1,n=5))

#
dt1_order <- dt_1[order(cnt_nm , cty_nm),]
#summary(dt1_order)
#head(dt1_order,n=20)
print(length(dt1_order$uniq_id))
#print(tail(dt1_order,n=5))
rm(dt_1)

# > print(tail(dt_1,n=5))
# X cnt_nm    dates_a cty_nm store_code_t store_code_x  psale_a                     uniq_id
# 1: 10652    RUS 2018-03-11  CTY_1     T 911512     X 815600 19266.33 RUS CTY_1 T 911512 X 815600
# 2: 10653    RUS 2018-03-12  CTY_1     T 508751     X 702352 29323.65 RUS CTY_1 T 508751 X 702352
# 3: 10654    RUS 2018-03-13  CTY_1     T 931088     X 754803 41656.63 RUS CTY_1 T 931088 X 754803
# 4: 10655    RUS 2018-03-14  CTY_1     T 598386     X 344672 48474.96 RUS CTY_1 T 598386 X 344672
# 5: 10656    RUS 2018-03-15  CTY_1     T 735759     X 430373 42591.94 RUS CTY_1 T 735759 X 430373
# > print(tail(dt1_order,n=5))
# X cnt_nm    dates_a cty_nm store_code_t store_code_x  psale_a                     uniq_id
# 1: 7988    RUS 2018-03-11  CTY_4     T 565237     X 546438 38140.83 RUS CTY_4 T 565237 X 546438
# 2: 7989    RUS 2018-03-12  CTY_4     T 767171     X 711545 35336.26 RUS CTY_4 T 767171 X 711545
# 3: 7990    RUS 2018-03-13  CTY_4     T 709238     X 466500 37024.54 RUS CTY_4 T 709238 X 466500
# 4: 7991    RUS 2018-03-14  CTY_4     T 742888     X 250641 14817.58 RUS CTY_4 T 742888 X 250641
# 5: 7992    RUS 2018-03-15  CTY_4     T 598818     X 794211 23089.71 RUS CTY_4 T 598818 X 794211
# > 

#
summary(dt_2)
# rename the USER_ID to UNIQUE_ID
#names(dt_1)[7] <- "uniq_id" ### This is the old DF way 
# data.table way == setnames
setnames(dt_2, old = "user_id", new = "uniq_id")
summary(dt_2)

head(dt_2,n=20)
print(tail(dt_2,n=5))

#
dt2_order <- dt_2[order(cnt_nm , cty_nm),]
#summary(dt2_order)
#head(dt2_order,n=20)
print(length(dt2_order$uniq_id))
#print(tail(dt2_order,n=5))
#
rm(dt_2)

#
## Inner Join == joined by one or more common key variables.
#
# Start the clock!
ptm_ij <- proc.time()

total_dt <- merge(dt1_order,dt2_order, by="uniq_id")
head(total_dt,n=10)

# Print elapsed Times 
print(proc.time() - ptm_ij)
# user  system elapsed 
# 0.036   0.004   0.031 
#

