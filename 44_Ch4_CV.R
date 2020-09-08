# BRADY NAHKALA
# LAST REVISED: 20 MAR 2020
# updated wtih new data on last revised date
#  03.31.2020 - regenerated data

# PURPOSE =================
# DATA MANIPULATION FOR TABLE/GRAPH IN 
# PUB 02 (THESIS) SECTION 4.3.1

# LIBRARY =================
library(dplyr)
library(ggplot2)
library(tidyr)
library(ggpubr)
library(grid)
library(gridExtra)
library(gtable)
# library(xtable)
# library(sjPlot)
# library(stargazer)
# library(expss)
# library(tables)

# DATA ====================
data.sensitivity <- m.sensitivity.full
data.sensitivity.cm3 <- cm3.sensitivity.full
data.sensitivity.cm6 <- cm6.sensitivity.full

    # regression ==========
data.mtry <- data.sensitivity %>%
  group_by(mtry) %>%
  summarize(meanrsqc=mean(avgc), meanrsqv=mean(avgv)) %>%
  mutate_at(2:3, funs(round(., 2)))
 
data.ntree <- data.sensitivity %>%
  group_by(ntree) %>%
  summarize(meanrsqc=mean(avgc), meanrsqv=mean(avgv))%>%
  mutate_at(2:3, funs(round(., 2)))

data.seed <- data.sensitivity %>%
  group_by(seed) %>%
  summarize(meanrsqc=mean(avgc), meanrsqv=mean(avgv)) %>%
  mutate_at(2:3, funs(round(., 2)))
  
data.seed <- data.seed %>% gather(key="Test.Set", value="RSQ", -seed)

    # cm3 =================
data.mtry.cm3 <- data.sensitivity.cm3 %>%
  group_by(mtry) %>%
  summarize(meanerrc=mean(avgc), meanerrv=mean(avgv)) %>%
  mutate_at(2:3, funs(round(., 2)))

data.ntree.cm3 <- data.sensitivity.cm3 %>%
  group_by(ntree) %>%
  summarize(meanerrc=mean(avgc), meanerrv=mean(avgv))%>%
  mutate_at(2:3, funs(round(., 2)))

data.seed.cm3 <- data.sensitivity.cm3 %>%
  group_by(seed) %>%
  summarize(meanerrc=mean(avgc), meanerrv=mean(avgv)) %>%
  mutate_at(2:3, funs(round(., 2)))

data.seed.cm3 <- data.seed.cm3 %>% gather(key="Test.Set", value="err", -seed)

    # cm6 =================
data.mtry.cm6 <- data.sensitivity.cm6 %>%
  group_by(mtry) %>%
  summarize(meanerrc=mean(avgc), meanerrv=mean(avgv)) %>%
  mutate_at(2:3, funs(round(., 2)))

data.ntree.cm6 <- data.sensitivity.cm6 %>%
  group_by(ntree) %>%
  summarize(meanerrc=mean(avgc), meanerrv=mean(avgv))%>%
  mutate_at(2:3, funs(round(., 2)))

data.seed.cm6 <- data.sensitivity.cm6 %>%
  group_by(seed) %>%
  summarize(meanerrc=mean(avgc), meanerrv=mean(avgv)) %>%
  mutate_at(2:3, funs(round(., 2)))

data.seed.cm6 <- data.seed.cm6 %>% gather(key="Test.Set", value="err", -seed)



# REGRESSION ==============
  # TABLE ===================
g1 <- ggtexttable(data.mtry, rows=NULL, theme=ttheme("blank"), cols=c("Input Variables Tested", "Average RSQ of Calibration", "Average RSQ of Validation"))
g2 <- ggtexttable(data.ntree, rows=NULL, theme=ttheme("blank"), cols=c("Number of Trees", "Average RSQ of Calibration", "Average RSQ of Validation"))


  # GRAPHS ==================
plot.seed <- ggplot(data.seed, aes(x=seed, y=RSQ, color=Test.Set))+
  geom_point()
  # geom_point(data=data.seed, aes(x=seed, y=meanrsqv, color="red"))
