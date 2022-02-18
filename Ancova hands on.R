#Test for normality
plotNormalHistogram(graduate_admissions$CGPA)
#That looks almost normal but will square to see if it is better.
cgpaSQ <- graduate_admissions$CGPA * graduate_admissions$CGPA
plotNormalHistogram(cgpaSQ)
plotNormalHistogram(graduate_admissions$`TOEFL Score`)
toeflSQ <- graduate_admissions$`TOEFL Score` ^2
plotNormalHistogram(toeflSQ)
#We will use the square of both since they look a little better 

#Now we test for homogeneity
leveneTest(cgpaSQ ~ graduate_admissions$`University Rating`, data = graduate_admissions)
#The results are not signifigant so the assumption is met

#Now we test for homogeneity regression slopes
homogeneity_regslp <- lm(graduate_admissions$CGPA~graduate_admissions$`TOEFL Score`, data = graduate_admissions)
anova(homogeneity_regslp)
#The assumption is not met here.
#With 400 entries you have the correct sample size.

#Now we run the analysis
ANCOVA1 = lm(graduate_admissions$CGPA~graduate_admissions$`TOEFL Score` + graduate_admissions$`University Rating`, data = graduate_admissions)
anova(ANCOVA1)

#Post Hocs
postHoc <- glht(ANCOVA1, linfct = mcp(graduate_admissions$`University Rating`)= "Tukey")
summary(postHOC)

#Now find the Means
adjMeans <- effect(graduate_admissions$`University Rating`, ANCOVA1)
adjMeans



