
# IGNORE GoogleCloud Queries -----------

# SELECT COUNT(*)
# FROM `data-lake-prd-314410.cz.pull-pesquisas-canal-hotel`
# WHERE TIMESTAMP_TRUNC(Data, DAY) BETWEEN TIMESTAMP("2024-12-01") AND TIMESTAMP("2024-12-31");


# SELECT COUNT(DISTINCT CONCAT(Canal_ID, "-", Cidade_ID, "-", Hotel_ID)) AS unique_combinations
# FROM `data-lake-prd-314410.cz.pull-pesquisas`
# WHERE TIMESTAMP_TRUNC(Data, YEAR) = TIMESTAMP("2024-01-01");


# SELECT *
# FROM `data-lake-prd-314410.cz.pull-pesquisas-hotel-ultimos-30-dias`
# WHERE CAST(CheckIn_ID AS STRING) LIKE '2025%' AND Reservas IS NOT NULL;


# SELECT *
# FROM `data-lake-prd-314410.cz.pull-pesquisas-cidade`
# WHERE CAST(CheckIn_ID AS STRING) LIKE '2025%' AND Reservas IS NOT NULL AND
#  TIMESTAMP_TRUNC(Data, YEAR) = TIMESTAMP("2024-01-01") AND EXTRACT(MONTH FROM Data) = 12;



# SELECT Estadia, Cidade_ID, CheckIn_ID, CheckOut_ID, Reservas,DiariaMedia
# FROM `data-lake-prd-314410.cz.pull-pesquisas-cidade`
# WHERE CAST(CheckIn_ID AS STRING) LIKE '2025%' AND Reservas IS NOT NULL AND
#  TIMESTAMP_TRUNC(Data, YEAR) = TIMESTAMP("2024-01-01") AND EXTRACT(MONTH FROM Data) = 11;

 

