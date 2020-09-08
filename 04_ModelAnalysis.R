# BRADY NAHKALA
# LAST REVISED: 7 JUL 2020

# PURPOSE AND NOTES: =============================================== 
# separate parts of the analysis of the final rF model

# ANALYSIS =========================================================

importance(mod.m)
varImpPlot(mod.m)

getTree(mod.m, k=500, labelVar = TRUE)
getTree(mod.m, k=499)

# RANDOM FOREST EXPLAINER ==========================================
# from package help vignette

min_depth_frame <- min_depth_distribution(mod.m)
save(min_depth_frame, file="min_depth_frame.rda")
load("min_depth_frame.rda")
head(min_depth_frame, n=10)
plot_min_depth_distribution(min_depth_frame)

# png(filename = "forexpl_nodedepth.png", width=90, height=90, units = "mm")
windows()
plot_min_depth_distribution(min_depth_frame)
dev.off()

importance_frame <- measure_importance(mod.m)
save(importance_frame, file="importance_frame.rda")
load("importance_frame.rda")
importance_frame

plot_multi_way_importance(importance_frame, size_measure = "no_of_nodes")
plot_importance_ggpairs(importance_frame)
plot_importance_rankings(importance_frame)
plot_predict_interaction(mod.m, train.df, "capa.ratio", "max.flow.path")

g1rFE <- plot_multi_way_importance(importance_frame, size_measure = "no_of_nodes")
g2rFE <- plot_multi_way_importance(importance_frame, x_measure="mse_increase", y_measure="node_purity_increase")

png(filename = "forexpl_mwimp.png", width=1200, height=600)
# windows()
grid.arrange(g1rFE, g2rFE, ncol=2)
dev.off()

# output html summary of forest
html.mod <- explain_forest(mod.m, data=train.df)
html.mod

# TREES AND REPRESENTATIVE TREES ===================================


reptr <- ReprTree(mod.m, train.df)
D <- as.data.frame(reptr$D)
reptr_id <- as.numeric(rownames(D)[D$`reptr$D` == min(D$`reptr$D`)])
top10 <- sort(D$`reptr$D`)[c(1:10)]
toptrees <- as.numeric(rownames(D)[D$`reptr$D` %in% top10])

pred <- predict2.randomForest(mod.m, train.df, predict.all = TRUE)
pred2 <- predict2.randomForest(mod.m, valid.df, predict.all = TRUE)
reprtree.votes <- pred$individual[ , reptr_id]
reprtree.votes2 <- pred2$individual[ , reptr_id]
rsq(train.df$rankm, reprtree.votes)
rsq(valid.df$rankm, reprtree.votes2)
plot(valid.df$rankm, reprtree.votes2)

windows()
plot.getTree(mod.m, k=reptr_id, depth=0)

png(filename = "tree1.png", height=800, width = 1200)
plot.getTree(mod.m, k=1)
dev.off()

png(filename = "treerepr.png", height=800, width = 1200)
# windows()
plot.getTree(mod.m, k=reptr_id)
# plot.reprtree(reptr)
dev.off()

png(filename = "treerepr_poster.png", height=800, width = 1200)
# windows()
plot.getTree.poster(mod.m, k=reptr_id)
# plot.reprtree(reptr)
dev.off()


varImpPlot(mod.m, type=1, 
           main=NULL,
           xlab="Percent Increase in MSE"#,
           # ylab=NULL
)
imp <- importance(mod.m)
imp <- as.data.frame(imp)
imp$vars <- rownames(imp)
imp$PctIncMSE <- as.numeric(imp$PctIncMSE)
names(imp) <- c("PctIncMSE", "IncNodePurity", "vars")

png(filename = "Fig5_NodeDepth.png", width=90, height=90, units="mm", res = 120)
# windows()
plot_min_depth_distribution2(min_depth_frame, main="")
dev.off()

png("Fig6_MSEIncrease.png", heigh=90, width=90, units = "mm", res=120)
ggplot(imp, aes(PctIncMSE, vars, colour=PctIncMSE)) +
  geom_point(aes(size=8, alpha=0.2)) +
  scale_colour_continuous()+
  labs(
    x="Percent Increase in MSE",
    y=NULL
  ) + 
  theme_minimal()+
  theme(legend.position = "none") 
dev.off()

# ====
windows()
pairs(data.df[,c(3:10)])
# 
# summary(lm(data = data.df, rankm ~ Drainage + Tillage))