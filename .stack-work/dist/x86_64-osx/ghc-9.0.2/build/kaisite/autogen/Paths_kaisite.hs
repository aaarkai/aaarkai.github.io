{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_kaisite (
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

bindir     = "/Users/kai/ref/aaarkai.github.io/.stack-work/install/x86_64-osx/ec7c1d945e6a909f7840f3ea655c6596ea767fccf4a85e212bc6215741744d50/9.0.2/bin"
libdir     = "/Users/kai/ref/aaarkai.github.io/.stack-work/install/x86_64-osx/ec7c1d945e6a909f7840f3ea655c6596ea767fccf4a85e212bc6215741744d50/9.0.2/lib/x86_64-osx-ghc-9.0.2/kaisite-0.1.0.0-84UhgR6jhewGJEPUyhWdkP-kaisite"
dynlibdir  = "/Users/kai/ref/aaarkai.github.io/.stack-work/install/x86_64-osx/ec7c1d945e6a909f7840f3ea655c6596ea767fccf4a85e212bc6215741744d50/9.0.2/lib/x86_64-osx-ghc-9.0.2"
datadir    = "/Users/kai/ref/aaarkai.github.io/.stack-work/install/x86_64-osx/ec7c1d945e6a909f7840f3ea655c6596ea767fccf4a85e212bc6215741744d50/9.0.2/share/x86_64-osx-ghc-9.0.2/kaisite-0.1.0.0"
libexecdir = "/Users/kai/ref/aaarkai.github.io/.stack-work/install/x86_64-osx/ec7c1d945e6a909f7840f3ea655c6596ea767fccf4a85e212bc6215741744d50/9.0.2/libexec/x86_64-osx-ghc-9.0.2/kaisite-0.1.0.0"
sysconfdir = "/Users/kai/ref/aaarkai.github.io/.stack-work/install/x86_64-osx/ec7c1d945e6a909f7840f3ea655c6596ea767fccf4a85e212bc6215741744d50/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "kaisite_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "kaisite_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "kaisite_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "kaisite_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "kaisite_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "kaisite_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
