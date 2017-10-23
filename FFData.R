GetStats <- function(leagueSettings)
{
    return(leagueSettings$settings$stat_categories$stats$stat[c("stat_id", "name", "position_type")])
}

GetPlayers <- function(players)
{
    r <- c(players[c("player_key", "display_position", "status" )], players$name[1])
    return(r)
}