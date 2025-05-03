rm(list = ls())

install.packages("PairedData")
library(PairedData)

head(anorexia)

table(anorexia$Treat)

ggplot(data = anorexia, aes(x = Treat)) +
  geom_bar(aes(fill = factor(Treat)), width = 0.75)+
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6))

# "Cont" refers to the control group, we can get rid of those and only
# focus on the participants who received behavioral treatment or family
# treatment and see whether the treatment was effective

anorexia.subset = anorexia[anorexia$Treat != "Cont", ]
head(anorexia.subset)

ggplot(data = anorexia.subset, aes(x = Treat)) +
  geom_bar(aes(fill = factor(Treat)), width = 0.75)+
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6))

ggplot(anorexia.subset, aes(x = Prewt)) + 
  geom_histogram(col = "red", fill="yellow") 

ggplot(anorexia.subset, aes(x = Postwt)) + 
  geom_histogram(col = "green", fill="darkgreen") 

# The data is normally distributed
qqnorm(anorexia.subset$Prewt, pch = 20, col = "darkgreen")
qqline(anorexia.subset$Prewt, col = 'red', lwd = 2.5)

qqnorm(anorexia.subset$Postwt, pch = 20, col = "darkgreen")
qqline(anorexia.subset$Postwt, col = 'red', lwd = 2.5)

shapiro.test(anorexia.subset$Prewt)

shapiro.test(anorexia.subset$Postwt)


# The differences between pairs of data are normally distributed
wt.diff <- anorexia.subset$Postwt - anorexia.subset$Prewt

qqnorm(wt.diff, pch = 20, col = "darkgreen")
qqline(wt.diff, col = 'red', lwd = 2.5)

shapiro.test(wt.diff)

# Reject the null hypothesis. The treatments were indeed effective. The change
# in weight for the patients was significant
t.test(anorexia.subset$Postwt, anorexia.subset$Prewt, paired = TRUE)

###################################################################
# Now let us see the difference in the weights for the control group
###################################################################s

anorexia.control = anorexia[anorexia$Treat == "Cont", ]
head(anorexia.control)

# The data is normally distributed
qqnorm(anorexia.control$Prewt, pch = 20, col = "darkblue")
qqline(anorexia.control$Prewt, col = 'red', lwd = 2.5)

qqnorm(anorexia.control$Postwt, pch = 20, col = "darkblue")
qqline(anorexia.control$Postwt, col = 'red', lwd = 2.5)

shapiro.test(anorexia.control$Prewt)

shapiro.test(anorexia.control$Postwt)

# The differences between pairs of data are normally distributed
wt.diff <- anorexia.control$Postwt - anorexia.control$Prewt

qqnorm(wt.diff, pch = 20, col = "darkblue")
qqline(wt.diff, col = 'red', lwd = 2.5)

shapiro.test(wt.diff)

# Accept the null hypothesis. The weight changes in the control group were
# not significant
t.test(anorexia.control$Postwt, anorexia.control$Prewt, paired = TRUE)































































