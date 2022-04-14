#v3v4
#CCTACGGGNGGCWGCAG.*GGATTAGATACCCBDGTAGTC
l <- list(N=c("A","T","C","G"),
          W=c("A","T"),
          B=c("C","G","T"),
          D=c("A","G","T"))
x <- do.call(expand.grid, l)
#x <- apply(x, 1, function(x) paste0(x,collapse = ""))
seq <- paste0("CCTACGGG",x[,1],"GGC",x[,2],"GCAG.*GGATTAGATACCC",x[,3],x[,4],"GTAGTC")

write(seq,"v3v4.pattern")

#v4o
#GTGYCAGCMGCCGCGGTAA.*ATTAGAWACCCNDGTAGTCC
o <- list(Y=c("C","T"),
          M=c("A","C"),
          W=c("A","T"),
          N=c("A","T","C","G"),
          D=c("A","G","T"))
oo <- do.call(expand.grid, o)
ooseq <- paste0("GTG",oo$Y,"CAGC",oo$M,"GCCGCGGTAA.*ATTAGA",oo$W,"ACCC",oo$N,oo$D,"GTAGTCC")
write(ooseq,"v4o.pattern")

#v4n
#CAGCMGCCGCGGTAAT.*AACMGGATTAGAWACCC
n <-list(M=c("A","C"),
         M=c("A","C"),
         W=c("A","T"))
nn <- do.call(expand.grid, n)
nnseq <- paste0("CAGC",nn$M,"GCCGCGGTAAT.*AAC",nn$M,"GGATTAGA",nn$W,"ACCC")
write(nnseq,"v4n.pattern")