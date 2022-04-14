#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


mergeseqhead <- function(seqfile,headfile){
  seq <- readLines(seqfile)
  heads <- readLines(headfile)
  fasta <- as.vector(t(cbind(heads,seq)))
  return(fasta)
}

out.fasta <- mergeseqhead(args[1],args[2])
write(out.fasta,file = args[3])

# Rscript --vanilla mergeseqheads.R seq.txt head.txt out.fasta
# Rscript --vanilla mergeseqheads.R v4n_seq.txt v4n_head.txt v4n.fasta