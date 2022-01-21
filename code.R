url <- "https://en.wikipedia.org/wiki/List_of_Singapore_MRT_stations"
> mrt_stn <-  url %>%
+     read_html() %>%
+     #paste the copied xpath: html_nodes(xpath here)
+     html_nodes(xpath='//*[@id="mw-content-text"]/div[1]/table[3]') %>% 
+     html_table(fill = TRUE)
> mrt <- mrt_stn[[1]]
> 
> 
> 
> # data cleaning 
> mrt <- mrt[,c(1:3,6,8:9)] 
> names(mrt) <- c("Code","Name","Opening","Status","Location","Transpotation")
> mrt <- subset(mrt,Code != Name)
> mrt <- mrt[2:nrow(mrt),]
> mrt$Code <- substr(mrt$Code, 1, 4)
> mrt$Code <- iconv(mrt$Code, "ASCII", "UTF-8", sub="")
> mrt$Name <- gsub('\\[.\\]',"",mrt$Name)
> mrt <- mrt[mrt$Name != 'Reserved Station',]
> mrt <- mrt[mrt$Name != 'Punggol Coast',]
> mrt <- mrt[mrt$Status != 'TBA',]
> #Generating the MRT network's edgelist
> 
> 
> ns_df <- mrt[substr(mrt$Code,1,2) == 'NS',]
> 
> sourceList <- ""
> targetList <- ""
> for (i in 1:nrow(ns_df)-1) {
+     sourceList[i] <- ns_df$Opening[i]
+     targetList[i] <- ns_df$Opening[i+1]
+ }
> 
> ns_edgelist <- data.frame(sourceList, targetList, "NSL")
> names(ns_edgelist) <- c("source", "target", "network")
> 
> 
> ew_df <- mrt[substr(mrt$Code,1,2) == 'EW',]
> 
> sourceList <- ""
> targetList <- ""
> for (i in 1:nrow(ew_df)-1) {
+     sourceList[i] <- ew_df$Opening[i]
+     targetList[i] <- ew_df$Opening[i+1]
+ }
> 
> ew_edgelist <- data.frame(sourceList, targetList, "EWL")
> 
> 
> cg_df <- mrt[substr(mrt$Code,1,2) == 'CG',]
> 
> sourceList <- ""
> targetList <- ""
> for (i in 1:nrow(cg_df)-1) {
+     sourceList[i] <- cg_df$Opening[i]
+     targetList[i] <- cg_df$Opening[i+1]
+ }
> 
> cg_edgelist <- data.frame(sourceList, targetList, "CAL")
> names(cg_edgelist) <- c("source", "target", "network")
> 
> 
> ne_df <- mrt[substr(mrt$Code,1,2) == 'NE',]
> 
> sourceList <- ""
> targetList <- ""
> for (i in 1:nrow(ne_df)-1) {
+     sourceList[i] <- ne_df$Opening[i]
+     targetList[i] <- ne_df$Opening[i+1]
+ }
> 
> ne_edgelist <- data.frame(sourceList, targetList, "NEL")
> names(ne_edgelist) <- c("source", "target", "network")
> 
> cc_df <- mrt[substr(mrt$Code,1,2) == 'CC',]
> 
> sourceList <- ""
> targetList <- ""
> for (i in 1:nrow(cc_df)-1) {
+     sourceList[i] <- cc_df$Opening[i]
+     targetList[i] <- cc_df$Opening[i+1]
+ }
> 
> cc_edgelist <- data.frame(sourceList, targetList, "CCL")
> names(cc_edgelist) <- c("source", "target", "network")
> 
> 
> dt_df <- mrt[substr(mrt$Code,1,2) == 'DT',]
> 
> sourceList <- ""
> targetList <- ""
> for (i in 1:nrow(dt_df)-1) {
+     sourceList[i] <- dt_df$Opening[i]
+     targetList[i] <- dt_df$Opening[i+1]
+ }
> 
> dt_edgelist <- data.frame(sourceList, targetList, "DTL")
> names(dt_edgelist) <- c("source", "target", "network")
> 
> mrt_edgelist <- rbind(ns_edgelist,ew_edgelist,cg_edgelist,ne_edgelist,cc_edgelist,dt_edgelist)

> 
> mrt_edgelist
