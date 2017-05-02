{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE FlexibleContexts     #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE NoImplicitPrelude    #-}
{-# LANGUAGE Trustworthy          #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Lemmata.Show (
  Print(..),
  putText,
  putLText,
  putByteString,
  putLByteString,
) where

import           Data.Function              ((.))
import qualified Lemmata.Base               as Base

import           Control.Monad.IO.Class     (MonadIO, liftIO)
import qualified Data.ByteString.Char8      as BS
import qualified Data.ByteString.Lazy.Char8 as BL

import qualified Data.Text                  as T
import qualified Data.Text.IO               as T

import qualified Data.Text.Lazy             as TL
import qualified Data.Text.Lazy.IO          as TL


class Print a where
  putStr :: MonadIO m => a -> m ()
  putStrLn :: MonadIO m => a -> m ()

instance Print T.Text where
  putStr = liftIO . T.putStr
  putStrLn = liftIO . T.putStrLn

instance Print TL.Text where
  putStr = liftIO . TL.putStr
  putStrLn = liftIO . TL.putStrLn

instance Print BS.ByteString where
  putStr = liftIO . BS.putStr
  putStrLn = liftIO . BS.putStrLn

instance Print BL.ByteString where
  putStr = liftIO . BL.putStr
  putStrLn = liftIO . BL.putStrLn

instance Print [Base.Char] where
  putStr = liftIO . Base.putStr
  putStrLn = liftIO . Base.putStrLn

-- For forcing type inference
putText :: MonadIO m => T.Text -> m ()
putText = putStrLn
{-# SPECIALIZE putText :: T.Text -> Base.IO () #-}

putLText :: MonadIO m => TL.Text -> m ()
putLText = putStrLn
{-# SPECIALIZE putLText :: TL.Text -> Base.IO () #-}

putByteString :: MonadIO m => BS.ByteString -> m ()
putByteString = putStrLn
{-# SPECIALIZE putByteString :: BS.ByteString -> Base.IO () #-}

putLByteString :: MonadIO m => BL.ByteString -> m ()
putLByteString = putStrLn
{-# SPECIALIZE putLByteString :: BL.ByteString -> Base.IO () #-}
