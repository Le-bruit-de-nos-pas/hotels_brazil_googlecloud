
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


