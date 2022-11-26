

# setup -------------------------------------------------------------------

library(tidyverse)
library(tidycovid19)
library(ozmaps)

# covid -------------------------------------------------------------------

covid <- download_merged_data(silent = TRUE, cached = TRUE)
covid %>%
  filter(country=="Australia") %>%
  write_csv("data/tidycovid-20221116.csv")






# catalogue ---------------------------------------------------------------

set.seed(1)
n1 <- 200
df1 <- tibble(x = runif(n1, 0, 10),
              y =  3 * x + rnorm(n1, 0, 10),
              z = rnorm(n1, 0, 2),
              g1 = sample(letters[1:4], size = n1, replace = TRUE),
              g2 = sample(letters[1:4], size = n1, replace = TRUE)) %>%
  mutate(g1 = fct_reorder(g1, y, sum))
df2 <- diamonds %>%
  sample_n(80)
df3 <- ToothGrowth %>%
  mutate(dosef = factor(dose)) %>%
  group_by(dosef, supp) %>%
  summarise(mlen = factor(mean(len)))
sumdf1 <- df1 %>%
  group_by(g1) %>%
  summarise(y = sum(y))
sumdf2 <- df1 %>%
  group_by(g1, g2) %>%
  summarise(y = sum(y))
# generate 5 from colorspace and discard the tails which are too white
reds <- c("#7F000D", "#A9565A", "#CA9496", "#E2CBCB")
yellows <- c("#6A3F00", "#97742F", "#BAA588", "#D4CCC3")
green <- "#006400"
purples <- c("#312271", "#4F4293", "#6D60BB", "#8B80D1", "#A79FE1", "#C2BCF0",
             "#DAD6FA", "#EDEBFF", "#F9F9F9")

theme_base <- list(theme_void(base_size = 18) +
                     theme(plot.margin = margin(10, 10, 10, 10),
                           plot.title.position = "plot",
                           plot.title = element_text(margin = margin(t = -4, b = 10),
                                                     size = 14, face = "bold")),
                   guides(fill = "none"))

theme_rank <- c(theme_base,
                list(theme(plot.background = element_rect(fill = "#DCBFC9",
                                                          color = NA)),
                     scale_fill_manual(values = reds)))

theme_corr <- c(theme_base,
                list(theme(plot.background = element_rect(fill = "#EDDBB6",
                                                          color = NA))))

theme_dist <- c(theme_base,
                list(theme(plot.background = element_rect(fill = "#D7FBCD",
                                                          color = NA))))

theme_other <- c(theme_base,
                 list(theme(plot.background = element_rect(fill = "#FFE5FF",
                                                           color = NA)),
                      scale_fill_manual(values = purples)))




theme_yaxis <- theme(axis.line.y = element_line(color = "black", size = 1),
                     axis.ticks.y = element_line(color = "black",
                                                 linetype = "solid",
                                                 size = 1,
                                                 lineend = NULL),
                     axis.ticks.length.y = unit(0.3, "lines"))


theme_xaxis <- theme(axis.line.x = element_line(color = "black", size = 1),
                     axis.ticks.x = element_line(color = "black",
                                                 linetype = "solid",
                                                 size = 1,
                                                 lineend = NULL),
                     axis.ticks.length.x = unit(0.3, "lines"))

theme_border <- theme(plot.background = element_rect(color = "black",
                                                     size = 3))

oz_sf <- ozmap_data("states")

w <- h <- 1.8

ggplot(sumdf1, aes(g1, y)) +
  geom_col(fill = reds[1]) +
  theme_rank +
  theme_yaxis +
  theme_border +
  ggtitle("BARPLOT")
ggsave(here::here("slides/images/catalogue/rank-barplot.svg"), width = w, height = h)

ggplot(sumdf1, aes("", y, fill = g1)) +
  geom_col(position = "fill") +
  theme_rank +
  theme_border +
  ggtitle("PIE CHART") +
  coord_polar("y") +
  theme(plot.margin = margin(t=20, b=20, l=17, r=17),
        plot.title = element_text(margin = margin(t = -13, l = -20)))
ggsave(here::here("slides/images/catalogue/rank-piechart.svg"), width = w, height = h)



ggplot(sumdf2, aes(g1, y, fill = g2)) +
  geom_col() +
  theme_rank +
  theme_yaxis +
  theme_border +
  ggtitle("STACKED\nBARPLOT")
