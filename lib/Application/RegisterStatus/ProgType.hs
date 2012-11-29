{-# LANGUAGE DeriveDataTypeable #-}

module Application.RegisterStatus.ProgType where 

import System.Console.CmdArgs

newtype Name = Name String 

data Regstat = Arch { regname :: String } 
             | Ubuntu { regname :: String }
             | ArchBlue { regname :: String } 
             | UbuntuBlue { regname :: String } 
             | Synergys 
             | Synergyc 
              deriving (Show,Data,Typeable)

arch :: Regstat
arch = Arch { regname = "" &= typ "NAME" &= argPos 0 } 

ubuntu :: Regstat
ubuntu = Ubuntu { regname = "" &= typ "NAME" &= argPos 0 } 

archblue :: Regstat
archblue = ArchBlue { regname = "" &= typ "NAME" &= argPos 0 } 

ubuntublue :: Regstat
ubuntublue = UbuntuBlue { regname = "" &= typ "NAME" &= argPos 0 } 

synergys :: Regstat
synergys = Synergys

synergyc :: Regstat 
synergyc = Synergyc


mode = modes [arch, ubuntu, archblue, ubuntublue, synergys, synergyc]

