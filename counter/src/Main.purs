module Main where

import Prelude hiding (div)

import Control.Monad.Eff (Eff)
import Pux (CoreEffects, EffModel, start)
import Pux.Renderer.React (renderToDOM)
import Pux.DOM.HTML (HTML)
import Pux.DOM.Events (onClick)
import Text.Smolder.HTML (div, button)
import Text.Smolder.Markup (text, (#!))

data Event = Increment | Decrement

type State = Int

view :: State -> HTML Event
view count =
  div do
    button #! onClick (const Increment) $ text "Increment"
    text $ show count
    button #! onClick (const Decrement) $ text "Decrement"

foldp :: forall fx. Event -> State -> EffModel State Event fx
foldp Increment state = { state: state + 1, effects: [] }
foldp Decrement state = { state: state - 1, effects: [] }

main :: forall fx. Eff (CoreEffects fx) Unit
main = do
  app <- start
    { initialState: 0
    , view
    , foldp
    , inputs: []
    }

  renderToDOM "#app" app.markup app.input
