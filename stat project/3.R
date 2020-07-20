n_vectors=1000
sampslambda=jags.samples(jmodel2,"lambda",n.iter=n_vectors) #previously randomly chosen lambdas from Gamma 

simulations = as.data.frame();   #first created empty twodimensional data frame
# because can behave similar to ArrayList<int Arrays[16]> of final max length 1000


for (lambdas_index in 1:n_vectors){
inits3 = list(labdap = sampslambda[lambdas_index], r=12) #use each lambda as first guess
jmodel3each=jags.model(file="misprints.model", data=misprints2a, inits3)
samps3each=jags.samples(jmodel3each,"lambda",n.iter=16)
#vector Simulation, append it to dataframe simulation
simulations <- rbind(simulations,samps3each)
} 
#we generated 1000 simulations of vectors of 16 examples of how observed data with given 'assumed true' lambda could look like


#now we calculate 1000 quadruple summary statistics- for each vector of simulated 16 observations
summary_stats = as.data.frame();  
s_s_column_names = c("maximum", "minimum", "mean", "std deviation")
colnames(summary_stats) <- s_s_column_names

for (each_vector_i in 1:n_vectors){
#for each vector under next index, using full length 16, calculate 'local', 'temp' summary statistics
maximum <- max(simulations[each_vector_i,])
min <- min(simulations[each_vector_i,])
mean <- mean(simulations[each_vector_i,])
std_dev <- sd(simulations[each_vector_i,])


#creating vectors out of single temporary ss that will be appended as rows to summary_stats
s_s_each <- c(maximum,minimum,mean,std_dev)
summary_stats <- rbind(summary_stats, s_s_each)
}

#creating tables to aid creation of barplots
counts_max <- table(summary_stats$maximum)
counts_min <- table(summary_stats$minimum)

#plotting 1 of 4 summary statistics datasets at a time
 barplot(counts_max)
 barplot(counts_min) 
 hist(summary_stats$mean, breaks= 10)
 hist(summary_stats$std_dev, breaks= 10)
