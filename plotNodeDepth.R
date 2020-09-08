plot_min_depth_distribution2 <- function(min_depth_frame, k = 10, min_no_of_trees = 0,
                                        mean_sample = "top_trees", mean_scale = FALSE, mean_round = 2,
                                        main = "Distribution of minimal depth and its mean"){
  minimal_depth <- NULL; mean_minimal_depth_label <- NULL; mean_minimal_depth <- NULL
  if(any(c("randomForest", "ranger") %in% class(min_depth_frame))){
    min_depth_frame <- min_depth_distribution(min_depth_frame)
  }
  min_depth_count_list <- min_depth_count(min_depth_frame)
  min_depth_means <- get_min_depth_means(min_depth_frame, min_depth_count_list, mean_sample)
  frame_with_means <- merge(min_depth_count_list[[1]], min_depth_means)
  frame_with_means[is.na(frame_with_means$minimal_depth), "count"] <-
    frame_with_means[is.na(frame_with_means$minimal_depth), "count"] -
    min(frame_with_means[is.na(frame_with_means$minimal_depth), "count"])
  if(mean_scale == TRUE){
    frame_with_means$mean_minimal_depth <-
      (frame_with_means$mean_minimal_depth - min(frame_with_means$mean_minimal_depth))/
      (max(frame_with_means$mean_minimal_depth) - min(frame_with_means$mean_minimal_depth))
  }
  frame_with_means$mean_minimal_depth_label <-
    (frame_with_means$mean_minimal_depth - min(frame_with_means$mean_minimal_depth))/
    (max(frame_with_means$mean_minimal_depth) - min(frame_with_means$mean_minimal_depth)) *
    max(min_depth_count_list[[2]]$no_of_occurrences)
  variables <- min_depth_count_list[[2]][min_depth_count_list[[2]]$no_of_occurrences >= min_no_of_trees, "variable"]
  frame_with_means <- frame_with_means[frame_with_means$variable %in% variables, ]
  frame_with_means <-
    within(frame_with_means, variable <-
             factor(variable, levels = unique(frame_with_means[order(frame_with_means$mean_minimal_depth), "variable"])))
  data <- frame_with_means[frame_with_means$variable %in% levels(frame_with_means$variable)[
    1:min(k, length(unique(frame_with_means$variable)))], ]
  data$variable <- droplevels(data$variable)
  data_for_labels <- unique(data[, c("variable", "mean_minimal_depth", "mean_minimal_depth_label")])
  data_for_labels$mean_minimal_depth <- round(data_for_labels$mean_minimal_depth, digits = mean_round)
  plot <- ggplot(data, aes(x = variable, y = count)) +
    geom_col(position = position_stack(reverse = TRUE), aes(fill = as.factor(minimal_depth))) + coord_flip() +
    scale_x_discrete(limits = rev(levels(data$variable))) +
    # geom_errorbar(aes(ymin = mean_minimal_depth_label, ymax = mean_minimal_depth_label), size = 1.5) +
    xlab("") +ylab("Number of trees") + guides(fill = guide_legend(title = "Minimal depth", nrow=1, title.position="top")) +
    theme_bw() + 
    # geom_label(data = data_for_labels,
                            # aes(y = mean_minimal_depth_label, label = mean_minimal_depth), size=3, label.size = 0.25)+
    theme(text = element_text(size=7)) +
    theme(legend.position = "top")+
    guides(col = guide_legend(ncol = 8))
  if(!is.null(main)){
    plot <- plot + ggtitle(main)
  }
  return(plot)
}

