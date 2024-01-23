library(ggthemes)
library(ggimage)
library(dplyr)

data <- read.csv("pmlist.csv")
view(data)
df<- data %>% filter(Elections >= 2008) %>% 
  select(Name, Time.days.)

View(df)
df<- df %>%
  rename(tenure = Time.days.)
### data edit ##########
df[6,2] = 490


df$Name <- factor(df$Name,                                    # Factor levels in decreasing order
                  levels = df$Name[order(df$tenure, decreasing = TRUE)])

View(df)
df$image_file<-paste0('/cloud/project/', df$Name, '.png')

ggplot(df,aes(tenure, Name , width = 0.782))+
  geom_col(fill = '#003366')+
  labs(title = 'Tenure of Prime Ministers in Pakistan, Since 2008',
       caption = "Graphic@Fazila Sadia")+
  geom_text(aes(label=paste(tenure, 'DAYS')), hjust = 1.2, color= 'white', 
            size= 6.8, fontface  = 'bold.italic')+
  geom_image(x =-65 , aes(image = image_file, ), size = 0.25)+
  theme_void(base_size = 22)+
  theme(
    plot.background = element_rect(fill = "white"),
    plot.title = element_text(family = "Palatino", face = 'bold', hjust= 0.09, size = 32),
    plot.caption = element_text(family='times',
                                face="plain",
                                size=8,
                                ),
    plot.margin = unit(c(0.25, 0.15, 0.15, 0.28), 
                       "inches")
  )+ 
  expand_limits(x = -30, y = 1) 

ggsave("PM.png",
       width = 12, height = 5) 

  
