bkt.learn <- function(log, u, k, p.trans, p.init = 0, p.slip = 0.05, p.guess=0.25, irt.params = NULL) {
  df.obs <- log[log$user_id == u & log$skill_name == k,]
  if (nrow(df.obs) < 1) return(p.init)
  obs <- df.obs$correct
  
  p.guess <- rep(p.guess, nrow(df.obs))
  if (!is.null(irt.params)) {
    p.guess <- sapply(df.obs$problem_id, FUN = function(problem_id) {
      g = irt.params$g[which(irt.params$problem_id == problem_id)]
      if (g > 0.3) g <- 0.3 # limit of guess parameter
      if (g <= 0) g <- 0.000001  # to avoid NaN when is divided by 0
      return (g)
    })
  }
  
  p.learn = p.init
  for (t in 1:length(obs)) {
    if (obs[[t]] == 1) {
      p.cond <- p.learn*(1-p.slip)/((p.learn*(1-p.slip))+((1-p.learn)*p.guess[[t]]))
    } else if (val == 0) {
      p.cond <- p.learn*p.slip/((p.learn*p.slip)+((1-p.learn)*(1-p.guess[[t]])))
    }
    p.learn <- p.cond + (1-p.cond)*p.trans
  }
  return(p.learn)
}


bkt.predict <- function(p.learn, p.slip = 0.05, p.guess=0.25) {
  return(p.learn*(1-p.slip) + (1-p.learn)*p.guess)
}
