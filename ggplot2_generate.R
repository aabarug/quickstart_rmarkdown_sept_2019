## Changing to xaringan theme stopped the ggplot2 figures from rendering nicely and I'm not sure why

library(tidyverse)
df <- readr::read_csv("data/domestic_airline_performance.csv", quote = "")

df2 <- df %>%
  filter(Airline != "All Airlines", Route == "Adelaide-Brisbane", Year == 2008) %>% 
  mutate(Month = lubridate::month(x = Month_Num, label = T))

readr::write_csv(df2, "~/ShinyApps/talks/simple_app/data/df2_airline_subset.csv")

# df <- read_csv("data/df2_airline_subset.csv") %>% 
#   filter(Airline == input$select_airline)

gp <- ggplot(df2, aes(x = Month, y = Arrivals_On_Time, group = Airline, color = Airline))
gp
ggsave("images/ggplot_base.png")
## Autosaved as 8.14 x 4.69
gp <- gp + geom_line()
gp
ggsave("images/ggplot_layer1.png")

gp <- gp + geom_point(aes(y = Departures_Delayed, shape = Airline))
gp
ggsave("images/ggplot_layer2.png")

gp <- gp + geom_point(aes(y = Sectors_Flown), data = filter(df2, Airline == "Qantas", Route == "Adelaide-Brisbane", Year == 2008), color = "black")
gp
ggsave("images/ggplot_layer3.png")

gp <- gp + theme_bw() + ylab("Number of arrivals on time") + xlab("") +
  ggtitle("Arrivals on time on Adelaide-Brisbane route in the year 2008 per airline")
gp
ggsave("images/ggplot_final.png")
