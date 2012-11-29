module Main where

import System.Console.CmdArgs

import Application.RegisterStatus.ProgType
import Application.RegisterStatus.Command

main :: IO () 
main = do 
  putStrLn "regstat"
  param <- cmdArgs mode

  commandLineProcess param