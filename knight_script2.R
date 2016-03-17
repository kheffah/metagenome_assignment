setwd("~")
library("Biostrings")
library("ShortRead")

#my krak_classified_reads were in fastq format
reads<-readDNAStringSet("krak_classified_reads", format ="fastq")
report<-read.table("kraken_report", sep="\t", as.is=T)
a<-read.table("kraken.out",sep = "\t", as.is=T)
a1<-a[,2:3]
anthrax<-subset(a1, a1$V3==632)
pestis<-subset(a1, a1$V3==1392)

anthrax2<-as.character(anthrax$V2)
pestis2<-as.character(pestis$V2)

find_matches <- function(hlist,reads){
  res <- vector()
  for (i in hlist){
    temp <- paste(i," ",sep = "")
    res1 <-which(grepl(temp,names(reads)))
    print(res1)
    res <- append(res,res1)
  }
  return(res)
}


if (length(pestis2) >0) {
  results <- find_matches(pestis2,reads)
  writeFasta(reads[results],"Ypestis.fasta")
}
if (length(anthrax2) >0) {
  results <- find_matches(anthrax2,reads)
  writeFasta(reads[results],"Banthracis.fasta",format=fasta)
}