plot.seed

png(filename = "plot_seed.png", height=500, width = 500)
# windows()
plot.seed
dev.off()

g <- grid.arrange(g1, g2, nrow=2)
png(filename = "grid_sens.png", height=500, width = 1000)
# windows()
grid.arrange(plot.seed, g, ncol=2)
dev.off()

# CM3 ==============
  # TABLE ===================
g1cm3 <- ggtexttable(data.mtry.cm3, rows=NULL, theme=ttheme("blank"), cols=c("Input Variables Tested", "Average OOB Error of Calibration", "Average OOB Error of Validation"))
g2cm3 <- ggtexttable(data.ntree.cm3, rows=NULL, theme=ttheme("blank"), cols=c("Number of Trees", "Average Error of Calibration", "Average Error of Validation"))

  # GRAPHS ==================
plot.seed.cm3 <- ggplot(data.seed.cm3, aes(x=seed, y=err, color=Test.Set))+
  geom_point()
# geom_point(data=data.seed, aes(x=seed, y=meanrsqv, color="red"))
plot.seed.cm3

png(filename = "plot_seed_cm3.png", height=500, width = 500)
# windows()
plot.seed.cm3
dev.off()

g.cm3 <- grid.arrange(g1cm3, g2cm3, nrow=2)
png(filename = "grid_sens_cm3.png", height=500, width = 1000)
# windows()
grid.arrange(plot.seed.cm3, g.cm3, ncol=2)
dev.off()

# CM6 ==============
  # TABLE ===================
g1cm6 <- ggtexttable(data.mtry.cm6, rows=NULL, theme=ttheme("blank"), cols=c("Input Variables Tested", "Average OOB Error of Calibration", "Average OOB Error of Validation"))
g2cm6 <- ggtexttable(data.ntree.cm6, rows=NULL, theme=ttheme("blank"), cols=c("Number of Trees", "Average Error of Calibration", "Average Error of Validation"))


  # GRAPHS ==================
plot.seed.cm6 <- ggplot(data.seed.cm6, aes(x=seed, y=err, color=Test.Set))+
  geom_point()
# geom_point(data=data.seed, aes(x=seed, y=meanrsqv, color="red"))
plot.seed.cm6

png(filename = "plot_seed_cm6.png", height=500, width = 500)
# windows()
plot.seed.cm6
dev.off()

g.cm6 <- grid.arrange(g1cm6, g2cm6, nrow=2)
png(filename = "grid_sens_cm6.png", height=500, width = 1000)
# windows()
grid.arrange(plot.seed.cm6, g.cm6, ncol=2)
dev.off()


# BOXPLOT ==========
  # data manipulation =====
data.mtry <- data.mtry %>%
  rename(
    meanc = meanrsqc,
    meanv = meanrsqv
  )

data.mtry.cm3 <- data.mtry.cm3 %>%
  rename(
    meanc = meanerrc,
    meanv = meanerrv
  )
data.mtry.cm6 <- data.mtry.cm6 %>%
  rename(
    meanc = meanerrc,
    meanv = meanerrv
  )

data.ntree <- data.ntree %>%
  rename(
    meanc = meanrsqc,
    meanv = meanrsqv
  )

data.ntree.cm3 <- data.ntree.cm3 %>%
  rename(
    meanc = meanerrc,
    meanv = meanerrv
  )
data.ntree.cm6 <- data.ntree.cm6 %>%
  rename(
    meanc = meanerrc,
    meanv = meanerrv
  )

data.seed$Test.Set[data.seed$Test.Set == "meanrsqc"] <- "meanc"
data.seed$Test.Set[data.seed$Test.Set == "meanrsqv"] <- "meanv"
data.seed <- data.seed %>%
  rename(
    Stat = RSQ
  )

data.seed.cm3$Test.Set[data.seed.cm3$Test.Set == "meanerrc"] <- "meanc"
data.seed.cm3$Test.Set[data.seed.cm3$Test.Set == "meanerrv"] <- "meanv"
data.seed.cm3 <- data.seed.cm3 %>%
  rename(
    Stat = err
  )

