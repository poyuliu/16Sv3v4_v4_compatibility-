rm(list=ls())
source("../FN_functionsets.R")
load("InSilico_PCR_02_Taxonomy_Theo.RData")
groups <- c("V3V4","V4O","tV4O")

theo.TAXA.p <- function(levels=c("phylum","class","order","family","genus","species")){
  if(levels=="phylum"){
    DB.taxalv.p <- as.data.frame(prop.table(table(DB.taxa$V2))*100)
    taxalv.p <- sapply(theo.taxa,function(x) prop.table(table(x[,2]))*100)
  } else if(levels=="class"){
    DB.taxalv.p <- as.data.frame(prop.table(table(paste(DB.taxa$V2,DB.taxa$V3,sep = " ")))*100)
    taxalv.p <- sapply(theo.taxa,function(x) prop.table(table(paste(x[,2],x[,3],sep = " ")))*100)
  } else if(levels=="order"){
    DB.taxalv.p <- as.data.frame(prop.table(table(paste(DB.taxa$V2,DB.taxa$V3,DB.taxa$V4,sep = " ")))*100)
    taxalv.p <- sapply(theo.taxa,function(x) prop.table(table(paste(x[,2],x[,3],x[,4],sep = " ")))*100)
  } else if(levels=="family"){
    DB.taxalv.p <- as.data.frame(prop.table(table(paste(DB.taxa$V2,DB.taxa$V3,DB.taxa$V4,DB.taxa$V5,sep = " ")))*100)
    taxalv.p <- sapply(theo.taxa,function(x) prop.table(table(paste(x[,2],x[,3],x[,4],x[,5],sep = " ")))*100)
  } else if(levels=="genus"){
    DB.taxalv.p <- as.data.frame(prop.table(table(paste(DB.taxa$V2,DB.taxa$V3,DB.taxa$V4,DB.taxa$V5,DB.taxa$V6,sep = " ")))*100)
    taxalv.p <- sapply(theo.taxa,function(x) prop.table(table(paste(x[,2],x[,3],x[,4],x[,5],x[,6],sep = " ")))*100)
  } else if(levels=="species"){
    DB.taxalv.p <- as.data.frame(prop.table(table(paste(DB.taxa$V2,DB.taxa$V3,DB.taxa$V4,DB.taxa$V5,DB.taxa$V6,DB.taxa$V7,sep = " ")))*100)
    taxalv.p <- sapply(theo.taxa,function(x) prop.table(table(paste(x[,2],x[,3],x[,4],x[,5],x[,6],x[,7],sep = " ")))*100)
  }
  
  theo.taxalv.p <- merge(DB.taxalv.p,as.data.frame(taxalv.p[[1]]),by = "Var1",all=T)
  names(theo.taxalv.p)[2:3] <- c("DB",groups[1]) # 2022/03/17 modified
  for(i in 2:3) { # 2022/03/17 modified
    theo.taxalv.p <- merge(theo.taxalv.p,as.data.frame(taxalv.p[[i]]),by = "Var1",all=T)
    names(theo.taxalv.p)[i+2] <- groups[i]
  }
  theo.taxalv.p[is.na(theo.taxalv.p)] <- 0
  rownames(theo.taxalv.p) <- theo.taxalv.p$Var1
  theo.taxalv.p <- theo.taxalv.p[,-1]
}

theo.class.p <- theo.TAXA.p("class")
theo.order.p <- theo.TAXA.p("order")
theo.family.p <- theo.TAXA.p("family")
theo.genus.p <- theo.TAXA.p("genus")
theo.species.p <- theo.TAXA.p("species")



###################################
# F-score / F-measure / F1-score
# Fscore <- 2*((Pre*Rec)/(Pre+Rec))
#TP = theo.phyla.p$DB
#TN = 100 - theo.phyla.p$DB
#FP = abs(theo.phyla.p$V3V4 - theo.phyla.p$DB)
#FN = abs((100 - theo.phyla.p$V3V4) - (100 - theo.phyla.p$DB))
#Pre = TP/(TP+FP)
#Rec <- TP/(TP+FN)
#Fscore <- 2*((Pre*Rec)/(Pre+Rec))
#https://www.statology.org/f1-score-in-r/
#https://escholarship.org/uc/item/7mm0453b

