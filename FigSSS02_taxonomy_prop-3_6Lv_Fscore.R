rm(list=ls())
load("../taxonomy_prop-1.RData")
source("../FN_functionsets.R")
groups <- factor(c(rep("3",29),rep("O",10),rep("N",10),
                   rep("p",10),rep("q",10),rep("o",29),rep("n",29)),levels = c("3","O","o","p"),labels = c("V3V4","V4O","tV4O","V4OSE"))
cols.p <- c("#4285F4","#FBBC05","#0b5e12","#6a3d9a") # 2022/03/17 modified


q2.D1.phylum <- as.data.frame(t(prop.table(aggregate.3(q2otu,q2taxa$V2,sum),1)*100))
q2.D1.phylum <- q2.D1.phylum[order(rowSums(q2.D1.phylum),decreasing = T),]
q2.D1.class <- as.data.frame(t(prop.table(aggregate.3(q2otu,paste(q2taxa$V2,q2taxa$V3,sep = " "),sum),1)*100))
q2.D1.class <- q2.D1.class[order(rowSums(q2.D1.class),decreasing = T),]
q2.D1.order <- as.data.frame(t(prop.table(aggregate.3(q2otu,paste(q2taxa$V2,q2taxa$V3,q2taxa$V4,sep = " "),sum),1)*100))
q2.D1.order <- q2.D1.order[order(rowSums(q2.D1.order),decreasing = T),]
q2.D1.family <- as.data.frame(t(prop.table(aggregate.3(q2otu,paste(q2taxa$V2,q2taxa$V3,q2taxa$V4,q2taxa$V5,sep = " "),sum),1)*100))
q2.D1.family <- q2.D1.family[order(rowSums(q2.D1.family),decreasing = T),]
q2.D1.genus <- as.data.frame(t(prop.table(aggregate.3(q2otu,paste(q2taxa$V2,q2taxa$V3,q2taxa$V4,q2taxa$V5,q2taxa$V6,sep = " "),sum),1)*100))
q2.D1.genus <- q2.D1.genus[order(rowSums(q2.D1.genus),decreasing = T),]
q2.D1.species <- as.data.frame(t(prop.table(aggregate.3(q2otu,paste(q2taxa$V2,q2taxa$V3,q2taxa$V4,q2taxa$V5,q2taxa$V6,q2taxa$V7,sep = " "),sum),1)*100))
q2.D1.species <- q2.D1.species[order(rowSums(q2.D1.species),decreasing = T),]

q2.D1.phylum.gp <- as.data.frame(aggregate.3(q2.D1.phylum,groups,mean))
q2.D1.class.gp <- as.data.frame(aggregate.3(q2.D1.class,groups,mean))
q2.D1.order.gp <- as.data.frame(aggregate.3(q2.D1.order,groups,mean))
q2.D1.family.gp <- as.data.frame(aggregate.3(q2.D1.family,groups,mean))
q2.D1.genus.gp <- as.data.frame(aggregate.3(q2.D1.genus,groups,mean))
q2.D1.species.gp <- as.data.frame(aggregate.3(q2.D1.species,groups,mean))

#####
V3V4  <- list(q2.D1.phylum.gp$V3V4 ,q2.D1.class.gp$V3V4 ,q2.D1.order.gp$V3V4 ,q2.D1.family.gp$V3V4 ,q2.D1.genus.gp$V3V4 ,q2.D1.species.gp$V3V4 )
V4O   <- list(q2.D1.phylum.gp$V4O  ,q2.D1.class.gp$V4O  ,q2.D1.order.gp$V4O  ,q2.D1.family.gp$V4O  ,q2.D1.genus.gp$V4O  ,q2.D1.species.gp$V4O  )
tV4O  <- list(q2.D1.phylum.gp$tV4O ,q2.D1.class.gp$tV4O ,q2.D1.order.gp$tV4O ,q2.D1.family.gp$tV4O ,q2.D1.genus.gp$tV4O ,q2.D1.species.gp$tV4O )
V4OSE <- list(q2.D1.phylum.gp$V4OSE,q2.D1.class.gp$V4OSE,q2.D1.order.gp$V4OSE,q2.D1.family.gp$V4OSE,q2.D1.genus.gp$V4OSE,q2.D1.species.gp$V4OSE)

