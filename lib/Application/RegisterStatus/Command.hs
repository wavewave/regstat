module Application.RegisterStatus.Command where

import Application.RegisterStatus.ProgType
import Application.RegisterStatus.Job

commandLineProcess :: Regstat -> IO ()
commandLineProcess (Arch n) = startArch (Name n)
commandLineProcess (Ubuntu n) = startUbuntu (Name n)
commandLineProcess Synergys = startSynergys
commandLineProcess Synergyc = startSynergyc
