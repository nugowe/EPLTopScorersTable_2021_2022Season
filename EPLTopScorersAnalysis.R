library(understatr)

LiverpoolStats <- get_team_players_stats(team_name = "Liverpool", year = 2022)
MohamedSalahStats <- LiverpoolStats %>% slice(1) %>% select(c(1:10))
TottenhamStats <- get_team_players_stats(team_name = "Tottenham", year = 2022)
SonStats <- TottenhamStats %>% slice(1) %>% select(c(1:10))
TopScorersAnalysis <- rbind(SonStats, MohamedSalahStats)
TopScorersAnalysis <- TopScorersAnalysis %>% select(c(2:10))