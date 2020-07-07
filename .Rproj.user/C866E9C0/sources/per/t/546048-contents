# BRADY NAHKALA
# LAST REVISED: 7 JUL 2020

# PURPOSE AND NOTES: =============================================== 
# separate the manual portion of the rndFor_Full script


# RF MODELING (input reduction) ============================================
# initial params
n = 500
m = 6
mxnd = 15

set.seed(22)
# subsample the training sets for each method
rows.train.df <- sample(nrow(rFdata.m.df), 0.7*nrow(rFdata.m.df), replace=FALSE) # list of row vals only
train.m.df <- rFdata.m.df[rows.train.df, ]
valid.m.df <- rFdata.m.df[-rows.train.df, ]

i <- 1 
r <- 0
ms <- 0
while (i < 101) {
  mod.m <- randomForest(rankm ~
                          Drainage +
                          max.flow.path+
                          max.h2oshed.relief+
                          # capa.ratio #+
                          # lulc.pothole#+
                          max.depth #+
                        # lulc.field#+
                        +Tillage
                        , 
                        data = train.m.df, ntree=n, mtry=m, maxnodes=mxnd, 
                        replace=TRUE, importance=TRUE, proximity=TRUE)
  # mod.m
  r <- mod.m$rsq[length(mod.m$rsq)] + r
  ms <- mod.m$mse[length(mod.m$mse)] + ms
  i <- i + 1
}

print(r)
print(ms)