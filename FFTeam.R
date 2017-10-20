library(httr)
library("jsonlite")

leageKey <- '371.l.272272'

cKey <- "dj0yJmk9dm4yTW9oamVGTFhnJmQ9WVdrOWR6RjVUWEJZTjJzbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00Yg--" 
cSecret <- "1b72efee9f73e2b64270cbd2a908873da8ddd04a" 

YahooAuth <- function()
{
    y.app <- oauth_app("yahoo.teams", key=cKey, secret=cSecret, redirect_uri = "oob")

    new_token <- oauth1.0_token(oauth_endpoints("yahoo"), y.app)

    return(new_token)
}

YahooGetData <- function(url, myToken)
{
    resp <- GET(url, config(token = myToken))

    j <- content(resp, as = "text")

    info <- fromJSON(j)

    return(info)
}


u <- "https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.teams%20where%20team_key%3D'371.l.272272.t.8'&format=json&diagnostics=true&callback="


mylist <- info$query$results$team

t1 <- mylist[c(3,6,7,8,9,14)]

t1

URL.team.roster <- "https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.teams.roster%20where%20team_key%3D'371.l.272272.t.8'&format=json&diagnostics=true&callback="

resp <- GET(URL.team.roster , config(token = yahoo_token))
roster.info = fromJSON(content(resp, as = "text"))
roster.info

players <- roster.info$query$results$team$roster$players$player
c1 <- c(players[c("player_key","editorial_team_full_name", "display_position", "status_full")], players$name[1])
c1.df <- as.data.frame(c1)

URL.player <- "https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.players%20where%20player_key%3D'371.p.29236'&format=json&diagnostics=true&callback="

p1 <- YahooGetData(URL.player, yahoo_token)