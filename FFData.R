GetStats <- function(leagueSettings)
{
    return(leagueSettings$settings$stat_categories$stats$stat[c("stat_id", "name", "position_type")])
}

GetPlayers <- function(players)
{
    return(c(players$name[1], players[c("display_position", "status" )]))
}