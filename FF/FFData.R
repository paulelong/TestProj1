InitEnv <- function(team)
{
    TeamNum <<- team
    options(width=150)
}

GetStats <- function(leagueSettings)
{
    return(leagueSettings$settings$stat_categories$stats$stat[c("stat_id", "name", "position_type")])
}

GetPlayers <- function(players)
{
    r <- c(players[c("player_key", "display_position", "status" )], players$name[1])

    return(r)
}

GetTeam <- function(teamNum)
{
    curTeam <- YahooTeam(teamNum)

    return( as.data.frame(c( curTeam$managers$manager$nickname, curTeam["name"]) ) )
}

GetTeamRoster <- function(teamNum)
{
    players <- YahooTeamRoster(teamNum)
    c1 <- c(players$name[1], players[c("player_key","editorial_team_full_name", "display_position", "eligible_positions")])
    c1.df <- as.data.frame(c1)

    return(c1.df)
}

GetAllOwnedPlayers <- function()
{
    aop <- list()

    for(i in 1:12)
    { 
        t <- GetTeamRoster(i) 
        
        aop[[i]] <- t
    }

    return(aop)
}

GetAvailablePlayersAtPosition <- function(position)
{
    return (YahooAllPlayersAtPosition(position))
}