# V3V4 as reference
TP <- V3V4
TN <- lapply(V3V4, function(x) 100-x)
FP.V4O <- list(); for(i in 1:6) FP.V4O[[i]] <- abs(V4O[[i]] - TP[[i]])
FP.tV4O <- list(); for(i in 1:6) FP.tV4O[[i]] <- abs(tV4O[[i]] - TP[[i]])
FP.V4OSE <- list(); for(i in 1:6) FP.V4OSE[[i]] <- abs(V4OSE[[i]] - TP[[i]])
FN.V4O <- list(); for(i in 1:6) FN.V4O[[i]] <- abs((100-V4O[[i]]) - (100-TP[[i]]))
FN.tV4O <- list(); for(i in 1:6) FN.tV4O[[i]] <- abs((100-tV4O[[i]]) - (100-TP[[i]]))
FN.V4OSE <- list(); for(i in 1:6) FN.V4OSE[[i]] <- abs((100-V4OSE[[i]]) - (100-TP[[i]]))

Pre.V4O <- list(); for(i in 1:6) Pre.V4O[[i]] <- TP[[i]]/(TP[[i]]+FP.V4O[[i]])
Pre.tV4O <- list(); for(i in 1:6) Pre.tV4O[[i]] <- TP[[i]]/(TP[[i]]+FP.tV4O[[i]])
Pre.V4OSE <- list(); for(i in 1:6) Pre.V4OSE[[i]] <- TP[[i]]/(TP[[i]]+FP.V4OSE[[i]])
Rec.V4O <- list(); for(i in 1:6) Rec.V4O[[i]] <- TP[[i]]/(TP[[i]]+FN.V4O[[i]])
Rec.tV4O <- list(); for(i in 1:6) Rec.tV4O[[i]] <- TP[[i]]/(TP[[i]]+FN.tV4O[[i]])
Rec.V4OSE <- list(); for(i in 1:6) Rec.V4OSE[[i]] <- TP[[i]]/(TP[[i]]+FN.V4OSE[[i]])

Fscore.V4O  <- list(); for(i in 1:6) Fscore.V4O[[i]]  <- 2*((Pre.V4O[[i]]*Rec.V4O[[i]])/(Pre.V4O[[i]]+Rec.V4O[[i]]))
Fscore.tV4O <- list(); for(i in 1:6) Fscore.tV4O[[i]] <- 2*((Pre.tV4O[[i]]*Rec.tV4O[[i]])/(Pre.tV4O[[i]]+Rec.tV4O[[i]]))
Fscore.V4OSE <- list(); for(i in 1:6) Fscore.V4OSE[[i]] <- 2*((Pre.V4OSE[[i]]*Rec.V4OSE[[i]])/(Pre.V4OSE[[i]]+Rec.V4OSE[[i]]))

detection_correct <- cbind(
  sapply(Fscore.V4O, mean, na.rm = TRUE),
  sapply(Fscore.tV4O, mean, na.rm = TRUE),
  sapply(Fscore.V4OSE, mean, na.rm = TRUE)
)

# V4O as reference
TP <- V4O
TN <- lapply(V4O, function(x) 100-x)
FP.V3V4 <- list(); for(i in 1:6) FP.V3V4[[i]] <- abs(V3V4[[i]] - TP[[i]])
FP.tV4O <- list(); for(i in 1:6) FP.tV4O[[i]] <- abs(tV4O[[i]] - TP[[i]])
FP.V4OSE <- list(); for(i in 1:6) FP.V4OSE[[i]] <- abs(V4OSE[[i]] - TP[[i]])
FN.V3V4 <- list(); for(i in 1:6) FN.V3V4[[i]] <- abs((100-V3V4[[i]]) - (100-TP[[i]]))
FN.tV4O <- list(); for(i in 1:6) FN.tV4O[[i]] <- abs((100-tV4O[[i]]) - (100-TP[[i]]))
FN.V4OSE <- list(); for(i in 1:6) FN.V4OSE[[i]] <- abs((100-V4OSE[[i]]) - (100-TP[[i]]))

