module Main exposing (..)

import Html exposing (Html, text, div, h1, h2, img, button)
import Html.Attributes exposing (src, class)
import Html.Events exposing(onClick)


---- MODEL ----
type alias Model =
    { clickSum: Int
    , clickCount: Int
    }

model =
    { clickSum = 0
    , clickCount = 0
    }

init : Model -> ( Model, Cmd Msg )
init model =
    ( model, Cmd.none )

---- UPDATE ----

type Msg
    = Increment
    | Decrement

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            (
                { model
                | clickSum = model.clickSum + 1
                , clickCount = model.clickCount + 1
                }
                , Cmd.none
            )
        Decrement ->
            (
                { model
                | clickSum = model.clickSum - 1
                , clickCount = model.clickCount + 1
                }
                , Cmd.none
            )

---- VIEW ----

view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Click to increment" ]
        , h2 [] [ text ("Sum is " ++ (toString model.clickSum)) ]
        , h2 [] [ text ("With " ++ (toString model.clickCount) ++ " clicks") ]
        ]

-- mybutton : String -> Html Msg
mybutton label action =
        button
            [ class "EmtooButton"
            , onClick action
            ]
            [ text label ]

layout : Model -> Html Msg
layout model =
    div [ class "EmtooLayout" ]
        [ div [ class "EmtooHeader" ] []
        , view model
        , mybutton "Plus" Increment
        , mybutton "Minus" Decrement
        ]


---- PROGRAM ----

main : Program Never Model Msg
main =
    Html.program
        { view = layout
        , init = init model
        , update = update
        , subscriptions = always Sub.none
        }
