{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE Safe              #-}

module Lemmata.Semiring (
  Semiring(..),
  zero,
) where

import           Data.Monoid

-- | Alias for 'mempty'
zero :: Monoid m => m
zero = mempty

class Monoid m => Semiring m where
  {-# MINIMAL one, (<.>) #-}

  one :: m
  (<.>) :: m -> m -> m