Pre.V3V4 <- list(); for(i in 1:6) Pre.V3V4[[i]] <- TP[[i]]/(TP[[i]]+FP.V3V4[[i]])
Pre.tV4O <- list(); for(i in 1:6) Pre.tV4O[[i]] <- TP[[i]]/(TP[[i]]+FP.tV4O[[i]])
Pre.V4OSE <- list(); for(i in 1:6) Pre.V4OSE[[i]] <- TP[[i]]/(TP[[i]]+FP.V4OSE[[i]])
Rec.V3V4 <- list(); for(i in 1:6) Rec.V3V4[[i]] <- TP[[i]]/(TP[[i]]+FN.V3V4[[i]])
Rec.tV4O <- list(); for(i in 1:6) Rec.tV4O[[i]] <- TP[[i]]/(TP[[i]]+FN.tV4O[[i]])
Rec.V4OSE <- list(); for(i in 1:6) Rec.V4OSE[[i]] <- TP[[i]]/(TP[[i]]+FN.V4OSE[[i]])

Fscore.V3V4 <- list(); for(i in 1:6) Fscore.V3V4[[i]] <- 2*((Pre.V3V4[[i]]*Rec.V3V4[[i]])/(Pre.V3V4[[i]]+Rec.V3V4[[i]]))
Fscore.tV4O <- list(); for(i in 1:6) Fscore.tV4O[[i]] <- 2*((Pre.tV4O[[i]]*Rec.tV4O[[i]])/(Pre.tV4O[[i]]+Rec.tV4O[[i]]))
Fscore.V4OSE  <- list(); for(i in 1:6) Fscore.V4OSE[[i]]  <- 2*((Pre.V4OSE[[i]]*Rec.V4OSE[[i]])/(Pre.V4OSE[[i]]+Rec.V4OSE[[i]]))

detection_correct2 <- cbind(
  sapply(Fscore.V3V4, mean, na.rm = TRUE),
  sapply(Fscore.tV4O, mean, na.rm = TRUE),
  sapply(Fscore.V4OSE, mean, na.rm = TRUE)
)

#####

#pdf("figure/taxonomy_prop-3_6Lv_Fscore.pdf",width = 960/96,height = 450/96)
par(bty="L",mar=c(6.1,4.1,4.1,8.1),mfrow=c(1,2))
matplot(detection_correct,ylim=c(0,1.05),type="n",cex.axis=0.8,
        las=1,xaxt="n",ylab="F-measure",yaxs="i")
grid()
matlines(detection_correct,type="b",pch=19,lty=1,col=cols.p[-1],cex=1.2,xpd=T,lwd=1.5)
axis(1,1:6,labels = c("phylum","class","order","family","genus","species"),las=2,cex.axis=0.8)
legend("topright",legend=c("V4O","tV4O","V4OSE"),pch=19,lty=1,col=cols.p[-1],
       bty='n',cex=0.7,inset = c(-0.45,0),xpd=T)
#
matplot(detection_correct2,ylim=c(0,1.05),type="n",cex.axis=0.8,
        las=1,xaxt="n",ylab="F-measure",yaxs="i")
grid()
matlines(detection_correct2,type="b",pch=19,lty=1,col=cols.p[-2],cex=1.2,xpd=T,lwd=1.5)
axis(1,1:6,labels = c("phylum","class","order","family","genus","species"),las=2,cex.axis=0.8)
legend("topright",legend=c("V3V4","tV4O","V4OSE"),pch=19,lty=1,col=cols.p[-2],
       bty='n',cex=0.7,inset = c(-0.45,0),xpd=T)
dev.off()