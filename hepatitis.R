require(rjags)
library('coda')

Y=read.table("putting.dat",header=TRUE) # read data, or I hardcoded each vector in 
putting.data=list(Y=putting$prop,N=nrow(Y),M=ncol(Y),logt=lambda) #saved as feet distance inside code explained in pdf

putting.model=jags.model("1b.model",putting.data,n.chains=1,n.adapt=1e5)

putting.samps=coda.samples("1b.model",variable.names=c("alpha0","beta0"),n.iter=1e5)#,thin=1)
linePred.glmC <- glm(Y~X, data=Y, family=binomial(link="logit"))
# assume converged as large n

cat("Posterior mean of mean alpha = ",  mean(sapply(hep.samps,function(x) x[,grep("ma",colnames(x))])), "\n") # note that replacing ma with alpha gives same result
# can use quantile of samples as follows for credible intervals
#quantile(sapply(hep.samps,function(x) x[,grep("ma",colnames(x))]),prob=c(0.025,0.975)) 
# or just use HPDinterval
cat("mean alpha C.I. =", HPDinterval(putting.samps[[chain]],prob=0.95)[grep("alpha0",colnames(hep.samps[[chain]])),],"\n")
cat("Posterior mean of mean beta = ",  mean(sapply(hep.samps,function(x) x[,grep("beta0",colnames(x))])), "\n") # note that replacing mb with beta gives same result
cat("mean beta C.I. =", HPDinterval(putting.samps[[chain]],prob=0.95)[grep("beta0",colnames(hep.samps[[chain]])),],"\n")
plot(putting.samps, ask=TRUE)