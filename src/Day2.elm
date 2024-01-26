-- https://adventofcode.com/2023/day/2
module Day2 exposing (main)

import Html exposing (Html)

main : Html msg
main =
  calibrationInput
  |> String.trim
  |> String.lines
  |> parseGames
  |> setMaximums
  |> validateGames
  |> sumValidGames 
  |> Debug.toString
  |> Html.text

type Colour = Blue | Red | Green 

type alias Game = 
  { id : Int
  , draws : List (Int, Colour)
  , maxGreen : Int
  , maxRed : Int
  , maxBlue : Int
  }

parseGames : List String -> List Game
parseGames games =
  List.map parseGame games

parseGame : String -> Game
parseGame game =
  let
    id = List.head(String.split ":" game)
         |> (Maybe.withDefault "")
         |> String.filter Char.isDigit
         |> String.toInt
         |> (Maybe.withDefault 0)
    draws = List.tail(String.split ":" game)
            |> (Maybe.withDefault [""])
            |> List.head
            |> (Maybe.withDefault "")
            -- It doesn't matter which game the draw was in
            |> (String.replace "," ";")
            |> String.split ";"
            |> (List.map parseDraw)
  in
    Game id draws 0 0 0

parseDraw : String -> (Int, Colour)
-- Converts "3 blue" to (3, Blue)
parseDraw draw =
  let
    num = String.filter Char.isDigit draw
          |> String.toInt
          |> (Maybe.withDefault 0)
    isBlue = String.contains "blue" draw
    isGreen = String.contains "green" draw
    isRed = String.contains "red" draw
    colour = if isBlue then
               Blue
             else if isGreen then
               Green
             else if isRed then
               Red
             else
               Red
  in
    (num, colour)


setMaximums : List Game -> List Game
setMaximums games =
  List.map setMaximum games

setMaximum : Game -> Game
setMaximum game =
  let
    green = getMaxColour Green game.draws
    blue = getMaxColour Blue game.draws
    red = getMaxColour Red game.draws
  in
    { game | maxGreen = green, maxRed = red, maxBlue = blue }

getMaxColour : Colour -> List (Int, Colour) -> Int
getMaxColour colour draws =
  List.filter (\(_, y) -> y == colour) draws
    -- Sort list by value
    |> List.sortBy (\(x, _) -> x)
    -- Reverse to get the highest value
    |> List.reverse
    |> List.head
    |> Maybe.withDefault(0, Green)
    |> Tuple.first

validateGames : List Game -> List Game
validateGames games =
  List.filter (\x -> (x.maxGreen <= greenLimit)) games
  |> List.filter (\x -> (x.maxRed <= redLimit))
  |> List.filter (\x -> (x.maxBlue <= blueLimit))


sumValidGames : List Game -> Int
sumValidGames games =
  List.map (\x -> x.id) games
  |> List.sum


calibrationInput : String
calibrationInput = """

Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

"""

redLimit : Int
redLimit = 12 
greenLimit : Int
greenLimit = 13 
blueLimit : Int
blueLimit = 14