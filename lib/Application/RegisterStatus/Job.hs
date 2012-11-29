module Application.RegisterStatus.Job where

import Data.Char
import Data.List.Split 
import System.Environment
import System.FilePath
import System.Process 


registerIP :: String -> String -> IO () 
registerIP k v = do 
  homepath <- getEnv "HOME" 
  let dotregstat = homepath </> ".regstat" 
  system ( "kvstore-client put " ++ k ++ " " ++ v ++ " --config="++dotregstat)
  return ()


startArch :: IO () 
startArch = do 
  putStrLn "arch linux"
  str <- readProcess "ip" ["addr"] "" 
  let lst = splitOn "wlan0" str 
      wlan0 = lst !! 1 
      iplst = splitOn "inet" wlan0 
      ipinfo = dropWhile isSpace . head . splitOn "/" $ (iplst !! 1) 
  -- print ipinfo 
  registerIP "macbook" ipinfo 

startUbuntu :: IO () 
startUbuntu = do 
  putStrLn "ubuntu linux"
  str <- readProcess "ip" ["addr"] "" 
  let lst = splitOn "wlan0" str 
      wlan0 = lst !! 1 
      iplst = splitOn "inet" wlan0 
      ipinfo = dropWhile isSpace . head . splitOn "/" $ (iplst !! 1) 
  print ipinfo 
  