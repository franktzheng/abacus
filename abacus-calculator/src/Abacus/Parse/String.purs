module Abacus.Parse.String
  ( codePointArray
  , decimalS
  , floatS
  , floatS'
  , integerS
  , naturalS
  , string
  , word
  ) where

import Prelude
import Abacus.Parse.Char (char, codePoint, digit, letter)
import Abacus.Parse.Parser (Parser, (<?>))
import Control.Alternative ((<|>))
import Control.Apply (lift2)
import Data.Array (some, (:))
import Data.String (CodePoint, toCodePointArray)
import Data.Traversable (sequence)

floatS :: Parser (Array CodePoint)
floatS = do
  n <- integerS
  d <- decimalS <|> string "." <|> pure mempty
  pure (n <> d) <?> "float"

-- | Same as `parseFloatS` but assumes leading 0 (i.e. .1234 is valid).
floatS' :: Parser (Array CodePoint)
floatS' = (floatS <|> decimalS) <?> "float"

-- | Parses a decimal point followed by digits.
decimalS :: Parser (Array CodePoint)
decimalS = lift2 (:) (char '.') naturalS <?> "decimal"

integerS :: Parser (Array CodePoint)
integerS = do
  sign <- string "-" <|> pure mempty
  n <- naturalS
  pure (sign <> n) <?> "integer"

naturalS :: Parser (Array CodePoint)
naturalS = some digit <?> "natural number"

word :: Parser (Array CodePoint)
word = some letter <?> "word"

-- | Parses an array of code points.
string :: String -> Parser (Array CodePoint)
string s = codePointArray (toCodePointArray s) <?> s

codePointArray :: Array CodePoint -> Parser (Array CodePoint)
codePointArray = sequence <<< map codePoint
