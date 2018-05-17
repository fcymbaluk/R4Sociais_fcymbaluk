#Tutorial_SQL

install.packages("RMySQL")
library(dplyr)
library(RMySQL)

conexao <- src_mysql(dbname = "dplyr", 
                     host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                     port = 3306, 
                     user = "student",
                     password = "datacamp")



# Deu problema, resolvido perguntando no google:
# Error: Condition message must be a string r
# https://github.com/tidyverse/dplyr/issues/3225
# Error: Condition message must be a string rmysql
# Resultado: Introduction to dbplyr • dbplyr
# Ctl+C dbplyr
# Packages: inStall: dbplyr
# Seleciona dbplyr

src_tbls(conexao)
voos <- tbl(conexao, "dplyr")

head(voos)
str(voos)

voos_atraso <- voos %>% 
  mutate(atraso =  dep_delay + arr_delay) %>%
  group_by(carrier) %>%
  summarise(total_atraso = sum(atraso))

show_query(voos_atraso)


conexao <- src_mysql(dbname = "tweater", 
                     host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                     port = 3306, 
                     user = "student",
                     password = "datacamp")

src_tbls(conexao)

tbl(conexao, sql("SELECT * FROM comments WHERE user_id > 4"))

comments <- tbl(conexao, "comments")

tweats <- tbl(conexao, "tweats")

users <- tbl(conexao, "users")

filter(comments, user_id > 4)

tweats2 <- rename(tweats, tweat_id = id)

tabela_join <- left_join(tweats2, comments, "tweat_id")

head(tabela_join)


show_query(tabela_join)


tweats <- tweats %>% 
  rename(tweat_id = id) %>%              # renomeia variavel
  mutate(post = toupper(post)) %>%       # post em letras maiusculas
  left_join(comments, "tweat_id") %>%    # left join con tabela "comments"
  select(tweat_id, post, message) %>%    # mantem apenas 3 variaveis
  mutate(n_caract = nchar(message)) %>%  # cria var num caractecteres do comentario
  filter(n_caract < 10)                  # filtra por comentarios com menos de 10 caract

head(tweats, 7)

tabela <- as.data.frame(tweats)

View(tabela)

