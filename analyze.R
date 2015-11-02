#Third part: Analyze

install.packages("igraph")
install.packages("matrix")

require(tkp)
require(igraph)
require(Matrix)
args(matrix)

#Get the data 
load("~/Downloads/matrix.RData")
a <- Mat

#Transform the matrix to a graph
b <-graph.adjacency(a, mode=c("directed"),weighted=NULL, diag=FALSE)


row <- rowSums(a)
col <- colSums(a)

centralityValue <- rowSums(a)

normalizedCentralityValue <- rowSums(a) / (length(row) - 1)

prestigeValue <- colSums(a) / (length(row) - 1)

betweennessValue <- betweenness(b)
normalizedBetweennessValue <- betweenness(b,V(b),directed=TRUE,weights=NULL,nobigint=TRUE,normalized=TRUE)

#Write the rowSum, columnSum, centrality, normalized Centrality, degree prestige, 
#betweenness, normalized betweenness for each node to a fire. 
CalculationValues <- list(outdegree=row, indegree=col, centrality=centralityValue, 
                          normalizedCentrality=normalizedCentralityValue, 
                          prestige=prestigeValue, betweenness=betweennessValue, 
                          normalizedBetweenness=normalizedBetweennessValue)
write.csv(CalculationValues,file="CalculationValues.csv")


#Calculate g2 by a multiplies a
g2 <- a %*% a
print(g2)
write.csv(g2,file="g2.csv") 

#Calculate g3 by g2 multiplies a
g3 <- g2 %*% a
print(g3)
write.csv(g3,file="g3.csv") 

output<-"" #Display the maximum path length for each node
max_end_name <- ""
max_value <- ""
start_name <- ""

#Use DFS to find the maximum path and maximum path length
for(index in 1: vcount(b))
{
  c<-graph.dfs(b, root=index, neimode = "out", unreachable = FALSE, 
               order = TRUE, order.out = FALSE, father = FALSE, 
               dist = TRUE, in.callback = NULL, out.callback = NULL,
               extra = NULL, rho = NULL)
   x <- c$dist
  
  max <- which(x==max(x,na.rm=TRUE),arr.ind=T)
  tmp_max_end_name<-names(max)
  tmp_max_value<-x[tmp_max_end_name]
  tmp_start_name<-rep(rownames(a)[index],length(max))
  
  max_end_name<-c(max_end_name,tmp_max_end_name)
  max_value<-c(max_value,tmp_max_value)
  start_name<-c(start_name,tmp_start_name)
}

output<-data.frame(start_name,max_end_name,max_value)
output<-output[-1,]

write.csv(output,file="MaimumPathLengthForEachPerson.csv")

c<-graph.dfs(b, root="Tom Chapman", neimode = "out", unreachable = FALSE, 
             order = TRUE, order.out = TRUE, father = TRUE, 
             dist = TRUE, in.callback = NULL, out.callback = NULL,
             extra = NULL, rho = NULL)

print(c)

tkplot(b,vertex.size=8,vertex.color="green", vertex.label.dist=2,vertex.label.cex=1.1,edge.arrow.width=10,edge.arrow.size=0.75,margin=0.2,edge.color="red")
