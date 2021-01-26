@echo off
rem Put Git, Node.Js, and NPM into Windows PATH
set toolspath=%1
if NOT EXIST %toolspath% GOTO notFoundDirectory

:directoryFound
  set gitdir=%toolspath%\git\cmd
  set nodedir=%toolspath%\nodejs\
  set javahome=%toolspath%\jdk\bin\
  set mavendir=%toolspath%\maven\bin\
  set path=%PATH%;%gitdir%;%nodedir%;%javahome%;%mavendir%
  rem Figure out versions for Git, Node.Js, and NPM. This first one breaks apart the Git version to make it look nicer.
  for /f "tokens=3-6 delims=. " %%a in ('git --version') do (set gitver1=%%a&set gitver2=%%b&set gitver3=%%c)
  for /f "tokens=1" %%v in ('node -v') do set nodever=%%v
  for /f "tokens=1" %%n in ('npm -v') do set npmver=%%n
  for /f tokens^=2-5^ delims^=.-_^" %%j in ('java -fullversion 2^>^&1') do set "jver=%%j%%k%%l%%m"
  for /f "tokens=3" %%m in ('mvn --version 2^>^&1') do (set mavenver=%%m & GOTO print)
  :print
  echo Environment Variables Configured
  echo --------------------------------
  echo Git Version = v%gitver1%.%gitver2%.%gitver3%
  echo Node Version = %nodever%
  echo NPM Version = v%npmver%
  echo JDK Version = v%jver%
  echo Maven Version = v%mavenver%
  GOTO endLabel


:notFoundDirectory
  echo %toolspath% directory not found. No environment variables configured.

:endLabel
