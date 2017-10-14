if(FALSE)
{
#URLReq <- paste0(authURL,"?client_id=",cKey,"&redirect_uri=oob&response_type=code&language=en-us")
#con <- curl(URLReq, handle=h)
#open(con, "rb")
#URLReq
}

#con <- curl(URLReq, handle=h)


#open(con, "rb")

#con

#readLines(con)

#credentials <- OAuthFactory$new(consumerKey=cKey, consumerSecret=cSecret, requestURL=reqURL, accessURL=accessURL, authURL=authURL, needsVerifier=FALSE) 

#credentials$handshake() 
#credentials$OAuthRequest(testURL, "GET")

URLReq <- paste0(accessURL,"?client_id=",cKey,"&client_secret=",cSecret,"&code=",cCode,"&grant_type=authorization_code&language=en-us")

#base 64 encoding
b64encoded <- base64_encode(paste0(cKey,":",cSecret))
b64encoded

#CURL example
h <- new_handle()
handle_setheaders(h, "client_id" = "abcdefghijklmnopqrstuvwxyz")
handle_setopt(h, )

URLReq <- paste0(accessURL,"?client_id=",cKey,"&client_secret=",cSecret,"&code=",cCode,"&grant_type=authorization_code")

r <- curl_fetch_memory(URLReq, h)
URLReq
r

h

##
#r <- POST(URLReq, body = "a simple")
#r
#stop_for_status(r)
#content(r)
##
