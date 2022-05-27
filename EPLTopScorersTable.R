#!/usr/bin/R

# Loading the necessary R packages

#Rpackages=c("polite","rvest","kableExtra","gt")

#for (i in Rpackages){install.packages(i)} 



library(polite)
library(tidyverse)
library(rvest)
library(kableExtra)
library(gt)
library(ggrepel)
library(magick)
library(glue)
library(extrafont)
library(ggtextures)
library(cowplot)
library(ggthemes)
library(bbplot)

#Liverpoollogo <- "https://upload.wikimedia.org/wikipedia/en/0/0c/Liverpool_FC.svg"
#TottenhamHotspurlogo <- "https://upload.wikimedia.org/wikipedia/en/b/b4/Tottenham_Hotspur.svg"
#ManchesterUnitedlogo <- "https://upload.wikimedia.org/wikipedia/en/7/7a/Manchester_United_FC_crest.svg"

SonPic <- "https://cdne-totv8-prod.azureedge.net/media/40824/firstteam_heungminson_2021_22.png?anchor=center&mode=crop&quality=100&width=500"
HarryKanePic <- "https://cdne-totv8-prod.azureedge.net/media/40873/firstteam_harrykane_2021_22.png?anchor=center&mode=crop&quality=100&width=500"
ManePic <- "https://d3j2s6hdd6a7rg.cloudfront.net/v2/uploads/media/misc/0002/23/thumb_122594_misc_general_1300.jpeg"
MohamedSalahPic <- "https://d3j2s6hdd6a7rg.cloudfront.net/v2/uploads/media/misc/0002/23/thumb_122598_misc_general_1300.jpeg"
RonaldoPic <- "https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg"
#PremierLeagueLogo <- "https://upload.wikimedia.org/wikipedia/en/f/f2/Premier_League_Logo.svg"


url <- "https://en.wikipedia.org/wiki/2021%E2%80%9322_Premier_League"

session = bow(user_agent = "EPL_Top_Scorers", url)

EPLTOPScorersTable <- scrape(session) %>% html_nodes("table.wikitable:nth-child(65)") %>% html_table()

EPLTOPScorersTable <- as.data.frame(EPLTOPScorersTable)

names(EPLTOPScorersTable)[4] <- 'Goals'


EPLTOPScorersTable <- EPLTOPScorersTable %>% 
  head(5) %>% 
  mutate(image = "https://www.emoji.co.uk/files/microsoft-emojis/activity-windows10/8356-soccer-ball.png")

EPLTOPScorersggplot <- EPLTOPScorersTable %>% 
  ggplot(aes(x = reorder(Player, Goals), y = Goals,
             image = image)) +
  geom_isotype_col(img_width = grid::unit(1, "native"), img_height = NULL,
                   ncol = NA, nrow = 1, hjust = 0, vjust = 0.5) +
  coord_flip() +
  ggthemes::theme_economist_white() +
  labs(title = "TOP SCORERS CHART | ENGLISH PREMIER LEAGUE | 2021/2022 SEASON",
       caption = glue("
                      Sources: 
                      Wikipedia
                        TottenhamFC Official Website
                        LiverpoolFC Official Website
                        @R_by_Ryo
                      ")) + theme(plot.title=element_text(hjust=0.1), axis.title.y=element_text(face="italic"),
                                               plot.subtitle=element_text(hjust=0.1), text = element_text(family = "Lato")) + xlab("")


superimposed_image_y <- axis_canvas(EPLTOPScorersggplot, axis = 'y') + 
  draw_image(SonPic, y = 21.0, scale = 5.0) +  draw_image(MohamedSalahPic, y = 16, scale = 3.0) + draw_image(RonaldoPic, y = 11, scale = 4.0) + draw_image(HarryKanePic, y = 6.0, scale = 4.5) +  draw_image(ManePic, y = 1.0, scale = 3.0)   

ggdraw(insert_yaxis_grob(EPLTOPScorersggplot, superimposed_image_y, position = "left"))

