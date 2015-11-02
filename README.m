README.m

The dataset I used here is Enron Email Dataset. It is 423 MB.

What I want to analyze is as follows:

1. Extracted data from Enron Email Datasets.

2. Assembled the extracted data, transformed to a matrix, and presented as a graph.

3. Analyzed the data such as calculating the centrality, betweenness, and degree prestiges.



The first phase is to extract all interested information from the given files; they are From, To, Date, Subject and MessageID in the Emails. 

In the second step, users can concern the items they are interested in, such as the two items: the names in From and To columns. 

The third phase is to use the matrix to dig out some important information and features in the email-based social network, such as the central person, metrics centrality, betweenness and prestige metrics. Finally, a network graph has created from the matrix. All relations can be seen from this graph very directly.

For the matrix generation and data compression, I transfer the structured csv file to adjacency matrix and remove persons with too less in/out degree.


For the transformation from table to matrix,

Step 1: Load and pretreat the input file. 

Step 2: Define essential variables for further data treatment.

Step 3: Scan the input data to get a raw identical name list.

Step 4: Pretreat to reduce the size of name list.

Step 5: Form the initial matrix before refining.

Step 6: Refine the matrix by recursively removing nodes without sufficient in/out degree.


For the analysis:

Step 1: Load the matrix.

Step 2: Build the graph representation based on the matrix.

Step 3: Calculate the indegree, outdegree, centrality, betweenness, and prestige values for each person. 

Step 4: Plot the graph.




