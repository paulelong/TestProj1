library(httr)
library("jsonlite")

cKey <- "dj0yJmk9dm4yTW9oamVGTFhnJmQ9WVdrOWR6RjVUWEJZTjJzbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00Yg--" 
cSecret <- "1b72efee9f73e2b64270cbd2a908873da8ddd04a" 

y.app <- oauth_app("yahoo", key=cKey, secret=cSecret, redirect_uri = "oob")

yahoo_token <- oauth1.0_token(oauth_endpoints("yahoo"), y.app)

u <- "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22YHOO%22,%22MSFT%22,%22IBM%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
resp <- GET(u, config(token = yahoo_token))

j <- content(resp, as = "text")
info <- fromJSON(j)

mylist <- info$query$results$quote

t1 <- mylist[c(1,2,3)]

t1