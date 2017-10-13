#https://api.login.yahoo.com/oauth2/request_auth?client_id=dj0yJmk9dm4yTW9oamVGTFhnJmQ9WVdrOWR6RjVUWEJZTjJzbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00Yg--&redirect_uri=oob&response_type=code&language=en-us
library(ROAuth)
library(curl)
library(openssl)

reqURL <- "https://api.login.yahoo.com/oauth2/get_token" 
accessURL <- "https://api.login.yahoo.com/oauth2/get_token" 
authURL <- "https://api.login.yahoo.com/oauth2/request_auth" 
cKey <- "dj0yJmk9dm4yTW9oamVGTFhnJmQ9WVdrOWR6RjVUWEJZTjJzbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00Yg--" 
cSecret <- "1b72efee9f73e2b64270cbd2a908873da8ddd04a" 
testURL <- "https://api.login.yahoo.com/oauth2/request_auth"
cCode <- "nh7bkaa"

h <- new_handle()
handle_setheaders(h, "client_id" = "abcdefghijklmnopqrstuvwxyz")

URLReq <- paste0(accessURL,"?client_id=",cKey,"&client_secret=",cSecret,"&code=",cCode,"&grant_type=authorization_code")

r <- curl_fetch_memory(URLReq, h)
URLReq
r

h


