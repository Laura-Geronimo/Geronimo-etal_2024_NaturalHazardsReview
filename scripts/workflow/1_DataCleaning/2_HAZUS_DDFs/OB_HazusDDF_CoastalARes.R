##Processing DDFs for application in Study####

#Setup
getwd()
setwd('C:/Users/lgero/Box/Research/NJSG/Tradeoff_Analysis/V4')
library(dplyr)
library(data.table)
library(ggplot2)

#import data
hazus <- read.csv('./data/DataDownloads/HAZUS/haz_fl_dept.csv')

#Processing HAZUS data ####
names(hazus)
hazus<-hazus[,c(-1)]
table(hazus$Occupancy)
table(hazus$DmgFnId)


#subsetting to damage function IDs recommended in HAZUS 5.1 Flood Model Technical Manual p.5.8 Coastal A & V zone
hazus2 <- subset(hazus, 
                   DmgFnId=="107"| #two floors no basement, A-zone
                   DmgFnId=="109" |  #three or more floors, no basement A-zone
                   DmgFnId=="114"| # one floor w/ basement V-zone (note: no curve for 1 floor w/out basement)
                   DmgFnId=="115"| #two floors, no basement V-zone
                   DmgFnId=="117"| #three or more floors, no basement, V-zone
                   
                   #note: the following are not available: 
                   DmgFnId=="658"|  #all floors, slab- no basement Coastal A or V zone
                   DmgFnId=="659"| #1 to 2 stories, slab - no basement coastal A or V zone
                   DmgFnId=="660"  #1 to w stories, slab - no basement coastal A or V zone
                 )
table(hazus2$DmgFnId)


#reducing hazus to residential and relevant columns#
hazus3 <- subset(hazus2, Occupancy %like% "RES")
names(hazus3)
table(hazus3$DmgFnId)
hazus4 <-hazus3[,c(1:33)]
names(hazus4)

#creating depth field#
hazus4[nrow(hazus4)+1,]=c("Occupancy","DmgFnID","Source","Description", -4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24)

#Extracting curves by dmgid

#DmgFnId 107 ####
hazus107 <- subset(hazus4, DmgFnId=="107")
hazus107[nrow(hazus107)+1,]=c("Occupancy","DmgFnID","Source","Description", -4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24) 
hazus107$Var <- c("damage107","depth")
names(hazus107)
hazus107<- hazus107[,c(34,5:33)]

#transposing data
hazus107t <- data.frame(t(hazus107[-1]))
colnames(hazus107t)<- hazus107[,1]
plot(hazus107t$depth,hazus107t$damage107)

#DmgFnId 109 ####
hazus109 <- subset(hazus4, DmgFnId=="109")
hazus109[nrow(hazus109)+1,]=c("Occupancy","DmgFnID","Source","Description", -4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24) 
hazus109$Var <- c("damage109","depth")
names(hazus109)
hazus109<- hazus109[,c(34,5:33)]

#transposing data
hazus109t <- data.frame(t(hazus109[-1]))
colnames(hazus109t)<- hazus109[,1]
plot(hazus109t$depth,hazus109t$damage109)


#DmgFnId 114 ####
hazus114 <- subset(hazus4, DmgFnId=="114")
hazus114[nrow(hazus114)+1,]=c("Occupancy","DmgFnID","Source","Description", -4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24) 
hazus114$Var <- c("damage114","depth")
names(hazus114)
hazus114<- hazus114[,c(34,5:33)]

#transposing data
hazus114t <- data.frame(t(hazus114[-1]))
colnames(hazus114t)<- hazus114[,1]
plot(hazus114t$depth,hazus114t$damage114)

#DmgFnId 115 ####
hazus115 <- subset(hazus4, DmgFnId=="115")
hazus115[nrow(hazus115)+1,]=c("Occupancy","DmgFnID","Source","Description", -4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24) 
hazus115$Var <- c("damage115","depth")
names(hazus115)
hazus115<- hazus115[,c(34,5:33)]

#transposing data
hazus115t <- data.frame(t(hazus115[-1]))
colnames(hazus115t)<- hazus115[,1]
plot(hazus115t$depth,hazus115t$damage115)


#DmgFnId 117 ####
hazus117 <- subset(hazus4, DmgFnId=="117")
hazus117[nrow(hazus117)+1,]=c("Occupancy","DmgFnID","Source","Description", -4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24) 
hazus117$Var <- c("damage117","depth")
names(hazus117)
hazus117<- hazus117[,c(34,5:33)]

#transposing data
hazus117t <- data.frame(t(hazus117[-1]))
colnames(hazus117t)<- hazus117[,1]
plot(hazus117t$depth,hazus117t$damage117)

                 
#joining####
myHazus1 <- left_join(hazus107t,hazus109t, by="depth", copy=F)
myHazus1 <- left_join(myHazus1,hazus114t, by="depth", copy=F)
myHazus1 <- left_join(myHazus1,hazus115t, by="depth", copy=F)
myHazus1 <- left_join(myHazus1,hazus117t, by="depth", copy=F)
myHazus1 <- myHazus1[,c(2,1,3,4,5,6)]

plot(myHazus1$depth,myHazus1$damage114, type="o", col="blue", pch="o", ylab="y", lty=1, ylim=c(0,80))
points(myHazus1$depth,myHazus1$damage107, type="o", col="purple", pch="o", ylab="y", lty=1)
points(myHazus1$depth,myHazus1$damage115, type="o", col="orange", pch="o", ylab="y", lty=1)
points(myHazus1$depth,myHazus1$damage109, type="o", col="red", pch="o", ylab="y", lty=1)
points(myHazus1$depth,myHazus1$damage117, type="o", col="black", pch="o", ylab="y", lty=1)

legend(-5,200,legend=c("1 floor w/ basement V-zone",
                     "2 floors no basement, A-zone",
                     "2 floors, no basement V-zone",
                     "3 or more floors, no basement A-zone",
                     "3 or more floors, no basement, V-zone"
                     ),
       col=c("blue","purple","orange","red","black"),
       pch=c("o","o","o","o","o"))

#writing out files ####

path1 <- './data/DataDownloads/HAZUS/Produced'
write.csv(myHazus1, file.path(path1, "myHazus1.csv"), row.names=TRUE)