# SELECT * 
# FROM `data-lake-prd-314410.cz.pull-pesquisas-hotel-ultimos-30-dias`
# WHERE CAST(CheckIn_ID AS STRING) LIKE '2025%' AND  
# Hotel_ID IN (2879, 3090, 2042, 8259, 10883, 3071, 9485, 5252, 17958, 4299, 6451, 4394, 5907, 4391, 2281, 9924, 2774, 2218, 4523, 14140, 2013, 2442, 2182, 4481, 2175, 2231, 4937, 17712, 9098, 4663, 7281, 19238, 5007, 4484, 2642, 4522, 2728, 9694, 2373, 13592, 2619, 8128, 5360, 3073, 13864, 993, 2177, 2169, 2372, 1064, 2176, 2028, 13805, 18516, 2776, 2217, 14919, 2630, 3615, 10771, 2018, 1895, 2022, 8595, 4702, 13494, 4907, 2238, 4654, 13410, 1118, 9745, 4794, 12933, 8276, 3074, 5166, 5462, 18379, 2074, 17663, 2009, 7124, 5586, 13120, 13580, 5882, 5868, 16195, 2623, 3096, 17166, 5395, 2043, 8598, 17253, 5333, 16569, 19956, 1102, 8460, 9396, 6370, 3563, 7389, 991, 14849, 2397, 18681, 2181, 8459, 6324, 6692, 18695, 2017, 4609, 4617, 9633, 18805, 4103, 1314, 3120, 992, 2443, 5180, 13667, 2178, 1169, 2343, 2751, 2094, 6559, 5739, 19787, 5042, 8502, 1069, 18318, 3478, 5519, 2170, 3523, 19036, 2644, 3883, 4800, 2732, 6220, 6837, 989, 1083, 1109, 15619, 4480, 4929, 5034, 18659, 2510, 3795, 2973, 1908, 3165, 5724, 12343, 6219, 18393, 13652, 14043, 1680, 2754, 3976, 2010, 3581, 4820, 4765, 5182, 5423, 13135, 2370, 2997, 9101, 18804, 961, 5599, 9234, 1111, 3218, 1749, 2073, 5520, 1446, 2232, 2620, 1901, 3194, 4273, 5698, 5874, 4445, 13252, 2405, 3072, 16183, 2488, 5273, 5870, 13019, 2939, 1047, 3978, 4744, 13704, 6507, 13766, 2087, 6292, 13875, 2756, 8569, 17138, 2019, 2193, 1337, 3125, 6741, 16510, 5705, 2351, 4927, 10598, 5290, 3197, 5009, 3135, 5529, 5269, 5564, 3139, 2029, 5149, 8519, 1669, 3158, 8641, 6144, 9147, 844, 15353, 4740, 10644, 1344, 5619, 5929, 2020, 2014, 5581, 20432, 2011, 4687, 13890, 4991, 9291, 6633, 2664, 1351, 1082, 6719, 9643, 1144, 9105, 10267, 2817, 10894, 4724, 6093, 12469, 18010, 2628, 5522, 9996, 13243, 10414, 2452, 2617, 3501, 5577, 11574, 4839, 13137, 2938, 5320, 8591, 1341, 3938, 4658, 8455, 9122, 10383, 5291, 6199, 2665, 3716, 1798, 1915, 4661, 5104, 5682, 6818, 13488, 1119, 2928, 4651, 3127, 3398, 3564, 4049, 9997, 3958, 6545, 6894, 2446, 2949, 3483, 13424, 20532, 1772, 8376, 16859, 17144, 3048, 12409, 16875, 2406, 5975, 2183, 4642, 7759, 2047, 4485, 12648, 2637, 2639, 4038, 8872, 13151, 972, 4694, 2926, 7057, 1651, 4537, 5600, 13116, 13138, 14500, 2059, 3771, 6725, 9438, 9720, 2205, 2214, 3136, 4235, 6554, 4696, 8340, 1745, 10372, 1501, 2626, 3791, 6386, 6521, 7576, 19588, 1104, 2449, 10872, 13884, 1235, 2416, 3973, 4527, 2130, 2180, 5909, 7132, 8417, 10386, 19141, 1994, 2220, 5183, 5284, 6787, 12926, 18595, 1813, 2027, 2228, 4620, 5022, 5875, 13663, 2300, 16894, 17695, 18322, 1325, 2082, 2268, 5476, 6116, 8871, 2513, 3092, 5723, 13487, 14064, 14914, 19140, 2349, 7364, 7874, 4015, 11021, 18324, 3484, 4612, 9827, 2221, 4275, 5440, 6175, 6279, 6319, 6453, 17842, 1103, 4942, 13102, 8526, 15411, 1485, 5725, 8915, 14169, 19898, 1114, 1987, 2415, 2494, 2828, 3794, 4056, 5686, 3598, 5262, 6022, 6025, 6174, 6782, 9168, 9264, 2652, 2811, 4967, 5900, 6758, 12997, 14073, 2755, 4657, 19322, 2713, 3007, 3154, 6898, 19755, 2355, 6032, 12344, 18082, 2417, 3656, 3877, 4816, 4998, 1031, 2075, 3817, 7505, 1402, 2184, 2816, 5530, 7456, 1061, 1392, 1971, 2293, 3769, 3793, 5312, 9015, 18563, 2733, 3292, 3329, 4799, 6843, 7971, 11405, 19038, 1744, 2629, 2634, 5768, 5769, 6799, 8353, 10649, 18656, 1663, 3788, 4792, 5937, 6036, 8514, 1005, 1067, 2444, 3081, 4723, 5730, 5984, 6642, 7095, 7395, 8580, 1237, 5411, 5416, 10376, 10729, 1990, 2641, 2676, 2911, 3721, 4138, 5057, 7324, 15573, 19569, 1398, 1898, 3407, 8865, 18801, 20297, 1056, 1764, 2021, 3635, 3664, 5089, 5770, 9164, 1110, 1315, 1393, 2408, 4730, 5463, 18135, 1305, 3079, 3807, 4231, 4489, 5181, 6029, 6037, 6110, 6533, 6839, 10937, 7733, 11196, 18346, 18996, 2813, 3491, 3885, 4568, 5315, 7703, 18022, 1195, 2173, 3132, 5956, 20365, 2251, 3078, 3568, 4629, 4796, 5307, 5591, 5645, 6064, 9221, 12912, 17774, 20386, 2633, 4518, 5354, 5582, 8289, 8303, 3489, 3830, 13185, 1355, 1439, 1904, 1993, 2050, 2311, 2485, 2526, 4040, 5165, 6009, 9185, 13690, 1135, 2058, 2820, 3239, 3825, 5054, 5690, 7224, 7539, 14834, 17753, 1414, 1896, 2305, 5035, 5424, 6810, 7709, 10378, 15783, 18576, 1401, 1746, 2461, 3009, 4122, 5663, 7536, 8709, 8795, 8995, 20230, 2179, 2592, 5693, 5764, 5886, 10416, 14035, 18547, 1303, 1801, 1810, 3480, 4544, 5580, 5977, 6641, 1804, 2207, 3967, 4092, 4298, 6331, 6435, 8953, 10039, 1320, 2131, 3234, 3497, 3525, 4323, 4879, 5282, 7200, 10895, 14620, 15140, 1733, 2104, 2577, 4948, 5080, 5784, 7620, 13139, 16209, 16639, 18069, 1769, 1965, 2185, 2576, 2937, 5279, 9288, 9862, 14026, 15873, 16386, 18771, 1117, 1349, 2242, 2987, 3035, 5058, 6657, 7705, 8964, 9589, 12292, 14047, 14260, 14585, 18481, 20428, 1900, 2071, 2303, 2625, 3432, 4680, 5208, 5430, 5461, 5703, 8620, 15357, 18419, 1156, 1399, 1926, 2386, 3524, 6498, 6723, 6873, 13999, 16369, 17043, 17203, 1070, 1765, 3138, 3968, 7190, 7356, 7444, 7615, 12993, 16653, 17352, 18091, 18367, 1327, 1683, 1996, 3161, 3185, 3193, 4133, 5092, 5965, 10628, 10999, 13544, 19200, 2197, 3540, 4797, 6953, 7555, 7702, 10879, 12275, 19485, 19486, 1910, 2594, 2872, 4721, 4814, 4867, 5217, 5700, 5887, 7401, 11640, 15575, 17398, 18355, 1316, 2991, 3933, 4042, 5011, 5500, 6097, 6578, 8287, 8672, 10797, 12494, 14145, 15001, 16608, 17353, 18557, 1815, 2091, 2493, 2694, 3541, 3851, 4965, 5378, 5687, 5983, 13132, 15648, 17641, 20378, 1142, 2399, 2967, 3186, 4061, 4488, 4697, 5585, 6946, 7537, 9825, 10450, 12702, 19470, 19525, 2101, 2667, 2827, 3502, 3514, 8238, 8294, 8453, 8479, 10161, 1043, 1960, 2414, 4132, 4566, 4787, 5831, 6096, 7246, 12285, 12832, 13430, 15382, 16146, 20505, 1419, 1950, 2213, 2814, 2923, 3177, 3468, 3633, 5688, 6062, 6504, 6592, 6774, 8225, 8593, 9998, 13087, 1234, 1410, 1601, 2079, 2780, 4395, 5838, 6120, 6227, 8662, 9435, 11483, 13504, 13972, 16053, 1054, 1692, 1732, 2593, 2821, 4054, 4055, 5152, 5652, 8266, 8594, 10928, 17660, 18667, 20485, 1028, 1188, 1336, 2224, 2308, 2530, 4244, 4633, 6617, 6755, 7688, 9984, 12932, 12938, 15282, 17313, 19332, 19406, 2066, 4062, 4693, 5503, 5685, 6274, 6335, 6424, 6868, 7150, 8450, 10179, 12867, 16820, 17711, 1905, 1969, 2425, 2770, 3647, 4818, 4980, 5620, 5865, 6215, 6983, 8067, 9470, 10384, 13158, 13984, 17514, 18070, 1339, 2056, 2484, 3220, 3866, 4747, 5293, 5613)
# 


