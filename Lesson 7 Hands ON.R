#Load libraries
library("rcompanion")
library("car")
library("effects")
library("multcomp")

#Check for normality
plotNormalHistogram(cellPhone$`Night Mins`)
#Plot looks normal so we will proceed.

#Check for homogeneity
leveneTest(cellPhone$`Night Mins`~cellPhone$`International Plan`, data = cellPhone)
#The results are signifigant so the asssumption is met.

#Check the regression slope
homo_regslp = lm(cellPhone$`Night Mins`~cellPhone$`vMail Plan`, data = cellPhone)
anova(homo_regslp)
#This is also significant so we move on 
#You have over 4,000 entries so you have met the sample size

#Run the analysis
Ancova2 = lm(cellPhone$`Night Mins`~cellPhone$`vMail Plan` + cellPhone$`International Plan`*cellPhone$`vMail Plan`, data = cellPhone)
anova(Ancova2)

#Looks like it doesn't matter if you have an international plan or vmail plan the same number of nights minutes are used.





