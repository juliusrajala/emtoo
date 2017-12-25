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

model : { clickCount : Int, clickSum : Int, visibleView : View }
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
  = SetView (View)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SetView (viewType) ->
      ( { model | visibleView = viewType }
      , Cmd.none
      )

viewSelector : { clickCount : Int, clickSum : Int, visibleView : View } -> Html Msg
viewSelector model =
  let
    viewType = model.visibleView
  in
    case viewType of
      FirstForm ->
        firstForm model
      SecondForm ->
        secondForm model
      FormSubmit ->
        formSubmit model
      Receipts ->
        firstForm model

---- VIEW ----

layout : Model -> Html Msg
layout model =
  div [ class "EmtooLayout" ]
    [ appHeader
    , viewSelector model
    ]


-- Pages
firstForm : Model -> Html Msg
firstForm model =
  div []
    [ h1 [] [ text "First Form" ]
    , myButton "Next" (SetView SecondForm)
    ]

secondForm : Model -> Html Msg
secondForm model =
  div []
    [ h1 [] [ text "Second Form" ]
    , myButton "Previous" (SetView FirstForm)
    , myButton "Next" (SetView FormSubmit)
    ]

formSubmit : Model -> Html Msg
formSubmit model =
  div []
    [ h1 [] [ text "Submit Form" ]
    , myButton "Previous" (SetView SecondForm)
    , myButton "New" (SetView FirstForm)
    ]


-- Components

appHeader : Html Msg
appHeader =
  div [ class "AppHeader" ]
    [ img 
      [ src "https://placehold.it/60x60"
      , class "AppHeader-logo"
      ] []
    , h1 [ class "AppHeader-title" ] [ text "Em2" ]
    ]

myButton : String -> msg -> Html msg
myButton label action =
  button
    [ class "EmtooButton"
    , onClick action
    ]
    [ text label ]


---- PROGRAM ----

main : Program Never Model Msg
main =
  Html.program
    { view = layout
    , init = init model
    , update = update
    , subscriptions = always Sub.none
    }