DB <- list(theo.phyla.p$DB,theo.class.p$DB,theo.order.p$DB,theo.family.p$DB,theo.genus.p$DB,theo.species.p$DB)
V3V4 <- list(theo.phyla.p$V3V4,theo.class.p$V3V4,theo.order.p$V3V4,theo.family.p$V3V4,theo.genus.p$V3V4,theo.species.p$V3V4)
V4O <- list(theo.phyla.p$V4O,theo.class.p$V4O,theo.order.p$V4O,theo.family.p$V4O,theo.genus.p$V4O,theo.species.p$V4O)
tV4O <- list(theo.phyla.p$tV4O,theo.class.p$tV4O,theo.order.p$tV4O,theo.family.p$tV4O,theo.genus.p$tV4O,theo.species.p$tV4O)

TP <- DB
TN <- lapply(DB, function(x) 100-x)
FP.V3V4 <- list(); for(i in 1:6) FP.V3V4[[i]] <- abs(V3V4[[i]] - TP[[i]])
FP.V4O <- list(); for(i in 1:6) FP.V4O[[i]] <- abs(V4O[[i]] - TP[[i]])
FP.tV4O <- list(); for(i in 1:6) FP.tV4O[[i]] <- abs(tV4O[[i]] - TP[[i]])
FN.V3V4 <- list(); for(i in 1:6) FN.V3V4[[i]] <- abs((100-V3V4[[i]]) - (100-TP[[i]]))
FN.V4O <- list(); for(i in 1:6) FN.V4O[[i]] <- abs((100-V4O[[i]]) - (100-TP[[i]]))
FN.tV4O <- list(); for(i in 1:6) FN.tV4O[[i]] <- abs((100-tV4O[[i]]) - (100-TP[[i]]))

Pre.V3V4 <- list(); for(i in 1:6) Pre.V3V4[[i]] <- TP[[i]]/(TP[[i]]+FP.V3V4[[i]])
Pre.V4O <- list(); for(i in 1:6) Pre.V4O[[i]] <- TP[[i]]/(TP[[i]]+FP.V4O[[i]])
Pre.tV4O <- list(); for(i in 1:6) Pre.tV4O[[i]] <- TP[[i]]/(TP[[i]]+FP.tV4O[[i]])
Rec.V3V4 <- list(); for(i in 1:6) Rec.V3V4[[i]] <- TP[[i]]/(TP[[i]]+FN.V3V4[[i]])
Rec.V4O <- list(); for(i in 1:6) Rec.V4O[[i]] <- TP[[i]]/(TP[[i]]+FN.V4O[[i]])
Rec.tV4O <- list(); for(i in 1:6) Rec.tV4O[[i]] <- TP[[i]]/(TP[[i]]+FN.tV4O[[i]])

Fscore.V3V4 <- list(); for(i in 1:6) Fscore.V3V4[[i]] <- 2*((Pre.V3V4[[i]]*Rec.V3V4[[i]])/(Pre.V3V4[[i]]+Rec.V3V4[[i]]))
Fscore.V4O  <- list(); for(i in 1:6) Fscore.V4O[[i]]  <- 2*((Pre.V4O[[i]]*Rec.V4O[[i]])/(Pre.V4O[[i]]+Rec.V4O[[i]]))
Fscore.tV4O <- list(); for(i in 1:6) Fscore.tV4O[[i]] <- 2*((Pre.tV4O[[i]]*Rec.tV4O[[i]])/(Pre.tV4O[[i]]+Rec.tV4O[[i]]))

detection_correct <- cbind(
  sapply(Fscore.V3V4, mean),
  sapply(Fscore.V4O, mean),
  sapply(Fscore.tV4O, mean)
)



cols.p <- c("#4285F4","#FBBC05","#0b5e12","#6a3d9a")[-4] # 2022/03/17 modified
#pdf("figure/InSilico_PCR_02_Taxonomy_Theo_Fscore.pdf",width = 500/96,height = 450/96)
par(bty="L",mar=c(6.1,4.1,4.1,8.1))
matplot(detection_correct,ylim=c(0,1),type="n",cex.axis=0.8,
        las=1,xaxt="n",ylab="F-measure",yaxs="i")
grid()
matlines(detection_correct,type="b",pch=19,lty=1,col=cols.p,cex=1.5,lwd=1.5)
axis(1,1:6,labels = c("phylum","class","order","family","genus","species"),las=2,cex.axis=0.8)
legend("topright",legend = groups,pch=19,lty=1,col=cols.p,
       bty='n',cex=0.7,inset = c(-0.35,0),xpd=T)
dev.off()
