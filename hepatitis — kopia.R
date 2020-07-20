require(rjags)

Y=read.table("putting.dat",header=TRUE) # the raw data
hep.data=list(Y=Y,N=nrow(Y),M=ncol(Y),logt=log(c (2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20))) #no log

putModel1b.model=jags.model("1b.model",putting.data,n.chains=1,n.adapt=1e5)

hep.samps=coda.samples(putModel1b.model,variable.names=c("alpha0","beta0","phia"),n.iter=1e5)#,thin=0)

# note mean of a mean of obs is the same as mean of all obs but quantiles of means are not quantiles of all obs
# so replacing ma with alpha is gives the same result for the mean but different for the Credible Interval
# once converged just use the first chain for summaries
chain=1
cat("Posterior mean of mean alpha = ",  mean(sapply(hep.samps,function(x) x[,grep("ma",colnames(x))])), "\n") # note that replacing ma with alpha gives same result
# can use quantile of samples as follows for credible intervals
#quantile(sapply(hep.samps,function(x) x[,grep("ma",colnames(x))]),prob=c(0.025,0.975)) 
# or just use HPDinterval
cat("mean alpha C.I. =", HPDinterval(hep.samps[[chain]],prob=0.95)[grep("ma",colnames(hep.samps[[chain]])),],"\n")
cat("Posterior mean of mean beta = ",  mean(sapply(hep.samps,function(x) x[,grep("mb",colnames(x))])), "\n") # note that replacing mb with beta gives same result
cat("mean beta C.I. =", HPDinterval(hep.samps[[chain]],prob=0.95)[grep("mb",colnames(hep.samps[[chain]])),],"\n")
