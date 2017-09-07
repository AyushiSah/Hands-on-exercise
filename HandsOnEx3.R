ID = seq(1:100)
Income = rnorm(100,mean=250000,sd=75000)
Gender=c(rep("M",100))
i=sample(1:100,100,replace=F)
for(q in 1:100){
  if(Gender[i[q]]=="M" && q<=40){
    
  }else{
    Gender[i[q]]=c("F")
  }
}
custs <- data.frame(ID, Income, Gender)
View(custs)
