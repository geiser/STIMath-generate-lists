library(mirt)
library(readr)

dat <- read_csv("dat.csv")

md <- mirt(dat, itemtype = '3PL')
irt.params <- as.data.frame(coef(md, simplify = T)$items) # parameters
 

write_csv(data.frame("problem_id"=row.names(irt.params), irt.params), "irt-params.csv")
write_csv(data.frame("user_id"=paste0('s',1:nrow(dat)), F1= c(fscores(md))), "tetha.csv")