# -------------------------

# Import libraries -----------------
library(tidyverse)
library(data.table)


# hotel_city_chanel_combin_extract <- fread("hotel_city_chanel_combin_extract.csv")
# 
# dt <- hotel_city_chanel_combin_extract
# 
# # Step 1: Get all unique channel-city combinations
# unique_city_channels <- unique(dt[, .(Canal_ID, Cidade_ID)])
# 
# # Step 2: Expand to include all potential channels per city for each hotel
# expanded <- unique(dt[, .(Hotel_ID, Cidade_ID)][unique_city_channels, on = "Cidade_ID", allow.cartesian = TRUE])
# 
# # Step 3: Exclude existing hotel-channel combinations
# missing_channels <- expanded[!dt, on = c("Hotel_ID", "Cidade_ID", "Canal_ID")]
# 
# # Result: missing_channels contains the desired combinations
# print(missing_channels)

# ------------------
# Hotels occupancy Rate 2025 (using only last 30 days bookings) ------------

pull_pesquisas_hotel_ultimos_30_dias_2025_notnull <- fread("pull-pesquisas-hotel-ultimos-30-dias_2025_notnull.csv")

data_lake_prd_314410.cz.cidades <- fread("data-lake-prd-314410.cz.cidades.csv")

data_lake_prd_314410.cz.hoteis <- fread("data-lake-prd-314410.cz.hoteis.csv")