ggsave(here::here("slides/images/catalogue/rank-stacked-barplot.svg"), width = w, height = h)


ggplot(sumdf2, aes(g1, y, fill = g2)) +
  geom_col(position = "dodge") +
  theme_rank +
  theme_yaxis +
  theme_border +
  ggtitle("GROUPED\nBARPLOT")
ggsave(here::here("slides/images/catalogue/rank-grouped-barplot.svg"), width = w, height = h)

ggplot(sumdf2, aes(g1, y, fill = g2)) +
  geom_col(position = "fill") +
  theme_rank +
  theme_yaxis +
  theme_border +
  ggtitle("STACKED\nPERCENTAGE\nBARPLOT")
ggsave(here::here("slides/images/catalogue/rank-stacked-barplot.svg"), width = w, height = h)


ggplot(faithful, aes(eruptions)) +
  geom_histogram(fill = green, bins = 10, color = "white") +
  theme_dist +
  theme_xaxis +
  theme_yaxis +
  theme_border +
  ggtitle("HISTOGRAM")
ggsave(here::here("slides/images/catalogue/dist-histogram.svg"), width = w, height = h)


ggplot(faithful, aes(eruptions)) +
  geom_density(fill = green, color = NA) +
  theme_dist +
  theme_xaxis +
  theme_yaxis +
  theme_border +
  ggtitle("DENSITY PLOT")
ggsave(here::here("slides/images/catalogue/dist-densityplot.svg"), width = w, height = h)


ggplot(faithful, aes(eruptions, "")) +
  geom_boxplot(fill = "white", color = green, width = 0.3) +
  theme_dist +
  theme_xaxis +
  theme_border +
  ggtitle("BOXPLOT")
ggsave(here::here("slides/images/catalogue/dist-boxplot.svg"), width = w, height = h)


ggplot(faithful, aes(eruptions, "")) +
  geom_violin(fill = green) +
  theme_dist +
  theme_xaxis +
  theme_border +
  ggtitle("VIOLIN PLOT")
ggsave(here::here("slides/images/catalogue/dist-violin.svg"), width = w, height = h)


ggplot(faithful, aes(eruptions)) +
  geom_dotplot(fill = green) +
  theme_dist +
  theme_xaxis +
  theme_border +
  ggtitle("DOT PLOT")
ggsave(here::here("slides/images/catalogue/dist-dotplot.svg"), width = w, height = h)

ggplot(df2, aes(carat, price)) +
  geom_point(color = yellows[1]) +
  theme_corr +
  theme_yaxis +
  theme_xaxis +
  theme_border +
  ggtitle("SCATTER PLOT")
ggsave(here::here("slides/images/catalogue/corr-scatterplot.svg"), width = w, height = h)


ggplot(economics, aes(date, uempmed)) +
  geom_line(color = yellows[1]) +
  theme_corr +
  theme_yaxis +
  theme_xaxis +
  theme_border +
  ggtitle("LINE PLOT")
ggsave(here::here("slides/images/catalogue/corr-lineplot.svg"), width = w, height = h)


ggplot(df2, aes(carat, price)) +
  geom_hex() +
  theme_corr +
  theme_yaxis +
  theme_xaxis +
  theme_border +
  scale_fill_gradient(high = "white", low = yellows[1]) +
  ggtitle("HEX PLOT")
ggsave(here::here("slides/images/catalogue/corr-hexplot.svg"), width = w, height = h)

ggplot(df2, aes(carat, price)) +
  geom_density_2d(color = yellows[1]) +
  theme_corr +
  theme_yaxis +
  theme_xaxis +
  theme_border +
  ggtitle("2D DENSITY PLOT")
ggsave(here::here("slides/images/catalogue/corr-2d-density-plot.svg"), width = w, height = h)


ggplot(df2, aes(carat, price, size = depth)) +
  geom_point(color = yellows[1], alpha = 0.3) +
  theme_corr +
  theme_yaxis +
  theme_xaxis +
  theme_border +
  ggtitle("BUBBLE CHART") + guides(size = "none")
ggsave(here::here("slides/images/catalogue/corr-bubble.svg"), width = w, height = h)



ggplot(df3, aes(dosef, supp, fill = mlen)) +
  geom_tile(color = "black", size = 1.2) +
  theme_other +
  theme_border +
  ggtitle("HEATMAP")
