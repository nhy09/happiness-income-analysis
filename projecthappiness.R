install.packages("dplyr")
install.packages("ggplot2")
install.packages("tidyverse")


library(dplyr)
library(ggplot2)
library(tidyverse)
setwd("/Users/shm52/Downloads/")
df <- read_csv("happinessreport.csv")

head(df)

df$income_num <- case_when(
  df$`Income Group` == "Low income" ~ 1,
  df$`Income Group` == "Lower middle income" ~ 2,
  df$`Income Group` == "Upper middle income" ~ 3,
  df$`Income Group` == "High income" ~ 4
)

df <- na.omit(df)


cor(df$income_num, df$`Ladder score`)


ggplot(df, aes(x = income_num, y = `Ladder score`)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Income Level vs Happiness",
       x = "Income Level (1=Low, 4=High)",
       y = "Happiness Score") +
  theme_minimal()

df %>% group_by(`Income Group`) %>% summarise(
  mean = mean(`Ladder score`),
  sd = sd(`Ladder score`),
  n = n()
)