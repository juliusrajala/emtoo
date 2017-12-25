module Main exposing (..)

import Html exposing (Html, text, div, h1, h2, img, input, button, textarea, form)
import Html.Attributes exposing (src, class, placeholder)
import Html.Events exposing(onClick, onInput)
-- import Navigation


---- MODEL ----
type alias Model =
  { clickSum: Int
  , clickCount: Int
  , visibleView: View
  , currentReceipt: Receipt
  }

type alias Receipt =
  { receiptName : String
  , totalCost : Float
  , href : String
  , description : String
  , people : List String
  }

model : Model
model =
  { clickSum = 0
  , clickCount = 0
  , visibleView = FirstForm
  , currentReceipt = receiptItem
  }

receiptItem : Receipt
receiptItem =
  { receiptName = ""
  , totalCost = 0.0
  , href = ""
  , description = ""
  , people = []
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
  = SetView View
  | Description String
  | Name String

setDescription : String -> Model -> Model
setDescription value model =
  let
      oldReceipt = model.currentReceipt
      newReceipt = { oldReceipt | description = value }
  in
      { model | currentReceipt = newReceipt }

setName : String -> Model -> Model
setName value model =
  let
      oldReceipt = model.currentReceipt
      newReceipt = { oldReceipt | receiptName = value }
  in
      { model | currentReceipt = newReceipt }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SetView (viewType) ->
      ( { model | visibleView = viewType }
      , Cmd.none
      )
    Description description ->
      ( model |> setDescription description 
      , Cmd.none
      )
    Name name ->
      ( model |> setName name
      , Cmd.none
      )

viewSelector : Model -> Html Msg
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
  form [ class "EmtooForm" ]
    [ h1 [] [ text "First Form" ]
    , input 
      [ class "EmtooField"
      , placeholder "Name"
      , onInput Name
      ] []
    , textarea 
      [ class "EmtooField"
      , placeholder "Description"
      , onInput Description
      ] []
    , emtooButton "Next" (SetView SecondForm)
    ]

secondForm : Model -> Html Msg
secondForm model =
  div []
    [ h1 [] [ text "Second Form" ]
    , emtooButton "Previous" (SetView FirstForm)
    , emtooButton "Next" (SetView FormSubmit)
    ]

formSubmit : Model -> Html Msg
formSubmit model =
  div []
    [ h1 [] [ text "Submit Form" ]
    , emtooButton "Previous" (SetView SecondForm)
    , emtooButton "New" (SetView FirstForm)
    ]

-- Components
appHeader : Html Msg
appHeader =
  div [ class "AppHeader" ]
    [ img 
      [ src "https://placehold.it/60x60"
      , class "AppHeader-logo"
      ] []
    , h1 [ class "AppHeader-title" ] [ text "EmToo" ]
    ]

emtooButton : String -> msg -> Html msg
emtooButton label action =
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