ggsave(here::here("slides/images/catalogue/other-heatmap.svg"), width = w, height = h)

oz_sf %>%
  mutate(value = factor(rnorm(n()))) %>%
  ggplot(aes(fill = value)) +
  geom_sf() +
  theme_other +
  theme_border +
  ggtitle("CHOROPLETH\nMAP")
ggsave(here::here("slides/images/catalogue/other-choropleth.svg"), width = w, height = h)



# aesthetic ---------------------------------------------------------------

psize <- 3.5
set.seed(1)
df2 <- data.frame(x = runif(15),
                  y = runif(15),
                  val = seq(0, 1, length.out = 15))
df2 %>%
  ggplot(aes(x, y)) +
  geom_point(size = psize) +
  theme_classic() +
  theme_base +
  theme_border +
  theme(axis.title = element_text(size = 18),
        axis.text = element_blank(),
        axis.line = element_line(color = "black"),
        axis.ticks.length = unit(1, "mm"),
        axis.ticks = element_line(color = "black"),
        panel.grid.major = element_line(color = "grey"),
        panel.grid.minor = element_line(color = "grey80",
                                        linetype = "dashed"),
        plot.background = element_rect(color = "black")) +

ggsave(here::here("slides/images/aes-pos.svg"), width = w, height = h)


df2 %>%
  ggplot(aes(x, y)) +
  geom_point(aes(alpha = val), size = psize + 1) +
  theme_classic() +
  theme_void() +
  theme_base +
  theme_border +
  guides(alpha = "none")
ggsave(here::here("slides/images/aes-alpha.svg"), width = w, height = h)


df2 %>%
  ggplot(aes(x, y)) +
  geom_point(aes(color = factor(val)), size = psize - 1.5, shape = 21, stroke = 3, linewidth = 3) +
  theme_classic() +
  theme_void() +
  theme_base +
  theme_border +
  colorspace::scale_color_discrete_qualitative() +
  guides(color = "none") +
ggsave(here::here("slides/images/aes-color.svg"), width = w, height = h)


df2 %>%
  ggplot(aes(x, y)) +
  geom_point(aes(fill = factor(val)), size = psize, shape = 22, stroke = 2, linewidth = 1, color = "black") +
  theme_classic() +
  theme_void() +
  theme_base +
  theme_border +
  colorspace::scale_fill_discrete_qualitative() +
  guides(color = "none") +
  ggsave(here::here("slides/images/aes-fill.svg"), width = w, height = h)


df2 %>%
  ggplot(aes(x, y)) +
  geom_point(aes(size = val)) +
  theme_classic() +
  theme_void() +
  theme_base +
  theme_border +
  colorspace::scale_fill_discrete_qualitative() +
  guides(size = "none")
ggsave(here::here("slides/images/aes-size.svg"), width = w, height = h)



# aes line specs --------------------------------------------------------------


ggplot(data.frame(y = 1:6), aes(0, y)) +
  geom_segment(aes(xend = 5, yend = y, color = factor(y)),
               linewidth = 6) +
  scale_x_continuous(NULL, breaks = NULL) +
  scale_y_reverse(NULL, breaks = NULL) +
  guides(color = "none") +
  theme_base +
  theme_border +
  colorspace::scale_color_discrete_qualitative()
ggsave(here::here("slides/images/aes-line-color.svg"), width = w, height = h * 3)

lty <- c("blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash")
linetypes <- data.frame(
  y = seq_along(lty),
  lty = lty
)
ggplot(linetypes, aes(0, y)) +
  geom_segment(aes(xend = 5, yend = y, linetype = lty)) +
  scale_linetype_identity() +
  geom_text(aes(label = paste0(y - 1, " = ", lty)), hjust = 0, nudge_y = 0.2, size = 5) +
  scale_x_continuous(NULL, breaks = NULL) +
  theme_base +
  theme_border +
  scale_y_reverse(NULL, breaks = NULL)
ggsave(here::here("slides/images/aes-line-type.svg"), width = w, height = h * 3)


