aggregate.3 <- function(data,list,FUN){
  if(nrow(data)==length(list)){
    output <- aggregate(data,list(list),FUN)
    rownames(output) <- output$Group.1
    output <- t(output[,-1])
  } else if(ncol(data)==length(list)){
    output <- aggregate(t(data),list(list),FUN)
    rownames(output) <- output$Group.1
    output <- t(output[,-1])
  }
  return(output)
}

aggregate.2 <- function(data,list,FUN){
  if(nrow(data)==length(list)){
    output <- aggregate(data,list(list),FUN)
    output <- t(output)
  } else if(ncol(data)==length(list)){
    output <- aggregate(t(data),list(list),FUN)
    output <- t(output)
  }
  return(output)
}


Fmeasure <- function(data,theory){
  retrieved <- sum(data)
  precision <- sum(data & theory) / retrieved
  recall <- sum(data & theory) / sum(theory)
  Fmeasure <- 2 * precision * recall / (precision + recall)
  return(Fmeasure)
}
