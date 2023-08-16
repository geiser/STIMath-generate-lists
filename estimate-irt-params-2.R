library(mirt)
library(readr)
library(readxl)

for (skill in c("EF01MA06","EF01MA08","EF02MA05","EF02MA06")) {

  dat <- read_xlsx("Classificacao_dos_itens.xlsx", sheet = skill)

  md <- mirt(dat, itemtype = '3PL')
  irt.params <- as.data.frame(coef(md, simplify = T)$items) # parameters
 

  write_csv(data.frame("problem_id"=row.names(irt.params), irt.params), paste0(skill,"-irt-params.csv"))
  write_csv(data.frame("user_id"=paste0('s',1:nrow(dat)), F1= c(fscores(md))), paste0(skill,"-tetha.csv"))
}