ggplot(data.frame(y = 1:6), aes(0, y)) +
  geom_segment(aes(xend = 5, yend = y, linewidth = I(y))) +
  geom_text(aes(label = paste0("linewidth = ", y)), hjust = 0,
            nudge_y = 0.25, size = 5) +
  scale_x_continuous(NULL, breaks = NULL) +
  scale_y_reverse(NULL, breaks = NULL) +
  guides(linewidth = "none") +
  theme_base +
  theme_border
ggsave(here::here("slides/images/aes-line-width.svg"), width = w, height = h * 3)


df <- data.frame(x = 1:3, y = c(4, 1, 8))
ggplot(df, aes(x, y)) +
  geom_path(data = mutate(df, y = y + 20), linewidth = 10) +
  geom_path(data = mutate(df, y = y + 20), linewidth = 1, colour = "red") +
  geom_path(data = mutate(df, y = y + 10), linewidth = 10, lineend = "round") +
  geom_path(data = mutate(df, y = y + 10), linewidth = 1, colour = "red") +
  geom_path(linewidth = 10, lineend = "square") +
  geom_path(linewidth = 1, colour = "red") +
  geom_text(data = data.frame(label = c("butt (default)", "round", "square"), x= 0.5, y = c(29, 19, 9)),
            aes(label = label), size = 5, hjust = 0) +
  xlim(0.5, 3.5) +
  theme_base +
  theme_border

ggsave(here::here("slides/images/aes-line-end.svg"), width = w, height = h * 3)


df <- data.frame(x = 1:3, y = c(4, 1, 8))
ggplot(df, aes(x, y)) +
  geom_path(data = mutate(df, y = y + 20), linewidth = 10) +
  geom_path(data = mutate(df, y = y + 20), linewidth = 1, colour = "red") +
  geom_path(data = mutate(df, y = y + 10), linewidth = 10, linejoin = "mitre") +
  geom_path(data = mutate(df, y = y + 10), linewidth = 1, colour = "red") +
  geom_path(linewidth = 10, linejoin = "bevel") +
  geom_path(linewidth = 1, colour = "red") +
  geom_text(data = data.frame(label = c("round (default)", "mitre", "bevel"), x= 0.5, y = c(29, 19, 9)),
            aes(label = label), size = 5, hjust = 0) +
  xlim(0.5, 3.5) +
  theme_base +
  theme_border

ggsave(here::here("slides/images/aes-line-join.svg"), width = w, height = h * 3)


shape_names <- c(
  "circle", paste("circle", c("open", "filled", "cross", "plus", "small")), "bullet",
  "square", paste("square", c("open", "filled", "cross", "plus", "triangle")),
  "diamond", paste("diamond", c("open", "filled", "plus")),
  "triangle", paste("triangle", c("open", "filled", "square")),
  paste("triangle down", c("open", "filled")),
  "plus", "cross", "asterisk"
)

shapes <- data.frame(
  shape_names = shape_names,
  x = c(1:7, 1:6, 1:3, 5, 1:3, 6, 2:3, 1:3),
  y = -rep(1:6, c(7, 6, 4, 4, 2, 3))
)
ggplot(shapes, aes(x, y)) +
  geom_point(aes(shape = shape_names), fill = "red", size = 5) +
  geom_text(aes(label = shape_names), nudge_y = -0.3, size = 3.5) +
  scale_shape_identity() +
  theme_void() +
  theme_base +
  theme_border
ggsave(here::here("slides/images/aes-shapes.svg"), width = w * 4, height = h * 3)

sizes <- expand.grid(size = (0:3) * 2, stroke = (0:3) * 2)
ggplot(sizes, aes(size, stroke, size = size, stroke = stroke)) +
  geom_abline(slope = -1, intercept = 6, colour = "grey", linewidth = 6) +
  geom_point(shape = 21, fill = "red") +
  scale_size_identity() +
  theme_base +
  theme_border +
  theme(axis.line = element_line(color = "black", size = 2),
        axis.title = element_text(color = "black", margin = margin(5, 5, 5, 5)),
        axis.text = element_text(color = "black", margin = margin(10, 10, 10 , 10)),
        plot.margin = margin(10, 10, 10, 10),
        axis.ticks.length = unit(2, "mm"),
        axis.ticks = element_line(color = "black", linewidth = 1.5)) +
  xlim(-0.5, 6.5) + ylim(-0.5, 6.5) +
ggsave(here::here("slides/images/aes-filled-shapes.svg"), width = w * 3, height = h * 3)

