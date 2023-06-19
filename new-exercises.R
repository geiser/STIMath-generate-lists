library(readr)
source('bkt.R')

irt.params <- read_csv("irt-params.csv")
log <- read_csv("log.csv")

k = 'EF02MA06A'
user_ids = c('s1','s2','s3','s4','s5','s6','s7','s8','s9','s10')
question_ids = c('Q1','Q2','Q3','Q4','Q5','Q6','Q7','Q8','Q9')

p.learn <- sapply(user_ids, FUN = function(u) {
  # estimar as probabilidade das habilidades aprendidas mediante BKT
  bkt.learn(log, u, k, 1/16, irt.params = irt.params)
}) 
l.learn <- sort(p.learn, index.return=T) # ordenar as probabilidades

n.list <- 3

# procurar as n-partições com menor soma dos desvios quadrados de médias

df.combn <- combn(1:length(p.learn), n.list-1)
df.combn <- rbind(df.combn, rep(length(p.learn), ncol(df.combn)))

min_j <- 0 # indices da partição com menor soma de desvios
min_sum_sqr_dev <- Inf
for (j in 1:ncol(df.combn)) {
  idx = 1
  sum_sqr_dev = 0
  for (i in 1:n.list) {
    x <- l.learn$x[idx:df.combn[i,j]]
    sum_sqr_dev <- sum_sqr_dev + sum((x - mean(x))^2)
    idx <- df.combn[i,j] + 1  
  }
  
  if (!is.na(sum_sqr_dev) & (sum_sqr_dev < min_sum_sqr_dev)) {
    min_j <- j 
    min_sum_sqr_dev <- sum_sqr_dev
  }  
} 

idx = 1
m.learns <- c()
for (i in 1:n.list) {
  print(paste0('grupo ',i,': ')); print(l.learn$x[idx:df.combn[i,min_j]]) # grupo de estudantes
  m <- mean(l.learn$x[idx:df.combn[i,min_j]])
  m.learns <- c(m.learns, m)
  idx <- df.combn[i,min_j] + 1  
}

(p.learn <- m.learns) # media das probabilidades de aprender "k"


# p.learn é a lista de probabilidades de aprender as habilidades dos estudantes
# irt.params é a tabela com a lista de parâmetros estimados pelo MML

for (s in 1:length(p.learn)) {
  l.iff <- c()
  l.seq <- c()
  
  for (i in 1:length(question_ids)) {
    a <- irt.params$a1[which(irt.params$problem_id == question_ids[i])]
    b <- irt.params$d[which(irt.params$problem_id == question_ids[i])]
    c <- irt.params$g[which(irt.params$problem_id == question_ids[i])]
    
    p <- bkt.predict(p.learn[s], p.guess = c)
    if (p < 0.85) { # itens com mais de 85% de acertados não são parte da lista 
      iff <- (a^2)*((((p-c)^2)*(1-p))/(((1-c)^2)*p))
      l.iff <- c(l.iff, iff)
      l.seq <- c(l.seq, question_ids[i])
    }
  }
  
  if (length(l.iff) > 0) {
    l.iff <- sort(l.iff, index.return = T)
    print(l.seq[l.iff$ix])
  } else {
    print("empty list")
  }
  
}

