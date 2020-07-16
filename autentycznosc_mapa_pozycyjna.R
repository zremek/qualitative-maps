# install.packages("readODS")
library(readODS)
library(tidyverse)

df <- readODS::read_ods("autentycznosc_mapa_pozycyjna.ods")
df <- df %>% replace_na(
  replace = list(`Poziom maestrii?` = "nie dotyczy",
                 `Nerd?` = "nie dotyczy")) %>% 
  mutate(`Poziom maestrii?` = fct_relevel(
      `Poziom maestrii?`, "jednorożec", "raczej możliwy", "raczej nie możliwy", "nie dotyczy"),
      `Nerd?` = fct_rev(`Nerd?`))

limits <- 1:4
labels <- c("niska", "średnia", "wysoka", "bardzo wysoka")
title = 'Uczestnicy badanego świata zaświadczają o autentyczności głównie poprzez bycie "osobą techniczną"'

ggplot(df, aes(x = `Znajomość biznesu`,
               y = `Znajomość technologii świata DS`)) + 
  geom_text(aes(label = `Autentyczność uczestnictwa`,
                 colour = `Poziom maestrii?`), vjust = -1.2) +
  geom_point(aes(shape = `Nerd?`, colour = `Poziom maestrii?`), size = 4) +
  scale_x_discrete(limits = limits, labels = labels) +
  scale_y_discrete(limits = limits, labels = labels) +
  coord_fixed(ratio = 1/1) +
  scale_colour_brewer(palette = "Spectral") +
  theme_minimal(base_family = "serif", base_size = 10) +
  labs(title = title) +
  coord_flip()

# dodać znajomość niska, średnia, wysoka, bardzo wysoka