ignore <- data.frame(pull_pesquisas_hotel_ultimos_30_dias_2025_notnull %>% group_by(Hotel_ID) %>% 
  summarise(Reservas=sum(Reservas)) %>%
  arrange(-Reservas) %>% select(Hotel_ID)) %>% slice(1:1000)
  
paste0(ignore$Hotel_ID, collapse=", ")

reservas_2879 <- pull_pesquisas_hotel_ultimos_30_dias_2025_notnull %>% filter(Hotel_ID==2879|
                                                                                Hotel_ID==3090|
                                                                                Hotel_ID==2042|
                                                                                Hotel_ID==8259|
                                                                                Hotel_ID==10883)

reservas_2879$CheckIn_ID <- as.Date(as.character(reservas_2879$CheckIn_ID), format = "%Y%m%d")

reservas_2879$CheckOut_ID <- reservas_2879$CheckIn_ID + reservas_2879$EstadiaMedia

reservas_2879 <- reservas_2879 %>% select(Hotel_ID, CheckIn_ID, CheckOut_ID, Reservas)

reservas_2879 %>% 
  left_join(
    data_lake_prd_314410.cz.hoteis %>% select(Hotel_ID, Quartos)
            )

# Step 1: Generate the sequence of dates for each reservation
reservas_per_day <- reservas_2879 %>%
  group_by(Hotel_ID) %>%
  # Create a row for each day in the reservation period
  rowwise() %>%
  mutate(Dates = list(seq(CheckIn_ID, CheckOut_ID, by = "days"))) %>%
  unnest(Dates) %>%
  select(Hotel_ID, Dates, Reservas) %>% ungroup()

# Step 2: Aggregate the total number of "Reservas" for each day
daily_reservas <- reservas_per_day %>%
  group_by(Hotel_ID, Dates) %>%
  summarise(Total_Reservas = sum(Reservas)) %>%
  arrange(Dates) %>% ungroup()

daily_reservas %>%
  left_join(data_lake_prd_314410.cz.hoteis %>% select(Hotel_ID, Quartos)) %>%
  mutate(Occupancy=Total_Reservas/Quartos) %>%
  mutate(Occupancy=ifelse(Occupancy>1,1,Occupancy)) %>%
  ggplot(aes(Dates, Occupancy*100)) +
  geom_line(size=2, alpha=0.5, colour="deepskyblue4")  +
  geom_point(shape=1, size=2, stroke=1, colour="firebrick") +
  geom_smooth( colour="deepskyblue4", fill="firebrick", alpha=0.1) +
  theme_minimal() +
  facet_wrap(~Hotel_ID) +
  xlab("\n Exact Dates [2025]") + ylab("Occupancy Rate (%) \n")


daily_reservas %>%
  left_join(data_lake_prd_314410.cz.hoteis %>% select(Hotel_ID, Quartos,Cidade_ID)) %>%
    left_join(data_lake_prd_314410.cz.cidades %>% select(Cidade_ID, Cidade)) %>%
  mutate(Occupancy=Total_Reservas/Quartos) %>%
  mutate(Occupancy=ifelse(Occupancy>1,1,Occupancy)) %>%
  ggplot(aes(Dates, Occupancy*100)) +
  geom_line(size=2, alpha=0.5, colour="deepskyblue4")  +
  geom_point(shape=1, size=2, stroke=1, colour="firebrick") +
  geom_smooth( colour="deepskyblue4", fill="firebrick", alpha=0.1) +
  theme_minimal() +
  facet_wrap(~Cidade) +
  xlab("\n Exact Dates [2025]") + ylab("Occupancy Rate (%) \n")


# ------------

# Cost per day vs city average -----------

data_lake_prd_314410.cz.cidades <- fread("data-lake-prd-314410.cz.cidades.csv")
data_lake_prd_314410.cz.hoteis <- fread("data-lake-prd-314410.cz.hoteis.csv")

