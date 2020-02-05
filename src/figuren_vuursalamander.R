plot <- overzicht_bezoeken_tellers_long %>%
  filter(meetnet == "Vuursalamander") %>%
  filter(monitoringsinspanning != "aantal tellers") %>%
  ggplot(aes(x = jaar, y = aantal, group = monitoringsinspanning, color = monitoringsinspanning)) +
  geom_point() +
  geom_line() +
  labs(x = "Jaar", y = "Monitoringsinspanning", color = "") +
  ylim(0, NA) +
  theme(legend.position = c(0.72,0.13),
        legend.direction = "vertical",
        legend.title = element_blank())

ggsave("vuursalamander_monitoringsinspanning.png", width = 4, height = 3, dpi = 600)




aantallen_soort_stadium <- aantallen_bezoek_levensvorm %>%
   filter(primaire_soort) %>%
   filter(meetnet == soort)

max_soort_stadium <- max(aantallen_soort_stadium$aantal) * 1.2

plot2  <- aantallen_soort_stadium %>%
  ggplot(aes(x= jaar, y = aantal)) +
  #geom_point(alpha = 0.6, colour = inbo.grijs) +
  stat_summary(fun.data = "mean_cl_boot", colour = INBOgreen, size = 1, alpha = 1) +
  labs(y = "Gemiddeld aantal getelde vuursalamanders", x = "Jaar") +

  ylim(0, NA)

ggsave("vuursalamander_aantallen.png", width = 5, height = 4)


plot3 <- overzicht_aantallen_levensvorm_primair %>%
  filter(meetnet == "Vuursalamander") %>%
  ggplot(aes(x = jaar, y = totaal)) +
  geom_point(colour = inbo.groen) +
  geom_line(colour = inbo.groen) +
  labs(x = "Jaar", y = "Totaal aantal getelde vuursalamanders") +
  ylim(3000, 6000)

library(gridExtra)

p1 <- grid.arrange(plot, plot2, ncol = 2)
p2 <- grid.arrange(plot, plot3, ncol = 2)

ggsave("vuursalamander_comb.png", plot = p1, width = 7.5, height = 4)
ggsave("vuursalamander_comb2.png", plot = p2, width = 7.5, height = 4)
