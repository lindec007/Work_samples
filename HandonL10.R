library(Ecdat)
head(Cigarette)
View(Cigarette)

ggplot(Cigarette, aes(x = packpc, y = pop)) + geom_boxplot() +(aes(group = state)) + ggtitle("Average number of packs per capita by state")
arrange(Cigarette, packpc)

numpks_state <- select(Cigarette, state, packpc, year)
arrange(numpks_state,desc(packpc))
arrange(numpks_state, packpc)

med_pks <- numpks_state %>% group_by(year) %>% summarize(ave.pks = median(packpc))

d<- ggplot(med_pks, aes(x = ave.pks, y = year))
d + geom_line() + ggtitle("Average Packs per Year") + xlab("Average Packs") 

d <- ggplot(Cigarette, aes( x = avgprs, y = packpc, color = year))
d + geom_point(aes(alpha = year)) + geom_smooth(method = lm, se = FALSE) + ggtitle("Price of Packs vs Pack per Person") + xlab("Average price per pack") + ylab("Pack per capita") 

lin_reg <- lm(avgprs ~ packpc)
lin_reg
summary(lin_reg)

Cigarette2 <- Cigarette %>% mutate(priceadj = avgprs / cpi)
ggplot(Cigarette2, aes(x=priceadj, y=packpc)) + geom_point()
ggplot(Cigarette2, aes(x=priceadj, y=packpc, color = year)) + geom_point() +xlab( "Adjusted price") + ylab("Packs per Capita") +ggtitle("Inflation prices")
ciglm2 <- lm(packpc ~ priceadj, Cigarette2)
summary(ciglm2)

df_1985 <- filter(Cigarette, year %in% c(1985))

df_1995 <- filter(Cigarette, year %in% c(1995))

v_1985 <- c(116.48628, 128.53459, 104.52261, 100.36304, 112.96354, 109.27835, 143.85114,
            122.18112, 127.23462, 113.74558, 103.01811, 123.20848, 137.63737, 116.68040,
            186.03519, 127.55727, 115.67760, 120.97871, 128.11694, 128.00485, 112.90323, 
            130.37393, 117.04018, 104.25790, 155.28377, 105.46529, 107.38171, 197.99399,
            116.52128, 88.74218, 141.95584, 116.66292, 127.59874, 127.13937, 119.45380,
            117.70303, 132.78178, 127.20944, 106.59026, 129.83459, 115.10293, 68.04626,
            134.00980, 145.28302, 96.22813, 107.87700, 112.84740, 129.39999)

v_1995 <- c(101.08543, 111.04297, 71.95417, 56.85931, 82.58292, 79.47219, 
            124.46660, 93.07455, 97.47462, 92.40160, 74.84978, 83.26508,
            134.25835, 88.75344, 172.64778, 105.17613, 76.62064, 77.47355,
            102.46978, 81.38825, 82.94530, 122.45028, 105.58245, 87.15957,
            121.538061, 79.80697, 87.27071, 156.33675, 80.37137, 64.66887,
            93.53612, 70.81732, 111.38010, 108.68011, 92.15575, 95.64309,
            92.59980, 108.08275, 97.21923, 122.32005, 73.07931, 49.27220, 
            105.38687, 122.33475, 65.530921, 92.46635, 115.56883, 112.23814)

cigarette3 <- data.frame(v_1985, v_1995)
d_test <- t.test(cigarette3$v_1985, cigarette3$v_1995, paired = TRUE)
d_test

cor.test(Cigarette$income, Cigarette$packpc, method = "pearson", use = "complete.obs")
d <- ggplot(Cigarette, aes(x = packpc, y = income))
d + geom_point() + geom_smooth(method = lm, se = FALSE) + ggtitle("Income vs Pack per Capita Correlation") + xlab("Pack per Capita") + ylab("Income")