pull_pesquisas_hotel_ultimos_30_dias_2025_notnull <- fread("pull-pesquisas-hotel-ultimos-30-dias_2025_notnull.csv")
pull_pesquisas_hotel_ultimos_30_dias_2025_notnull$CheckIn_ID <- as.Date(as.character(pull_pesquisas_hotel_ultimos_30_dias_2025_notnull$CheckIn_ID), format = "%Y%m%d")
pull_pesquisas_hotel_ultimos_30_dias_2025_notnull$CheckOut_ID <- pull_pesquisas_hotel_ultimos_30_dias_2025_notnull$CheckIn_ID + pull_pesquisas_hotel_ultimos_30_dias_2025_notnull$EstadiaMedia
pull_pesquisas_hotel_ultimos_30_dias_2025_notnull <- pull_pesquisas_hotel_ultimos_30_dias_2025_notnull %>% select(Hotel_ID, CheckIn_ID, CheckOut_ID, Reservas,DiariaMediaReservaUSD )

# Step 1: Generate the sequence of dates for each reservation
pull_pesquisas_hotel_ultimos_30_dias_2025_notnull <- pull_pesquisas_hotel_ultimos_30_dias_2025_notnull %>%
  group_by(Hotel_ID) %>%
  # Create a row for each day in the reservation period
  rowwise() %>%
  mutate(Dates = list(seq(CheckIn_ID, CheckOut_ID, by = "days"))) %>%
  unnest(Dates) %>%
  select(Hotel_ID, Dates, Reservas, DiariaMediaReservaUSD ) %>% ungroup()

# Step 2: Aggregate the total number of "Reservas" for each day
pull_pesquisas_hotel_ultimos_30_dias_2025_notnull <- pull_pesquisas_hotel_ultimos_30_dias_2025_notnull %>%
  group_by(Hotel_ID, Dates) %>%
  summarise(Total_Reservas = sum(Reservas), DiariaMediaReservaUSD=mean(DiariaMediaReservaUSD)) %>%
  arrange(Dates) %>% ungroup()



pull_pesquisas_cidade_ultimos_30_dias_2025_notnull <- fread("pull-pesquisas-cidade-ultimos-30-dias_2025_notnull.csv")

pull_pesquisas_cidade_ultimos_30_dias_2025_notnull$CheckIn_ID <- as.Date(as.character(pull_pesquisas_cidade_ultimos_30_dias_2025_notnull$CheckIn_ID), format = "%Y%m%d")

pull_pesquisas_cidade_ultimos_30_dias_2025_notnull$CheckOut_ID <- pull_pesquisas_cidade_ultimos_30_dias_2025_notnull$CheckIn_ID + pull_pesquisas_cidade_ultimos_30_dias_2025_notnull$EstadiaMedia

pull_pesquisas_cidade_ultimos_30_dias_2025_notnull <- pull_pesquisas_cidade_ultimos_30_dias_2025_notnull %>% select(Cidade_ID, CheckIn_ID, CheckOut_ID, Reservas,DiariaMediaReservaUSD )

# Step 1: Generate the sequence of dates for each reservation
pull_pesquisas_cidade_ultimos_30_dias_2025_notnull <- pull_pesquisas_cidade_ultimos_30_dias_2025_notnull %>% drop_na() %>%
  group_by(Cidade_ID ) %>%
  # Create a row for each day in the reservation period
  rowwise() %>%
  mutate(Dates = list(seq(CheckIn_ID, CheckOut_ID, by = "days"))) %>%
  unnest(Dates) %>%
  select(Cidade_ID , Dates, Reservas, DiariaMediaReservaUSD ) %>% ungroup()

# Step 2: Aggregate the total number of "Reservas" for each day
pull_pesquisas_cidade_ultimos_30_dias_2025_notnull <- pull_pesquisas_cidade_ultimos_30_dias_2025_notnull %>%
  group_by(Cidade_ID, Dates) %>%
  summarise(Total_Reservas = sum(Reservas), DiariaMediaReservaUSD=mean(DiariaMediaReservaUSD)) %>%
  arrange(Dates) %>% ungroup()

names(pull_pesquisas_cidade_ultimos_30_dias_2025_notnull)[3] <- "Total_Reservas_city"
names(pull_pesquisas_cidade_ultimos_30_dias_2025_notnull)[4] <- "DiariaMediaReservaUSD_city"

names(pull_pesquisas_hotel_ultimos_30_dias_2025_notnull)[3] <- "Total_Reservas_hotel"
names(pull_pesquisas_hotel_ultimos_30_dias_2025_notnull)[4] <- "DiariaMediaReservaUSD_hotel"

