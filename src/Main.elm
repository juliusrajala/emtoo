module Main exposing (..)

import Html exposing (Html, text, div, h1, h2, img, button)
import Html.Attributes exposing (src, class)
import Html.Events exposing(onClick)
-- import Navigation


---- MODEL ----
type alias Model =
  { clickSum: Int
  , clickCount: Int
  , visibleView: View
  }

model =
  { clickSum = 0
  , clickCount = 0
  , visibleView = FirstForm
  }

init : Model -> ( Model, Cmd Msg )
init model =
  ( model, Cmd.none )

---- UPDATE ----

type View
  = Receipts
  | FirstForm
  | SecondForm
  | FormSubmit

type Msg
  = Increment
  | Decrement
  | SetView

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
      ( { model
        | clickSum = model.clickSum - 1
        , clickCount = model.clickCount + 1
        }
      , Cmd.none
      )
    SetView viewType ->
      ( { model | visibleView = viewType }
      , Cmd.none
      )

viewSelector model =
  let
    viewType = model.visibleView
  in
    case viewType of
      FirstForm ->
        firstForm model
      SecondForm ->
        firstForm model
      FormSubmit ->
        firstForm model
      

---- VIEW ----

view : Model -> Html Msg
view model =
  div []
    [ img [ src "/logo.svg" ] []
    , h1 [] [ text "Click to increment" ]
    , h2 [] [ text ("Sum is " ++ (toString model.clickSum)) ]
    , h2 [] [ text ("With " ++ (toString model.clickCount) ++ " clicks") ]
    ]

firstForm : Model -> Html msg
firstForm model =
  div []
    [ h1 [] [ text "First Form" ]
    , myButton "Next" (SetView SecondForm)
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
