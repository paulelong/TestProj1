
#https://api.login.yahoo.com/oauth2/request_auth?client_id=dj0yJmk9dm4yTW9oamVGTFhnJmQ9WVdrOWR6RjVUWEJZTjJzbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00Yg--&redirect_uri=oob&response_type=code&language=en-us
#library(ROAuth)
#library(curl)
library(openssl)
library(httr)
#library(xml2)

reqURL <- "http://api.login.yahoo.com/oauth2/get_token" 
accessURL <- "http://api.login.yahoo.com/oauth2/get_token" 
authURL <- "http://api.login.yahoo.com/oauth2/request_auth" 
cKey <- "dj0yJmk9dm4yTW9oamVGTFhnJmQ9WVdrOWR6RjVUWEJZTjJzbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00Yg--" 
cSecret <- "1b72efee9f73e2b64270cbd2a908873da8ddd04a" 
testURL <- "https://api.login.yahoo.com/oauth2/request_auth"

gamesQuery <- "https://fantasysports.yahooapis.com/fantasy/v2/game/nfl"
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
#r <- POST(URLReq, add_headers(Authorization = value), add_headers("Content-Type" = "application/x-www-form-urlencoded"))
#r <- GET("http://www.msn.com", a=1, b=2)
#r <- GET(gamesQuery)
#stop_for_status(r)
#content(r)
#r

y.app <- oauth_app("yahoo", key=cKey, secret=cSecret, redirect_uri = "oob")
#y.urls <- oauth_endpoint(NULL, "authorize", "accessToken", base_url="https://fantasysports.yahooapis.com/fantasy/v2/")
y.urls <- oauth_endpoint(NULL, "request_auth", "get_token", base_url="https://api.login.yahoo.com/oauth2")

l <- list(redirect_uri = "oob", x=xyz)
#oauth2.0_authorize_url(y.urls, redirect_uri = "oob")
authorize_url <- modify_url(y.urls, query = compact(list(redirect_uri="oob")))

#y.token <- oauth2.0_token(y.urls, y.app)d
yahoo_token <- oauth1.0_token(oauth_endpoints("yahoo"), y.app)
y.token
#
resp <- GET("https://fantasysports.yahooapis.com/fantasy/v2/game/nfl", config(token = yahoo_token))
u <- "https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.leagues%20where%20league_key%3D'371.l.272272'&format=json&diagnostics=true&callback="
u <- "http://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.games%20where%20use_login%3D1%20and%20game_key%20in%20('238'%2C%20'223'%2C%20'mlb'%2C%20'nfl')&format=json&diagnostics=true&callback="
u <- "https://query.yahooapis.com/v1/public/yql?q=select wind from weather.forecast where woeid in (select woeid from geo.places(1) where text='chicago, il')&format=json&callback="

u <- "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22YHOO%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
u <- "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20like%20(%27%25Y%25%27)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
resp <- GET(u)

j <- content(resp, as = "text")
info <- fromJSON(j)

#for(i in resp$content){ print(rawToChar(as.raw(i))) }
j <- content(resp, as = "text")
info <- fromJSON(j)
info$results$symbol

x <- "hey there"
x

str(info$query$results$quote$symbol)