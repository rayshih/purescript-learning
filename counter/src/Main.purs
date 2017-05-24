module Main where

import Prelude hiding (div)

import Control.Monad.Eff (Eff)
import Pux (CoreEffects, EffModel, start)
import Pux.Renderer.React (renderToDOM)
import Pux.DOM.HTML (HTML)
import Pux.DOM.Events (onClick, DOMEvent)
import Text.Smolder.HTML (div, button)
import Text.Smolder.Markup (text, (#!))
import Data.Array (snoc, modifyAt, mapWithIndex)
import Data.Foldable (for_)
import Data.Maybe (fromMaybe)
import Data.Tuple (Tuple(..))

newtype Idx = Idx Int

data Event = Increment Idx
           | Decrement Idx
           | NewCounter

type State = Array Int

incr :: Idx -> DOMEvent -> Event
incr = const <<< Increment

desc :: Idx -> DOMEvent -> Event
desc = const <<< Decrement

counter :: Idx -> Int -> HTML Event
counter idx c =
  div do
    button #! onClick (incr idx) $ text "Increment"
    text $ show c
    button #! onClick (desc idx) $ text "Decrement"

view :: State -> HTML Event
view arr =
  div do
    div do
      for_ arrWithIndex $ \(Tuple c idx) -> counter idx c
    div do
      button #! onClick (const NewCounter) $ text "New Counter"

  where
    arrWithIndex = mapWithIndex (\n c -> Tuple c (Idx n)) arr

modifyAt' :: Idx -> (Int -> Int) -> Array Int -> Array Int
modifyAt' (Idx n) f arr = fromMaybe arr <<< modifyAt n f $ arr

incrAt :: Idx -> Array Int -> Array Int
incrAt idx = modifyAt' idx (_ + 1)

descAt :: Idx -> Array Int -> Array Int
descAt idx = modifyAt' idx (_ - 1)

foldp :: forall fx. Event -> State -> EffModel State Event fx
foldp (Increment idx) state = { state: incrAt idx state    , effects: [] }
foldp (Decrement idx) state = { state: descAt idx state    , effects: [] }
foldp NewCounter state      = { state: (snoc state 0)      , effects: [] }

main :: forall fx. Eff (CoreEffects fx) Unit
main = do
  app <- start
    { initialState: []
    , view
    , foldp
    , inputs: []
    }

  renderToDOM "#app" app.markup app.input
