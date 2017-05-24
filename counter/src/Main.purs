module Main where

import Prelude hiding (div)

import Control.Monad.Eff (Eff)
import Pux (CoreEffects, EffModel, start)
import Pux.Renderer.React (renderToDOM)
import Pux.DOM.HTML (HTML)
import Pux.DOM.Events (onClick, DOMEvent)
import Text.Smolder.HTML (div, button)
import Text.Smolder.Markup (text, (#!))
import Data.Array (snoc, modifyAt, zip, (..), length)
import Data.Foldable (for_)
import Data.Maybe (fromMaybe)
import Data.Tuple (Tuple(..))

data Event = Increment Int
           | Decrement Int
           | NewCounter

type State = Array Int

incr :: Int -> DOMEvent -> Event
incr = const <<< Increment

desc :: Int -> DOMEvent -> Event
desc = const <<< Decrement

counter :: Int -> Int -> HTML Event
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
    arrWithIndex = zip arr (0 .. (length arr - 1))

modifyAt' :: Int -> (Int -> Int) -> Array Int -> Array Int
modifyAt' idx f arr = fromMaybe arr <<< modifyAt idx f $ arr

incrAt :: Int -> Array Int -> Array Int
incrAt idx = modifyAt' idx (_ + 1)

descAt :: Int -> Array Int -> Array Int
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
