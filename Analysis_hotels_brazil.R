
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

pull_pesquisas_hotel_ultimos_30_dias_2025_notnull %>% group_by(Hotel_ID) %>% 
  summarise(Reservas=sum(Reservas)) %>%
  arrange(-Reservas)
  
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
