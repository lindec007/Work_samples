#Load libraries
library("rcompanion")
library("car")
library("IDPmisc")
library("dplyr")

#Check normality
plotNormalHistogram(suicide$`suicides/100k pop`)

#This is positively skewed so we will take square root
suicides1SQRT <- sqrt(suicide$`suicides/100k pop`)
plotNormalHistogram(suicides1SQRT)

#Still shows positively skewed so we will take Log.
suicide$`suicides/100k pop`[suicide$`suicides/100k pop`==0]= NA
suicides1LOG <- log(suicide$`suicides/100k pop`)
plotNormalHistogram(suicides1LOG)
#This is closer so we will use the log.
suicide4 <- NaRV.omit(suicide)

#Now do the homogeneity test
leveneTest(suicides1LOG ~ generation, data = suicide)

#This is a failed assumption. We will continue with the analysis.
#Run analysis
RManova1 <- aov(suicides1LOG ~ (generation*year)+Error(country-year),suicide)
summary(RManova1)

#post hoc
pairwise.t.test(suicide$`suicides/100k pop`, suicide$generation, p.adjust = "bonferroni")

#Determine Means
suicideMeans <- suicide %>% group_by(generation, year) %>% summarise(Mean = mean(`suicides/100k pop`))
summary(suicideMeans)
#Looks like generation X is the least likely to commit suicide.
