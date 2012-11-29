{-# LANGUAGE DeriveDataTypeable #-}

module Application.RegisterStatus.ProgType where 

import System.Console.CmdArgs

newtype Name = Name String 

data Regstat = Arch { regname :: String } 
             | Ubuntu { regname :: String } 
              deriving (Show,Data,Typeable)

arch :: Regstat
arch = Arch { regname = "" &= typ "NAME" &= argPos 0 } 

ubuntu :: Regstat
ubuntu = Ubuntu { regname = "" &= typ "NAME" &= argPos 0 } 

mode = modes [arch, ubuntu]

