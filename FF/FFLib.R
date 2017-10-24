library("httr")
library("jsonlite")

InitYahooEnv <- function()
{
    FantasyRelm <<- '371'
    LeagueID <<- '272272'
    MyTeamNumber <<- 7

    mycKey <- "dj0yJmk9dm4yTW9oamVGTFhnJmQ9WVdrOWR6RjVUWEJZTjJzbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00Yg--" 
    mycSecret <- "1b72efee9f73e2b64270cbd2a908873da8ddd04a" 

    yahoo_token <<- YahooAuth(mycKey, mycSecret)
}

InitLeague <- function()
{
    leagueKey <<- paste0(FantasyRelm, '.l.', 272272)
}

TeamKey <- function(TeamID)
{
    return( paste0(leagueKey, ".t.", TeamID)  )
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

YahooTeam <- function(teamNum)
{
    teamKey <- TeamKey(teamNum)

    u <- paste0("https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.teams%20where%20team_key%3D'", teamKey, "'&format=json&diagnostics=true&callback=")

    teams <- YahooGetData(u, yahoo_token)

    mylist <- teams$query$results$team
    
    return(mylist)
}

YahooTeamRoster <- function(teamNum)
{
    teamKey <- TeamKey(teamNum)

    u <- paste0("https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.teams.roster%20where%20team_key%3D'", teamKey, "'&format=json&diagnostics=true&callback=")

    roster <- YahooGetData(u, yahoo_token)

    players <- roster$query$results$team$roster$players$player

    return(players)
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

LeagueStats <- function(inWeek)
{
    u <- paste0("https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.players.stats%20where%20league_key%3D'", leagueKey,"'%20and%20stats_week%3D",inWeek,"%20and%20stats_type='week'&format=json&diagnostics=true&callback=")

    playerstats <- YahooGetData(u, yahoo_token)

    return(playerstats$query$results$player)

    players <- roster$query$results$team$roster$players$player
    c1 <- c(players[c("player_key","editorial_team_full_name", "display_position")], players$name[1])
    c1.df <- as.data.frame(c1)

    return(c1)
}

YahooAllPlayers <- function(start)
{
#    u <- paste0("http://fantasysports.yahooapis.com/fantasy/v2/league/", leagueKey, "/players")
     u <- paste0("https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.players%20where%20league_key%3D'", leagueKey,"'%20and%20start%3D", start, "&format=json&diagnostics=true&callback=")

    players <- YahooGetData(u, yahoo_token)

    return(players$query$results$player)    
}

lut <- c("RB"="R/|RB", "WR"="w/|WR", "TE"="/T|TE", "K"="K", "QB"="QB")

YahooAllPlayersAtPosition <- function(position)
{
    df <- data.frame()

    for(i in seq(1,1000,25))
    {
        ap <- YahooAllPlayers(i)
        apd <- as.data.frame(c(ap$name[1], ap[c("player_key","bye_weeks","display_position", "eligible_positions")]))
  #      apd <- as.data.frame(c(ap$name[1], ap[c("player_key","bye_weeks","display_position", "eligible_positions")], ap$eligible_positions))
  #      apd <- as.data.frame(c(ap$name[1], ap[c(1,8)], ap$eligible_positions))

        df <- rbind(df, apd)
    }

    df[c(grep("R/|RB", df$position)),]
    df[c(grep("DEF", df$position)),]


    apd <- as.data.frame(c(ap[c(1,8,10,15)],ap$name[1]))
}

LeagueSettings <- function()
{
    u <- paste0("https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.leagues.settings%20where%20league_key%3D'", leagueKey,"'&format=json&diagnostics=true&callback=")

    leageSettings <- YahooGetData(u, yahoo_token)

    return(leageSettings$query$results$league)    
}