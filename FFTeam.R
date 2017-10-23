source(file="FFLib.R")
source(file="FFData.R")

InitEnv()

InitLeague()

Teams()
Roster()
ps <- PlayerStats("371.p.29236", 3)
lset <- LeagueSettings()
GetPlayerKey(332)

cpl <- apply(cbind(p1,p2), 1, unlist)

pl <- AllPlayers(44)
p1 <- GetPlayers(pl)
pl1 <- AllPlayers(1)
p2 <- GetPlayers(pl1)
ap <- AllPlayers()

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

yahoo_token = YahooAuth()
p1 <- YahooGetData(URL.player, yahoo_token)

URL.player.stats = "https://query.yahooapis.com/v1/yql?q=select%20*%20from%20fantasysports.players.stats%20where%20league_key%3D'371.l.272272'%20and%20player_key%3D'371.p.29236'%20and%20stats_week%3D1&format=json&diagnostics=true&callback="
ps1 <- YahooGetData(URL.player.stats, yahoo_token)
pstats <- ps1$query$results$player

#https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20fantasysports.teams.stats%20where%20team_key%3D'238.l.627060.t.8'%20and%20stats_type%3D'date'%20and%20stats_date%3D'2010-05-14'&format=json&diagnostics=true&callback=