#Load libraries
library('gmodels')
library('dplyr')

#Part I
CrossTable(loans$term, loans$loan_status, chisq = TRUE, expected = TRUE, sresid = TRUE, format = "SPSS")
# p value is more than .05 so there is not a term of the loan doesn't seem to affect the loan status.

#Part II
loans$DateR <- as.Date(paste(loans$Date), "%m/%d/%Y")

loans1 <- separate(loans, DateR, c("Year", "Month", "Day"), sep="-")

loans1$YearR <- NA
loans1$YearR[loans1$Year <= 2009] <- 0
loans1$YearR[loans1$Year > 2009] <- 1

loans1$RentvOwn <- NA
loans1$RentvOwn[loans1$home_ownership == "RENT"] <- 0
loans1$RentvOwn[loans1$home_ownership == "OWN"] <- 1

CrossTable(loans1$RentvOwn, loans1$YearR, fisher=TRUE, chisq = TRUE, mcnemar = TRUE, expected = TRUE, sresid=TRUE, format="SPSS")
#p value on this is also above .05 so there doesn't seem to be much of a difference in home ownership after 2009.

#Part III
loans%>%group_by(loan_status)%>% summarise(count=n())
observed = c(18173,3282)
expected=c(.15,.10)
chisq.test(x=observed, p=expected)
#The question states that 15% of the population has their homes fully paid for
#and 10% have charged off, this is only 35% of the population.  In order to run 
#a goodness of fit chi square your expected value must equal 1.  With 35% of the 
#population you are still missing 65% of the population.  So the data for the article
#seems to have come from a larger population than the data we have on loans.






