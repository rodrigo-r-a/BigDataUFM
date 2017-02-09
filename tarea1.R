df <- read.csv("ufm-mapreduce-tarea.csv")
library(dplyr)
View(head(df))
#map
z <- 0
chunksF <- function(x){
  for(i in 1:length(x[,1])){
    z[i] <- table(is.na(x[i,]))[1]
  }
  z <- as.list(z)
  usr <- as.list(x[,1])
  z <- rbind(usr,z)
  z <- t(z)
  z
}
chunks <- chunksF(df)
View(head(chunks))

#reduce
chunks2 <- function(chunks){
  n1 <- 1
  n2 <- 1
  small <- data.frame()
  rest <- data.frame()
  for(i in 1:length(chunks)){
    if(chunks[i,2] < 10){
      small[n1,] <- chunks[i,]
      n1 <- n1+1
    }
    else{
      rest[n2, ] <- chunks[i,]
      n2 <- n2+1
    }
  }
  rest
}

#analyse
df2 <- chunks2(chunks)
recom <- function(x){
  sugestion <- data.frame()
  for(i in 1:length(x)){
    if(x[2:94,i] != usr && max(df[2:94, i] == x[2:94,i])){
      sugestion[i] <- usr
    }
  }
  sugestion
}