pull_pesquisas_hotel_ultimos_30_dias_2025_notnull %>%
  left_join(data_lake_prd_314410.cz.hoteis %>% select(Hotel_ID, Cidade_ID)) %>%
  full_join(pull_pesquisas_cidade_ultimos_30_dias_2025_notnull %>% select(Cidade_ID, Dates, Total_Reservas_city , DiariaMediaReservaUSD_city)) %>%
  filter(Hotel_ID==2879|Hotel_ID==3090|Hotel_ID==2042|Hotel_ID==8259|Hotel_ID==10883) %>%
  select(Hotel_ID, Cidade_ID, Dates, DiariaMediaReservaUSD_hotel, DiariaMediaReservaUSD_city) %>%
  gather(Which, value, DiariaMediaReservaUSD_hotel:DiariaMediaReservaUSD_city) %>%
      left_join(data_lake_prd_314410.cz.cidades %>% select(Cidade_ID, Cidade)) %>%
  mutate(Which=ifelse(Which=="DiariaMediaReservaUSD_hotel", "Hotel", "City")) %>%
  ggplot(aes(Dates, value, colour=Which, fill=Which)) +
  geom_smooth(se=F, method="gam", size=1) +
  geom_jitter(shape=1, size=2, stroke=1,alpha=0.5) +
  facet_wrap(~Cidade) +
  theme_minimal() +
  xlab("\n Exact Dates [2025]") + ylab("Average Cost $ \n") +
  scale_fill_manual(values=c("firebrick", "deepskyblue4")) +
  scale_colour_manual(values=c("firebrick", "deepskyblue4"))



pull_pesquisas_hotel_ultimos_30_dias_2025_notnull %>%
    filter(Hotel_ID==2879|Hotel_ID==3090|Hotel_ID==2042|Hotel_ID==8259|Hotel_ID==10883) %>%
  left_join(data_lake_prd_314410.cz.hoteis %>% select(Hotel_ID, Quartos)) %>%
  mutate(Occupancy=Total_Reservas_hotel /Quartos) %>%
  mutate(Occupancy=ifelse(Occupancy>1,1,Occupancy)) %>%
    left_join(data_lake_prd_314410.cz.hoteis %>% select(Hotel_ID, Cidade_ID)) %>%
        left_join(data_lake_prd_314410.cz.cidades %>% select(Cidade_ID, Cidade)) %>%
  ggplot(aes(Dates, Occupancy*100)) +
  geom_line(size=1, alpha=0.5, colour="deepskyblue4")  +
  geom_point(shape=1, size=2, stroke=1, colour="firebrick") +
  geom_smooth( colour="deepskyblue4", fill="firebrick", alpha=0.1) +
  theme_minimal() +
  facet_wrap(~Cidade) +
  xlab("\n Exact Dates [2025]") + ylab("Occupancy Rate (%) \n")

# ----------

# Reservations vs requests ------------
pull_pesquisas_hotel_ultimos_30_dias_1000random <- fread("pull-pesquisas-hotel-ultimos-30-dias_1000random.csv")

pull_pesquisas_hotel_ultimos_30_dias_1000random %>% 
        filter(Hotel_ID==2879|Hotel_ID==3090|Hotel_ID==2042|Hotel_ID==8259|Hotel_ID==10883) %>%
  select(Hotel_ID, CheckIn_ID , DiariaMediaOfertaUSD, DiariaMediaReservaUSD, Requests, Reservas) %>%
  mutate(ratio=1000*Reservas/Requests) %>%
  select(Hotel_ID, ratio, DiariaMediaOfertaUSD) %>%
  ggplot(aes(DiariaMediaOfertaUSD, ratio)) +
  geom_smooth(method="gam", se=FALSE, colour="deepskyblue4", fill="firebrick", alpha=0.2) +
  theme_minimal() + 
  facet_wrap(~Hotel_ID) +
  coord_cartesian(xlim=c(0,1000) ) +
  xlab("\n Average Daily Offer Price $") + 
  ylab("Ratio Reservation-to-Requests x 1,000\n")


