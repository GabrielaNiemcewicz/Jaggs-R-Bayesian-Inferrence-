

library(rjags)
misprints2 = list(N=10,x=c(2, 2, 3, 5, 2, 5, 6, 4, 3, 1))
inits2 = list(labdap = 24, r=12) 
jmodel2=jags.model(file="misprints.model", data=misprints2, inits2) 
samps2=jags.samples(jmodel2,"lambda",n.iter=100000) # create 100000 samples from misprints model posterior

 xmin= 0
 xmax= 20
plot(density(samps2$lambda),col=3,lwd=2,xlab="per page",main="numer of misprints", xlim=c(xmin,xmax))
#posterior gamma distribution from algorithm learning from previous analysis in 1(a)


 # 2(a) continued now compare to using old 1(a) prior and full dataset
misprints2a = list(N=16,x=c(3, 4, 2, 1, 2, 3, 2, 2, 3, 5, 2, 5, 6, 4, 3, 1))
inits2a = list(labdap = 9, r=6) 
jmodel2a=jags.model(file="misprints.model", data=misprints2a, inits2a) 
samps2a=jags.samples(jmodel2a,"lambda",n.iter=100000) # create 100000 samples from misprints model posterior

 xmin= 0
 xmax= 15
plot(density(samps2a$lambda),col=3,lwd=2,xlab="per page",main="numer of misprints", xlim=c(xmin,xmax))



#2 (b) sample lambda based on new, learned Gamma(24,12), and on list misprints2
jmodel2b=jags.model(file="misprints.model", data=misprints2, inits2a) 







set.seed(755555038) #randomize selection
fromInferencedGamma =list(x=1000,lambdaPo=24,rPo=12)

N <- 1000
x <- rgamma(N, lambda=12, rate=12)

inits2b = list(labdaPo = 24, rPo=12) 
jmodel2b=jags.model(file="Gamma24-12.model", data=misprints2, inits2b) 

sampslambda=jags.samples(jmodel2,"lambda",n.iter=1000)
