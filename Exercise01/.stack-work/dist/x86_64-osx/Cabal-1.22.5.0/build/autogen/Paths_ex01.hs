module Paths_ex01 (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/suzukimiyuki/Desktop/Exercise01/.stack-work/install/x86_64-osx/f1eb8d320e34203dc3544c055a2a744da18c4a0868d46594f66cb02c807decc0/7.10.3/bin"
libdir     = "/Users/suzukimiyuki/Desktop/Exercise01/.stack-work/install/x86_64-osx/f1eb8d320e34203dc3544c055a2a744da18c4a0868d46594f66cb02c807decc0/7.10.3/lib/x86_64-osx-ghc-7.10.3/ex01-0.1.0.0-CmkBIqRQqyCJ0gZevCCGZy"
datadir    = "/Users/suzukimiyuki/Desktop/Exercise01/.stack-work/install/x86_64-osx/f1eb8d320e34203dc3544c055a2a744da18c4a0868d46594f66cb02c807decc0/7.10.3/share/x86_64-osx-ghc-7.10.3/ex01-0.1.0.0"
libexecdir = "/Users/suzukimiyuki/Desktop/Exercise01/.stack-work/install/x86_64-osx/f1eb8d320e34203dc3544c055a2a744da18c4a0868d46594f66cb02c807decc0/7.10.3/libexec"
sysconfdir = "/Users/suzukimiyuki/Desktop/Exercise01/.stack-work/install/x86_64-osx/f1eb8d320e34203dc3544c055a2a744da18c4a0868d46594f66cb02c807decc0/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ex01_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ex01_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "ex01_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ex01_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ex01_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
