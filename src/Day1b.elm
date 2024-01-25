-- https://adventofcode.com/2023/day/1

module Day1b exposing (main)

import Html exposing (Html)

main : Html msg
main = 
    calibrationInput
    |> String.trim            -- String
    |> String.lines           -- List String
    |> getValues              -- List (Int, Int)
    |> Debug.toString
    |> Html.text
    
getValues : List String -> List (List (Int, Int))
-- Returns the first and last number in each line concatenated
getValues lines = 
    List.map getFirstAndLastNumber lines

getFirstAndLastNumber : String -> List (Int, Int)
getFirstAndLastNumber line =
    line
    |> getNumberIndexes
    |> sortByFirst


getNumberIndexes : String -> List (Int, Int)
-- Output the index of each named number and integer appearance in the string
-- e.g. (0, 1), (2, 3), (4, 5) (4, 6)
-- means at the 0 index there's a 1, at the 2 index there's a 3, etc
getNumberIndexes line =
    [(0, 1), (1, 2)]
    -- (1, List.map (String.indexes "one") line)
    -- ++ (2, List.map (String.indexes "two") line)
    -- ++ (3, List.map (String.indexes "three") line)

sortBy : (a -> comparable) -> List a -> List a
sortBy f lst =
    List.sortWith (\a b -> compare (f a) (f b)) lst
    
sortByFirst : List (comparable, b) -> List (comparable, b)
sortByFirst =
    sortBy Tuple.first   

numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]


calibrationInput = """

two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen

"""