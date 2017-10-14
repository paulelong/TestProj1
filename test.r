#https://api.login.yahoo.com/oauth2/request_auth?client_id=dj0yJmk9dm4yTW9oamVGTFhnJmQ9WVdrOWR6RjVUWEJZTjJzbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00Yg--&redirect_uri=oob&response_type=code&language=en-us
library(ROAuth)
library(curl)
library(openssl)
library(httr)
#library(xml2)

reqURL <- "http://api.login.yahoo.com/oauth2/get_token" 
accessURL <- "http://api.login.yahoo.com/oauth2/get_token" 
authURL <- "https://api.login.yahoo.com/oauth2/request_auth" 
cKey <- "dj0yJmk9dm4yTW9oamVGTFhnJmQ9WVdrOWR6RjVUWEJZTjJzbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00Yg--" 
cSecret <- "1b72efee9f73e2b64270cbd2a908873da8ddd04a" 
testURL <- "https://api.login.yahoo.com/oauth2/request_auth"
cCode <- "xh3t9y3"

URLReq <- paste0(authURL,"?client_id=",cKey,"&redirect_uri=oob&response_type=code&language=en-us")
URLReq
#r1 <- GET(URLReq)
#stop_for_status(r1)


URLReq <- paste0(accessURL,"?client_id=",cKey,"&client_secret=",cSecret,"&code=",cCode,"&redirect_uri=oob&grant_type=authorization_code")
URLReq

#base 64 encoding
b64encoded <- base64_encode(paste0(cKey,":",cSecret))


value <- paste0("Basic ",b64encoded)
r <- POST(URLReq, add_headers(Authorization = value), add_headers("Content-Type" = "application/x-www-form-urlencoded"))

#r <- GET("http://www.msn.com", a=1, b=2)
stop_for_status(r)
#content(r)
r


