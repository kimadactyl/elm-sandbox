-- https://adventofcode.com/2023/day/1

module Day1 exposing (main)

import Html exposing (Html)

main : Html msg
main = 
    calibrationInput
    |> String.trim            -- String
    |> String.lines           -- List String
    |> getValues              -- List (List Int)
    |> List.sum
    |> Debug.toString
    |> Html.text
    
getValues : List String -> List Int
getValues lines = 
    List.map getFirstAndLastNumber lines

getFirstAndLastNumber : String -> Int
getFirstAndLastNumber line =
    line
    |> String.filter Char.isDigit
    |> (\nums -> (String.left 1 nums) ++ (String.right 1 nums))
    |> String.toInt
    |> (Maybe.withDefault 0)

-- Input
calibrationInput = """

1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet

"""