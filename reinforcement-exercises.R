library(readr)

irt.params <- read_csv("irt-params.csv")

theta <- c(read_csv("tetha.csv")$F1) # habilidades estimadas mediante 3PL da TRI

l.theta <- sort(theta, index.return=T) # ordenar as habilididades estimadas

n.list = 3

# procurar as n-partições com menor soma dos desvios quadrados de médias

df.combn <- combn(1:length(theta), n.list-1)
df.combn <- rbind(df.combn, rep(length(theta), ncol(df.combn)))

min_j <- 0 # indices da partição com menor soma de desvios
min_sum_sqr_dev <- Inf
for (j in 1:ncol(df.combn)) {
  idx = 1
  sum_sqr_dev = 0
  for (i in 1:n.list) {
    x <- l.theta$x[idx:df.combn[i,j]]
    sum_sqr_dev <- sum_sqr_dev + sum((x - mean(x))^2)
    idx <- df.combn[i,j] + 1  
  }
  
  if (!is.na(sum_sqr_dev) & (sum_sqr_dev < min_sum_sqr_dev)) {
    min_j <- j 
    min_sum_sqr_dev <- sum_sqr_dev
  }  
} 

idx = 1
m.abilities <- c()
for (i in 1:n.list) {
  m <- mean(l.theta$x[idx:df.combn[i,min_j]])
  m.abilities <- c(m.abilities, m)
  idx <- df.combn[i,min_j] + 1  
}

(theta <- m.abilities) # media das habilidades das partições

# theta é a lista de habilidades dos estudantes
# irt.params é a tabela com a lista de parâmetros estimados pelo MML

for (s in 1:length(theta)) {
  l.iff <- c()
  l.seq <- c()
  
  for (i in 1:nrow(irt.params)) {
    a <- irt.params$a1[i]
    b <- irt.params$d[i]
    c <- irt.params$g[i]
    
    p <- c+((1-c)/(1+exp(-a*(theta[s]-b))))
    if (p < 0.85) { # itens com mais de 85% de acertados não são parte da lista 
      iff <- (a^2)*((((p-c)^2)*(1-p))/(((1-c)^2)*p))
      l.iff <- c(l.iff, iff)
      l.seq <- c(l.seq, paste0('Q',i))
    }
  }
  
  if (length(l.iff) > 0) {
    l.iff <- sort(l.iff, index.return = T)
    print(l.seq[l.iff$ix])
  } else {
    print("empty list")
  }
}