pull_pesquisas_hotel_ultimos_30_dias_1000random %>%
          #filter(Hotel_ID==2879|Hotel_ID==3090|Hotel_ID==2042|Hotel_ID==8259|Hotel_ID==10883) %>%
  group_by(DiariaMediaOfertaUSD) %>% summarise(Reservas=sum(Reservas)) %>%
  ungroup() %>% drop_na() %>%
  select(DiariaMediaOfertaUSD) %>% distinct()
  ggplot(aes(DiariaMediaOfertaUSD, Reservas)) +
  geom_smooth() + 



 pull_pesquisas_hotel_ultimos_30_dias_1000random %>% 
  select(CheckIn_ID , DiariaMediaOfertaUSD, DiariaMediaReservaUSD, Requests, Reservas) %>%
  mutate(ratio=1000*Reservas/Requests) %>%
  select(ratio, DiariaMediaOfertaUSD) %>%
  drop_na() %>%
  summarise(cor=cor(ratio ,DiariaMediaOfertaUSD ))



pull_pesquisas_hotel_ultimos_30_dias_1000random$CheckIn_ID <- as.Date(as.character(pull_pesquisas_hotel_ultimos_30_dias_1000random$CheckIn_ID), format = "%Y%m%d")

pull_pesquisas_hotel_ultimos_30_dias_1000random$CheckOut_ID <- pull_pesquisas_hotel_ultimos_30_dias_1000random$CheckIn_ID + pull_pesquisas_hotel_ultimos_30_dias_1000random$EstadiaMedia

pull_pesquisas_hotel_ultimos_30_dias_1000random

# Step 1: Generate the sequence of dates for each reservation
pull_pesquisas_hotel_ultimos_30_dias_1000random <- pull_pesquisas_hotel_ultimos_30_dias_1000random %>%
      filter(Hotel_ID==2879|Hotel_ID==3090|Hotel_ID==2042|Hotel_ID==8259|Hotel_ID==10883) %>%
  select(Hotel_ID, CheckIn_ID, CheckOut_ID, Requests, Reservas) %>%
  group_by(Hotel_ID ) %>%
  # Create a row for each day in the reservation period
  rowwise() %>%
  mutate(Dates = list(seq(CheckIn_ID, CheckOut_ID, by = "days"))) %>%
  unnest(Dates) %>% ungroup() %>% distinct() 

pull_pesquisas_hotel_ultimos_30_dias_1000random %>%
    left_join(data_lake_prd_314410.cz.hoteis %>% select(Hotel_ID, Cidade_ID)) %>%
        left_join(data_lake_prd_314410.cz.cidades %>% select(Cidade_ID, Cidade)) %>%
   ggplot(aes(Dates, 1000*Reservas/Requests)) +
  geom_smooth(se=F, method="gam", size=1) +
  geom_jitter(shape=1, size=1, stroke=1,alpha=0.5) +
  facet_wrap(~Cidade) +
  theme_minimal() +
  xlab("\n Exact Dates [2025]") + ylab("Ratio Reservation-to-Requests x 1,000\n") +
  scale_fill_manual(values=c("firebrick", "deepskyblue4")) +
  scale_colour_manual(values=c("firebrick", "deepskyblue4"))


# --------
# Unavailability reasons ---------------

data_lake_prd_314410.cz.pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_5hotels <- fread("data_lake_prd_314410.cz.pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_5hotels.csv")

data_lake_prd_314410.cz.pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_5hotels %>%
  group_by(MotivoIndisponibilidade_ID) %>% count() %>%
  arrange(-n)

data_lake_prd_314410.cz.pull_motivo_indisponibilidade <- fread("data-lake-prd-314410.cz.pull-motivo-indisponibilidade.csv")

data_lake_prd_314410.cz.pull_motivo_indisponibilidade %>% select(-CodigoMotivoIndisponibilidade) %>%
  inner_join(
data_lake_prd_314410.cz.pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_5hotels %>%
  group_by(Hotel_ID , MotivoIndisponibilidade_ID) %>% count() 
) %>% arrange(Hotel_ID, -n)
 

#     MotivoIndisponibilidade_ID          Motivo_Indisponibilidade     n
#  1:                       -514            Closed day restriction 11603
#  2:                     -10004 Found price not greater than zero  6382
#  3:                       -512               Max adults exceeded  5982
#  4:                       -515           Minimum LOS restriction  5530
#  5:                       -513             Max children exceeded  3206
#  6:                       -511                Max room occupancy  2457
#  7:                       -523                 Rate not for sale  2205
#  8:                       -500           Allotment not available  1794
#  9:                     -10001                   Rate not active  1714
# 10:                       -520   Closed on departure restriction   692
# 11:                     -10003               Prices not released   446
# 12:                       -528     Rate exclusive for promoCodes   276
# 13:                       -519     Closed on arrival restriction   146
# 14:                      -3002              Invalid payment type    96



pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_1000randomhotels <- fread("pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_1000randomhotels.csv")

pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_1000randomhotels %>%
  group_by(MotivoIndisponibilidade_ID) %>% summarise(n=sum(RequestsIndisponiveis)) %>%
  arrange(-n)

data_lake_prd_314410.cz.pull_motivo_indisponibilidade <- fread("data-lake-prd-314410.cz.pull-motivo-indisponibilidade.csv")


temp <- data_lake_prd_314410.cz.pull_motivo_indisponibilidade %>% select(-CodigoMotivoIndisponibilidade) %>%
  inner_join(
    pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_1000randomhotels %>%
  group_by(Hotel_ID , MotivoIndisponibilidade_ID) %>% summarise(n=sum(RequestsIndisponiveis))  %>%
    spread(key=Hotel_ID, value=n)
)
 
data_lake_prd_314410.cz.pull_motivo_indisponibilidade %>% select(-CodigoMotivoIndisponibilidade) %>%
  inner_join(
    pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_1000randomhotels %>%
  group_by( MotivoIndisponibilidade_ID) %>% summarise(n=sum(RequestsIndisponiveis))
  ) %>% arrange(-n)
  

temp <- pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_1000randomhotels %>%
  group_by(Hotel_ID) %>% summarise(n=sum(RequestsIndisponiveis)) %>%
  arrange(-n) %>%
  mutate(rownum=row_number()) %>%
  mutate(rownum=ifelse(rownum>=20, 20, rownum)) %>% select(-n) %>%
  left_join(
     pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_1000randomhotels %>%
  group_by(Hotel_ID , MotivoIndisponibilidade_ID) %>% summarise(n=sum(RequestsIndisponiveis)) 
  ) %>% ungroup() %>%
  group_by(rownum, MotivoIndisponibilidade_ID) %>% summarise(n=sum(n)) %>%
  left_join(data_lake_prd_314410.cz.pull_motivo_indisponibilidade %>% select(-CodigoMotivoIndisponibilidade) ) %>%
  spread(key=rownum, value=n)


fwrite(temp, "temp.csv")   


# 3090 2042  10883
pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_1000randomhotels %>%
 # filter(Hotel_ID==3090) %>%
  group_by(Antecedencia, MotivoIndisponibilidade_ID) %>%
  summarise(n=sum(RequestsIndisponiveis)) %>%
  filter(Antecedencia>=0) %>% ungroup() %>%
  group_by(Antecedencia) %>% mutate(tot=sum(n)) %>%
  mutate(n=n/tot) %>% ungroup() %>%
  left_join(data_lake_prd_314410.cz.pull_motivo_indisponibilidade %>% select(-CodigoMotivoIndisponibilidade)) %>%
  drop_na() %>%
  left_join(pull_pesquisas_indisponibilidade_canal_ultimos_30_dias_1000randomhotels %>%
     #           filter(Hotel_ID==3090) %>%
  group_by(MotivoIndisponibilidade_ID) %>%
  summarise(n=sum(RequestsIndisponiveis))  %>%
  arrange(-n) %>% mutate(rownum=row_number()) %>%
  mutate(newid=ifelse(rownum>=6,"Other", rownum)) %>%
  select(MotivoIndisponibilidade_ID, newid)
  ) %>%
  mutate(Motivo_Indisponibilidade=ifelse(newid=="Other", "Other", Motivo_Indisponibilidade)) %>%
  ggplot(aes(Antecedencia, n*100,
             colour=Motivo_Indisponibilidade,
             fill=Motivo_Indisponibilidade)) +
  # geom_line() +
  geom_smooth(method="loess", se=F) +
  theme_minimal() +
  xlab("\n Request # Days in Advance") + ylab("% Unavailability Reason  \n") +
  scale_colour_manual(values=c("#ecc613", "#c9342a", "#2aa5c9", "#a0cc4a", "#7f4696", "#9d9d9d")) +
  scale_fill_manual(values=c("#ecc613", "#c9342a", "#2aa5c9", "#a0cc4a", "#7f4696", "#9d9d9d")) +
  coord_cartesian(ylim=c(0,100))
    
# ------


