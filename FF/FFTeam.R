source(file="FFLib.R")
source(file="FFData.R")

InitEnv(7)

InitYahooEnv()

InitLeague()

aop <- GetAllOwnedPlayers()
aop

YahooAllPlayerStatsAtPosition("TE", 3)

GetTeamRoster(7)

Teams()
Roster()

ps <- YahooPlayerStats("371.p.25812", 3)
si <- YahooLeagueStatInfo()

lset <- LeagueSettings()
GetPlayerKey(332)

cpl <- apply(cbind(p1,p2), 1, unlist)
rbind(p1d, p2d) #pld[1], #pld[1,]
rd[rd$full == "Tony Romo",]

df[nrow(df),] # get the last row
lf = as.list(df)
lf[[1]] # get first row...

pl2 <- AllPlayers(44)
p1 <- GetPlayers(pl)
pl1 <- AllPlayers(1)
p2 <- GetPlayers(pl1)
ap <- YahooAllPlayers(1)



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