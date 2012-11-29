{-# LANGUAGE ScopedTypeVariables, OverloadedStrings #-}

module Application.RegisterStatus.Job where

import Control.Applicative
import Control.Monad.Trans
import Control.Monad.Trans.Maybe 
import Data.Aeson.Types 
import Data.Char
import Data.Configurator 
import qualified Data.HashMap.Strict as HM 
import Data.List.Split 
import qualified Data.Text as T
import Network.HTTP.Types
import System.Directory 
import System.Environment
import System.FilePath
import System.Process 
import Text.StringTemplate
import Text.StringTemplate.Helpers
-- 
import Application.KVStore.Client.Config
import Application.KVStore.Client.Job
-- 
import Application.RegisterStatus.ProgType 
-- 
import Paths_regstat

getDotRegstat :: IO String 
getDotRegstat = (</>) <$> (getEnv "HOME") <*> pure  ".regstat"

registerIP :: String -> String -> IO () 
registerIP k v = do 
    dotregstat <- getDotRegstat 
    system ( "kvstore-client put " ++ k ++ " " ++ v ++ " --config="++dotregstat)
    return ()

getIP :: String -> IO (Maybe String) 
getIP k = do 
    dotregstat <- getDotRegstat 
    mc <- getKvstoreClientConfiguration =<< load [Required dotregstat]  
    runMaybeT $ do
      c <- MaybeT (return mc) 
      let url = kvstoreServerURL c 
      r <- lift (jsonFromServer url ("kvstore" </> k) methodGet)
      r' <- either fail return r 
      case r' of 
        Error err -> lift (putStrLn err) >> fail ""  
        Success v -> 
          case v of 
            Object m -> do 
              v' <- (MaybeT . pure) (HM.lookup "value" m)
              case v' of 
                String t -> return (T.unpack t) 
                _ -> do lift (print v')
                        fail ""  
            _ -> fail "" 
          
mkSynergyConf :: [(String,String)] -> IO String 
mkSynergyConf rset = do 
    datadir <- getDataDir 
    let tmpldir = datadir </> "template"
    (tmplgrp :: STGroup String) <- directoryGroup tmpldir 
    let str = renderTemplateGroup tmplgrp rset "synergy.conf"
    return str  



startArch :: Name -> IO () 
startArch (Name k) = do 
    putStrLn "arch linux"
    str <- readProcess "ip" ["addr"] "" 
    let lst = splitOn "wlan0" str 
        wlan0 = lst !! 1 
        iplst = splitOn "inet" wlan0 
        ipinfo = dropWhile isSpace . head . splitOn "/" $ (iplst !! 1) 
    -- print ipinfo 
    registerIP k ipinfo 


startUbuntu :: Name -> IO () 
startUbuntu (Name k) = do 
    putStrLn "ubuntu linux"
    str <- readProcess "ifconfig" [] "" 
    let lst = splitOn "wlan0" str 
        wlan0 = lst !! 1 
        iplst = splitOn "inet addr:" wlan0 
        ipinfo = dropWhile isSpace . head . splitOn " " $ (iplst !! 1) 
    print ipinfo 
    registerIP k ipinfo   

startArchBlue :: Name -> IO () 
startArchBlue (Name k) = do 
    putStrLn "arch linux"
    str <- readProcess "ip" ["addr"] "" 
    let lst = splitOn "bnep0" str 
        wlan0 = lst !! 1 
        iplst = splitOn "inet" wlan0 
        ipinfo = dropWhile isSpace . head . splitOn "/" $ (iplst !! 1) 
    -- print ipinfo 
    registerIP k ipinfo 

startUbuntuBlue :: Name -> IO () 
startUbuntuBlue (Name k) = do 
    putStrLn "ubuntu linux blue"
    str <- readProcess "ifconfig" [] "" 
    let lst = splitOn "bnep0" str 
        wlan0 = lst !! 1 
        iplst = splitOn "inet addr:" wlan0 
        ipinfo = dropWhile isSpace . head . splitOn " " $ (iplst !! 1) 
    print ipinfo 
    registerIP k ipinfo   



startSynergys :: IO () 
startSynergys = do 
    putStrLn "synergys"
    tmpdir <- getTemporaryDirectory 
    let synergyconf = tmpdir </> "synergy.conf"
    runMaybeT $ do 
      ip1 <- MaybeT $ getIP "macbook"
      ip2 <- MaybeT $ getIP "slate" 
      let rset = [ ("left","macbook")
                 , ("right","slate")
                 , ("leftip",ip1)
                 , ("rightip",ip2) ] 
      str <- lift $ mkSynergyConf rset

      lift $ writeFile synergyconf str 
      lift $ system ("synergys -n macbook -c " ++ synergyconf)
      return () 
    return () 

startSynergyc :: IO () 
startSynergyc = do 
    putStrLn "synergyc" 
    runMaybeT $ do 
      ip1 <- MaybeT $ getIP "macbook"
      lift $ system ("synergyc -n slate " ++ ip1)
      return () 
    return () 

