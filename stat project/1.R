

library(rjags)
misprints = list(N=6,x=c(3,4,2,1,2,3))
inits = list(labdap = 9, r=6) 
jmodel=jags.model(file="misprints.model", data=misprints, inits) 
samps=jags.samples(jmodel,"lambda",n.iter=100000) # create 1000 samples from misprints model posterior

 xmin= 0
 xmax= 20
plot(density(samps$lambda),col=3,lwd=2,xlab="per page",main="numer of misprints", xlim=c(xmin,xmax))


 # 1(b) now compare to the theoretical results
lambdaPo = 24
rPo= 12
lambdap = 6
#posterior results
curve(dgamma(lambdaPo, rPo),add=T,col=5,lwd=2,lty=2) #plot shape of theoretical posteriori

#theoretical results
 theoreticalGamma <- round(rgamma(100000,shape = 24,rate = 12),1)
 hist(theoreticalGamma, breaks= 1000)




