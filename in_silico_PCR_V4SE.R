rm(list=ls())
#truncate ~ to x bp from 5'
#V4OSE=131 bp
#V4NSE=134 bp

truncSE <- function(FASTAin,seqL,FASTAout){
  fasta <- readLines(FASTAin)
  fasta[seq(2,length(fasta),2)] <- substr(fasta[seq(2,length(fasta),2)],1,seqL)
  write(fasta,file = FASTAout)
}

files <- c("v4o.fasta","v4n.fasta")
out <- c("v4ose.fasta","v4nse.fasta")


truncSE(files[1],131,out[1]) # V4O SE
truncSE(files[2],134,out[2]) # V4N SE