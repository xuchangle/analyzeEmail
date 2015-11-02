#Second part: transform from the table to a matrix

table2matrix <-function (path="D:\\structured_data.csv",sort=TRUE,delFirstCol=TRUE ,Threshold=1){

  data<-read.csv(path) 
  

  if(delFirstCol!=FALSE){
    data[1]<-NULL
    print("First Column(Row ID) is removed")
    #Now the data[1] will be column "From"    
  }

  
  #For sake of testing, assign the column ID here to avoid hardcoding.
  FromColmn=1
  ToColmn=2

  Rows=length(data[[FromColmn]])

  nameStr=as.character(data[[FromColmn]])

  targetStr=as.character(data[[ToColmn]])

  Dictionary<-c(0);
  TargetList<-c(0);

  Append=c(0);
  

  timeOption=options(digits.secs = 6)
  options(timeOption)
  TimeMs=Sys.time();
  
  #Size of Matrix
  MatrixSize=0;

  #Iteration by rows
  #scan for names and size of identical name list in order to define and initiate the matrix (get the dimName and size)
    for(i in 1:Rows)
    {
   
      Name=nameStr[i];
    
      if((is.na(Dictionary[Name])) && (is.na(TargetList[Name]))){
       
        MatrixSize=MatrixSize+1
        
        Dictionary[Name]=1;
        TargetList[Name]=0;
        
        Append[MatrixSize]=Name;
        
      }
      else
      {
        Dictionary[Name]=Dictionary[Name]+1
      }
      
      Name=targetStr[i] #There may exist someone only occurs in column "To", so the target should also be checked
      
       if((is.na(Dictionary[Name])) && (is.na(TargetList[Name]))){
        
        MatrixSize=MatrixSize+1
      
        TargetList[Name]=1;
        Dictionary[Name]=0;
        
        Append[MatrixSize]=Name;
      }    
      else
      {
        TargetList[Name]=TargetList[Name]+1
      }
    }
  
     i=1;
      while(i<=MatrixSize){
          if((Dictionary[Append[i]]<=Threshold || TargetList[Append[i]]<=Threshold )){ #||(is.na(Dictionary[Append[i]]) ||is.na(TargetList[Append[i]]))
           
            MatrixSize=MatrixSize-1
           
            Dictionary[Append[i]]=0;
            TargetList[Append[i]]=0;
            Append<-Append[-i]
            
          }
          else{
            Dictionary[Append[i]]=Threshold+1
            i=i+1
          }
      }
  
   #The dimension name of the matrix will be defined by the name List
  DimName=list(Row=Append,Col=Append)
  #Initialize the matrix with all persons and all 0 in each cell.
  adjMatrix=matrix(c(0),MatrixSize,MatrixSize,TRUE,DimName)

  
  #Scan the list of input data again, overwrite element of matrix[A,B] by 1 if A sent email to B.
  for(i in 1:Rows)
  {
    Name=nameStr[i];
    Target=targetStr[i];
    if( (Dictionary[Name]<=Threshold) ||  (Dictionary[Target]<=Threshold) || Name==Target ){
    }
    else{
      adjMatrix[Name,Target]=1
    }
    
  }
  
  #Refine the matrix by removing person with too less in/out degree
  adjMatrix2=refineMatrix(adjMatrix,MatrixSize[[1]])
  
  write.csv(adjMatrix2,file="D:\\MatrixOutput.csv")
  TimeDiff=(Sys.time()-TimeMs);
  print(TimeDiff)
   return(adjMatrix2)

}

#This is just a debug func for test and experiments on R language
labrat<-function(){
  print("test code")
  test2=(c("a","b","c","d","e"))
  test3=list(Row=test2,Col=test2)
  test=matrix(c(1:25),5,5,TRUE,test3)
  print(test)
  i=1
  while(i<4)
  {
    print(i)
    i=i+1
  }
  (test)
}

# Refine the matrix by removing rows and columns with too less edges
refineMatrix<-function(adjMatrix, MatrixSize)
{
  # Loop is the flag to check whether the scanning for the matrix should be recursively done again.
  Loop=TRUE;
  while(Loop){
   
    Loop=FALSE;
    i=1
    while(i<=MatrixSize)
    {
      #Calculate current out/in degree by calculating the sum of current row/column
      rSum<-sum(adjMatrix[i,])
      cSum<-sum(adjMatrix[,i])
      
      #If the person should be kicked out
      if(rSum<=1 || cSum<=1){
        adjMatrix<-adjMatrix[-i,]
        adjMatrix<-adjMatrix[,-i]
    
        MatrixSize=MatrixSize-1
        Loop=TRUE
        
      }
      else
      {
        i=i+1
      }
    }
  }
  return (adjMatrix)
}