data.seed.cm6$Test.Set[data.seed.cm6$Test.Set == "meanerrc"] <- "meanc"
data.seed.cm6$Test.Set[data.seed.cm6$Test.Set == "meanerrv"] <- "meanv"
data.seed.cm6 <- data.seed.cm6 %>%
  rename(
    Stat = err
  )

data.mtry.all <- rbind(data.mtry, data.mtry.cm3, data.mtry.cm6)
data.ntree.all <- rbind(data.ntree, data.ntree.cm3, data.ntree.cm6)
data.seed.all <- rbind(data.seed, data.seed.cm3, data.seed.cm6)

data.seed.all$Test.Set[data.seed.all$Test.Set == "meanc"] <- "Calibration"
data.seed.all$Test.Set[data.seed.all$Test.Set == "meanv"] <- "Validation"

data.mtry.all$model <- c(rep("Regression", 6), rep("Categorical-3", 6), rep("Categorical-6", 6))
data.ntree.all$model <- c(rep("Regression", 9), rep("Categorical-3", 9), rep("Categorical-6", 9))
data.seed.all$model <- c(rep("Regression", 200), rep("Categorical-3", 200), rep("Categorical-6", 200))
data.seed.all$model2 <- ifelse(data.seed.all$model == "Regression", c("Regression"), c("Categorical"))

  # boxplot =====
bx.plot <- ggplot(data = data.seed.all, aes(x=model, y=Stat, color=Test.Set))+
  geom_boxplot()+
  # scale_y_continuous(sec.axis = sec_axis(~., name="R^2"))+
  theme_bw(base_size=7)+
  theme(legend.position = c(0.2, 0.8))+
  facet_grid(.~model2, scales="free", space = "free")+
  labs(
    x = "Model",
    y = "(A) OOB Error, (B) R^2 ",
    color = "Test Set"
  )+
  theme(text = element_text(size = 8))

png(filename = "bx.png", height=90, width=90, units="mm", res=120)
# windows()
bx.plot
dev.off()

  # boxplot for POSTER =====
bx.p.plot <- ggplot(data = data.seed.all, aes(x=model, y=Stat, color=Test.Set))+
  geom_boxplot()+
  # scale_y_continuous(sec.axis = sec_axis(~., name="R^2"))+
  theme(legend.position = c(0.2, 0.85), text = element_text(size = 30))+
  facet_grid(.~model2, scales="free", space = "free")+
  labs(
    x = "Model",
    y = "OOB Error (A), R^2 (B)",
    color = "Test Set"
  )


png(filename = "bx_poster.png", height=600, width=600)
# windows()
bx.p.plot
dev.off()

  # full table =====
data.mtry.all <- data.mtry.all %>%
  gather(key=stat, value = "set", 2:3)
data.mtry.all <- data.mtry.all %>%
  spread(key = c("model"), value = "set")

data.ntree.all <- data.ntree.all %>%
  gather(key=stat, value = "set", 2:3) 
data.ntree.all <- data.ntree.all %>%
  spread(key = c("model"), value = "set")

# g1 <- ggtexttable(data.mtry.all, rows=NULL, theme=ttheme("blank"), cols=c("Input Variables Tested", "Average RSQ of Calibration", "Average RSQ of Validation", "Model"))
# g2 <- ggtexttable(data.ntree.all, rows=NULL, theme=ttheme("blank"), cols=c("Number of Trees", "Average RSQ of Calibration", "Average RSQ of Validation"))
# 
# windows()
# g1

# CLEAN ============
rm(plot.seed, plot.seed.cm3, plot.seed.cm6)
rm(g, g.cm3, g.cm6)
rm(g1cm3, g1cm6, g2cm3, g2cm6)
rm(data.mtry, data.mtry.cm3, data.mtry.cm6)
rm(data.ntree, data.ntree.cm3, data.ntree.cm6)
rm(data.seed, data.seed.cm3, data.seed.cm6)
rm(data.sensitivity, data.sensitivity.cm3, data.sensitivity.cm6)
