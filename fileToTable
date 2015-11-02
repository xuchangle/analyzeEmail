# analyzeEmail
#Extract and analyze data from Enron Email Datasets by R
#First part: extract data from datasets


###  initialize     ##########
c<-list.files("F:/maildir", pattern = "1", recursive = TRUE)
d<-paste("F:/maildir/",c,sep="")
fin_Name_From<-""; fin_Name_To<-"";fin_From<-""; fin_To<-""; fin_Date<-"";fin_Subj<-"";fin_msgID<-""
 "^[[:alnum:].-]+@[[:alnum:].-]+$"->regex
 
for (f in 1:length(d)) {
  con<-readLines(d[f],warn=FALSE)
isinTo=FALSE 
# From, vectorTo, Date, Subj, msgID
for (i in 1:length(con)) {
  if (sum(grep("Message-ID: ",con[i],fixed=TRUE))!=0){
    msgID<-sub("Message-ID: ","",con[i],fixed=TRUE)
    next
  }
  
  if (sum(grep("Date: ",con[i],fixed=TRUE))!=0){
    Date<-sub("Date: ","",con[i],fixed=TRUE)
    next
  } 
  
  if (sum(grep("From: ",con[i],fixed=TRUE))!=0 & sum(grep("X-From: ",con[i],fixed=TRUE))==0) {
    From<-sub("From: ","",con[i],fixed=TRUE)
    next
  } 
  
  if (sum(grep("To: ",con[i],fixed=TRUE))!=0 & sum(grep("X-To: ",con[i],fixed=TRUE))==0){
    To<-sub("To: ","",con[i],fixed=TRUE)
    isinTo=TRUE
    next
  } 
  
  if (isinTo){
    if (sum(grep("Subject: ",con[i],fixed=TRUE))!=0){
      isinTo=FALSE
      Subj<-sub("Subject: ","",con[i],fixed=TRUE)
      vectorTo<-unlist(strsplit(To,", ",fixed=TRUE))
      
    } 
    To<-paste(To,sub("\t","",con[i],fixed=TRUE),sep="")
  }
  
  if (sum(grep("X-From: ",con[i],fixed=TRUE))!=0){
    Name_From<-sub("X-From: ","",con[i],fixed=TRUE)
    next
  } 
  if (sum(grep("X-To: ",con[i],fixed=TRUE))!=0){
    Name_To<-sub("X-To: ","",con[i],fixed=TRUE)
    vectorName_To<-unlist(strsplit(Name_To,", ",fixed=TRUE))
    break
  } 
  
}

# if there is any string not the Email address in "From" or "To" , then discard the whole file d[f]
if (sum(grep(regex,vectorTo[1]))==0 | sum(grep(regex,From[1]))==0) {
  next
}

if (length(vectorTo)!=length(vectorName_To)){
  next
}

if (sum(grep("@",Name_From,fixed=TRUE))!=0 |sum(grep("@",Name_To,fixed=TRUE))!=0 ){
  next
}

if (sum(grep("<",Name_From,fixed=TRUE))!=0 |sum(grep("<",Name_To,fixed=TRUE))!=0 ){
  next
}

vector_len=length(vectorTo)
vectorName_From<-rep(Name_From,vector_len)
vectorFrom<-rep(From,vector_len)
vectorDate<-rep(Date,vector_len)
vectorSubj<-rep(Subj,vector_len)
vectormsgID<-rep(msgID,vector_len)

fin_Name_From<-c(fin_Name_From,vectorName_From)
fin_Name_To<-c(fin_Name_To,vectorName_To)
fin_From<-c(fin_From,vectorFrom)
fin_To<-c(fin_To,vectorTo)
fin_Date<-c(fin_Date,vectorDate)
fin_Subj<-c(fin_Subj,vectorSubj)
fin_msgID<-c(fin_msgID,vectormsgID)

}
#  create the csv file for storing the table ###########
output<-data.frame(fin_Name_From,fin_Name_To,fin_Date,fin_Subj,fin_msgID,fin_From,fin_To)# create a data frame
colnames(output)<-c("From","To","Date","Subject","MessageID","Email From","Email To")# change the columns' name 
output<-output[-1,];rownames(output)<-c(1:nrow(output))# delete the first empty item, re-name the rows' name
write.csv(output,file="f:/structured_data.csv")# store in csv file
