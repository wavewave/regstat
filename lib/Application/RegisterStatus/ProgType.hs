{-# LANGUAGE DeriveDataTypeable #-}

module Application.RegisterStatus.ProgType where 

import System.Console.CmdArgs

data Regstat = Arch 
             | Ubuntu 
              deriving (Show,Data,Typeable)

arch :: Regstat
arch = Arch

ubuntu :: Regstat
ubuntu = Ubuntu 

mode = modes [arch, ubuntu]

