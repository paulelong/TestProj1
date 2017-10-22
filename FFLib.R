library("httr")
library("jsonlite")

InitEnv <- function()
{
    FantasyRelm <<- '371'
    LeagueID <<- '272272'
    TeamNumber <<- 8

    mycKey <- "dj0yJmk9dm4yTW9oamVGTFhnJmQ9WVdrOWR6RjVUWEJZTjJzbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00Yg--" 
    mycSecret <- "1b72efee9f73e2b64270cbd2a908873da8ddd04a" 

    yahoo_token <<- YahooAuth(mycKey, mycSecret)
}

InitLeague <- function()
{
    leagueKey <<- paste0(FantasyRelm, '.l.', 272272)
    teamKey <<- paste0(leagueKey, ".t.", TeamNumber)
}

GetPlayerKey <- function(pid)
{
    return(paste0(FantasyRelm, '.p.', pid))
}


YahooAuth <- function(cKey, cSecret)
{
    y.app <- oauth_app("yahoo.teams", key=cKey, secret=cSecret, redirect_uri = "oob")

    new_token <- oauth1.0_token(oauth_endpoints("yahoo"), y.app, cache=FALSE)

    return(new_token)
}

YahooGetData <- function(url, myToken)
{
    resp <- GET(url, config(token = myToken))

    j <- content(resp, as = "text")

    if(resp$status != 200)
    {
        print(resp$status)
        print(j)
        return(NULL)
    }

    info <- fromJSON(j)

    return(info)
}

Teams <- function()
{
    u <- paste0("https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.teams%20where%20team_key%3D'", teamKey, "'&format=json&diagnostics=true&callback=")

    teams <- YahooGetData(u, yahoo_token)

    mylist <- teams$query$results$team
    
    t1 <- mylist[c(3,6,7,8,9,14)]

    return(t1)
}

Roster <- function()
{
    u <- paste0("https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.teams.roster%20where%20team_key%3D'", teamKey, "'&format=json&diagnostics=true&callback=")

    roster <- YahooGetData(u, yahoo_token)

    players <- roster$query$results$team$roster$players$player
    c1 <- c(players[c("player_key","editorial_team_full_name", "display_position")], players$name[1])
    c1.df <- as.data.frame(c1)

    return(c1)
}

PlayerStats <- function(player_key, inWeek)
{
    u <- paste0("https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.players.stats%20where%20league_key%3D'", leagueKey,"'%20and%20player_key%3D'", player_key, "'%20and%20stats_week%3D",inWeek,"%20and%20stats_type='week'&format=json&diagnostics=true&callback=")

    playerstats <- YahooGetData(u, yahoo_token)

    return(playerstats)

    players <- roster$query$results$team$roster$players$player
    c1 <- c(players[c("player_key","editorial_team_full_name", "display_position")], players$name[1])
    c1.df <- as.data.frame(c1)

    return(c1)
}

AllPlayers <- function()
{
#    u <- paste0("http://fantasysports.yahooapis.com/fantasy/v2/league/", leagueKey, "/players")
    u <- paste0("https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.players%20where%20league_key%3D'", leagueKey,"'&count=99&format=json&diagnostics=true&callback=")

    players <- YahooGetData(u, yahoo_token)

    return(players$query$results$player)    
}

LeagueSettings <- function()
{
    u <- paste0("https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.leagues.settings%20where%20league_key%3D'", leagueKey,"'&format=json&diagnostics=true&callback=")

    leageSettings <- YahooGetData(u, yahoo_token)

    return(leageSettings$query$results$league)    
}