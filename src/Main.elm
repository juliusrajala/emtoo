module Main exposing (..)

import Html exposing (Html, text, div, h1, h2, img, button)
import Html.Attributes exposing (src, class)
-- import Html.Events exposing(onClick)


---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----

type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----

view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , h2 [] [ text "But is it still working?" ]
        ]

mybutton label =
        button [ class "EmtooButton" ] [ text label ]

layout : Model -> Html Msg
layout model =
    div [ class "EmtooLayout" ]
        [ div [ class "EmtooHeader" ] []
        , view model
        , mybutton "Test"
        ]


---- PROGRAM ----

main : Program Never Model Msg
main =
    Html.program
        { view = layout
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
