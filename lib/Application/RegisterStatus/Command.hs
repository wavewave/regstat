module Application.RegisterStatus.Command where

import Application.RegisterStatus.ProgType
import Application.RegisterStatus.Job

commandLineProcess :: Regstat -> IO ()
commandLineProcess Arch = startArch
commandLineProcess Ubuntu = startUbuntu 
