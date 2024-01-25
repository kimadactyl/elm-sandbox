module Day2 exposing (main)

import Html exposing (Html)

main : Html msg
main =
  calibrationInput
  |> String.trim
  |> String.lines
  |> parseGames
  |> Debug.toString
  |> Html.text

type Colour = Blue | Red | Green 

type alias Game = 
  { id : Int
  , draws : List (Int, Colour)
  }

parseGames : List String -> List Game
parseGames = 
  [Game { id = 1
          , draws = [(3, Blue), (4, Red), (1, Red)]
        }
   , Game { id = 2
          , draws = [(1, Blue), (2, Green), (3, Green)]
          }
  ]

calibrationInput : String
calibrationInput = """

Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

"""