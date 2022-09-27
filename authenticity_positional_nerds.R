# install.packages("readODS")
library(readODS)
library(tidyverse)

df <- readODS::read_ods("authenticity_positional_nerds.ods")
df <- df %>% 
  mutate(`Mastery level` = fct_relevel(
      `Mastery level`, "unicorn", "high", "low", "does not apply"),
      `Nerd level` = fct_relevel(`Nerd level`, "high", "low", "does not apply"))

labels <- c("low", "medium", "high", "very high")
title = "Data scientists claim authenticity mainly as technical experts"
subtitle = "Nerdiness does not mean legitimisation for real participation"
caption = "Source: own elabortation"

ggplot(df, aes(y = `Business expertise`,
               x = `DS technology expertise`)) + 
  geom_label(aes(label = `Authenticity`), nudge_y = .35) +
  geom_point(aes(fill = `Nerd level`, shape = `Mastery level`), size = 6) +
  scale_x_discrete(limits = labels, labels = labels) +
  scale_y_discrete(limits = labels, labels = labels) +
  scale_shape_manual(values = c(22, 24, 23, 25)) +
  coord_fixed(ratio = 1/1) +
  scale_fill_grey() +
  # theme(legend.position = "bottom", legend.direction = "horizontal",
  #       legend.box = "vertical") +
  labs(title = title, subtitle = subtitle, caption = caption) +
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  theme_light()

# TODO: change shape for nerd level - no simple points 

# make_png <- function(my_plot, height) {
#   png(paste(deparse(substitute(my_plot)), "png", sep = "."), 
#       width = 160, height = height, 
#       units = "mm", res = 300)
#   plot(my_plot)
#   dev.off()
# }
# 
# make_png(autentycznosc, 120)
