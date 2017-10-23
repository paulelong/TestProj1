realnumber <- sample(0:19,1)

for(i in 1:5)
{
    g <- readline("please choose a number from 0 to 19: ")
    g <- as.integer(g)
    
    if (g == realnumber)
    {
        print("You got it right!!!")
        break
    } else {
        if(g < realnumber)
        {
            print("Oooh, so close!  Maybe you should try higher.")
        } else {
            print("Oooh, so close!  Maybe you should try lower.")            
        }
    }

    computerGuess <- sample(0:19,1)
    print(paste0("Computer guesses ", computerGuess))
    if(computerGuess == realnumber)
    {
        print("Opponent got it right, so sorry")
        break
    }
}

if(g != realnumber)
{
    print(paste0("The number was ", realnumber))
}

