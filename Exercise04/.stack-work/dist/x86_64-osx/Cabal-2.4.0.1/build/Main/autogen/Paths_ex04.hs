{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_ex04 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/suzukimiyuki/Desktop/Exercise04/.stack-work/install/x86_64-osx/f76d6ecfd1d3bf29ea0ec30609618e683023eeba17da1132d332773a5d884b40/8.6.4/bin"
libdir     = "/Users/suzukimiyuki/Desktop/Exercise04/.stack-work/install/x86_64-osx/f76d6ecfd1d3bf29ea0ec30609618e683023eeba17da1132d332773a5d884b40/8.6.4/lib/x86_64-osx-ghc-8.6.4/ex04-0.1.0.0-Cu5pDLZU1lL1oZZBLT9YV4-Main"
dynlibdir  = "/Users/suzukimiyuki/Desktop/Exercise04/.stack-work/install/x86_64-osx/f76d6ecfd1d3bf29ea0ec30609618e683023eeba17da1132d332773a5d884b40/8.6.4/lib/x86_64-osx-ghc-8.6.4"
datadir    = "/Users/suzukimiyuki/Desktop/Exercise04/.stack-work/install/x86_64-osx/f76d6ecfd1d3bf29ea0ec30609618e683023eeba17da1132d332773a5d884b40/8.6.4/share/x86_64-osx-ghc-8.6.4/ex04-0.1.0.0"
libexecdir = "/Users/suzukimiyuki/Desktop/Exercise04/.stack-work/install/x86_64-osx/f76d6ecfd1d3bf29ea0ec30609618e683023eeba17da1132d332773a5d884b40/8.6.4/libexec/x86_64-osx-ghc-8.6.4/ex04-0.1.0.0"
sysconfdir = "/Users/suzukimiyuki/Desktop/Exercise04/.stack-work/install/x86_64-osx/f76d6ecfd1d3bf29ea0ec30609618e683023eeba17da1132d332773a5d884b40/8.6.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ex04_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ex04_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "ex04_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "ex04_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ex04_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ex04_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
