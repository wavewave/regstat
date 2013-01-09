module Application.RegisterStatus.Command where

import Application.RegisterStatus.ProgType
import Application.RegisterStatus.Job

commandLineProcess :: Regstat -> IO ()
commandLineProcess (Arch n) = startArch (Name n)
commandLineProcess (Ubuntu n) = startUbuntu (Name n)
commandLineProcess (IMac n) = startIMac (Name n)
commandLineProcess (ArchBlue n) = startArchBlue (Name n)
commandLineProcess (UbuntuBlue n) = startUbuntuBlue (Name n)
commandLineProcess Synergys = startSynergys
commandLineProcess (Synergyc n) = startSynergyc (Name n)
