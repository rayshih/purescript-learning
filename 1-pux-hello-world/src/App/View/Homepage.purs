module App.View.Homepage where

import App.Events (Event)
import App.State (State(..))
import Data.Function (($))
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (a, div, h1)
import Text.Smolder.HTML.Attributes (href)
import Text.Smolder.Markup ((!), text)

view :: State -> HTML Event
view _ =
  text "Hello World"
