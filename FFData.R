GetStats <- function(leagueSettings)
{
    return(leagueSettings$settings$stat_categories$stats$stat[c("stat_id", "name", "position_type")])
}

GetPlayers <- function(players)
{
    return(players[players$name[1], c("display_position", "status" )])
}