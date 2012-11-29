{-# LANGUAGE DeriveDataTypeable #-}

module Application.RegisterStatus.ProgType where 

import System.Console.CmdArgs

newtype Name = Name String 

data Regstat = Arch { regname :: String } 
             | Ubuntu { regname :: String }
             | Synergys 
             | Synergyc 
              deriving (Show,Data,Typeable)

arch :: Regstat
arch = Arch { regname = "" &= typ "NAME" &= argPos 0 } 

ubuntu :: Regstat
ubuntu = Ubuntu { regname = "" &= typ "NAME" &= argPos 0 } 

synergys :: Regstat
synergys = Synergys

synergyc :: Regstat 
synergyc = Synergyc


mode = modes [arch, ubuntu, synergys, synergyc]

