{-# LANGUAGE DeriveDataTypeable #-}

module Application.RegisterStatus.ProgType where 

import System.Console.CmdArgs

newtype Name = Name String 

data Regstat = Arch { regname :: String } 
             | Ubuntu { regname :: String }
             | IMac { regname :: String } 
             | ArchBlue { regname :: String } 
             | UbuntuBlue { regname :: String } 
             | Synergys 
             | Synergyc { regname :: String } 
              deriving (Show,Data,Typeable)

arch :: Regstat
arch = Arch { regname = "" &= typ "NAME" &= argPos 0 } 

ubuntu :: Regstat
ubuntu = Ubuntu { regname = "" &= typ "NAME" &= argPos 0 } 

imac :: Regstat
imac = IMac { regname = "" &= typ "NAME" &= argPos 0 } 

archblue :: Regstat
archblue = ArchBlue { regname = "" &= typ "NAME" &= argPos 0 } 

ubuntublue :: Regstat
ubuntublue = UbuntuBlue { regname = "" &= typ "NAME" &= argPos 0 } 

synergys :: Regstat
synergys = Synergys

synergyc :: Regstat 
synergyc = Synergyc { regname = "" &= typ "NAME" &= argPos 0 } 


mode = modes [arch, ubuntu, imac, archblue, ubuntublue, synergys, synergyc]

