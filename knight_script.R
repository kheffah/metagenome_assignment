reads<-read.table("./krak_classified_reads")
report<-read.table("EDIT_PATH_HERE/kraken_report", sep="\t", as.is=T)
a<-read.table("EDIT_PATH_HERE/kraken_out",sep = "\t", as.is=T)
a1<-a[,2:3]
a2<-subset(a1, a1$V3==632)
a3<-subset(a1, a1$V3==1392)
anthrax<-a3
pestis<-a2

write.csv(reads, file="reads.csv")
anthrax2<-anthrax$V2
anthrax3<-as.character(anthrax2)
pestis2<-as.character(pestis$V2)

library("Biostrings")
library("ShortRead")

s = readDNAStringSet("EDIT_PATH_HEREkrak_classified_reads")
RefSeqID = names(s)
tf2<-RefSeqID%in%anthrax2
tf3<-s[tf2==T]
seqforanthrax<-tf3


tf4<-RefSeqID%in%pestis2
tf5<-s[tf4==T]
seqforpestis<-tf5


seqforpestis2<-as.data.frame(seqforpestis)
seqforanthrax2<-as.data.frame(seqforanthrax)

write.fasta(as.list(seqforpestis2$x), rownames(seqforpestis2), "seqforpestis.fasta", open="w")
write.fasta(as.list(seqforanthrax2$x), rownames(seqforanthrax2), "seqforanthrax.fasta", open="w")
