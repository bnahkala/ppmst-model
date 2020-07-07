# BRADY NAHKALA
# LAST REVISED: 7 JUL 2020

# PURPOSE AND NOTES: =============================================== 
# set final model


# RF MODELING (FINAL) ============================================
n = 500
m = 6
mxnd = 15

rFdata.df <- as.data.frame(within(data.df, rm(catm3, catm6)))
rFdata.df <- rFdata.df %>%
  dplyr::rename(LULC.Pothole = lulc.pothole,
                LULC.Field = lulc.field,
                Watershed.Relief = max.h2oshed.relief,
                Maximum.Flow.Path = max.flow.path,
                Max.Depth = max.depth,
                CA.to.PA.Ratio = capa.ratio)
rFdata.df$Watershed.Relief <- round(rFdata.df$Watershed.Relief, 1)
rFdata.df$Maximum.Flow.Path <- round(rFdata.df$Maximum.Flow.Path)

# subsample the training sets for each method
set.seed(22)
rows.train.df <- sample(nrow(rFdata.df), 0.7*nrow(rFdata.df), replace=FALSE) # list of row vals only
train.df <- rFdata.df[rows.train.df, ]
valid.df <- rFdata.df[-rows.train.df, ]

mod.m <- randomForest(rankm ~ Drainage +
                        LULC.Pothole+
                        Maximum.Flow.Path+
                        CA.to.PA.Ratio+
                        Watershed.Relief+
                        Max.Depth+
                        LULC.Field
                      +Tillage
                      ,
                      data = train.df, ntree=n, mtry=m, maxnodes=mxnd, 
                      replace=TRUE, importance=TRUE, proximity=TRUE)
mod.m

