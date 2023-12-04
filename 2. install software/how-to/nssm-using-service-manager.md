# How-To: Use `NSSM` (the Non-Sucking Service Manager)

> Requires `nssm` installed (`nssm` via scoop, or [dl from website](https://nssm.cc/download))

`NNSM` is an essential tool on windows.

It can create and manage "services" (programs that start and run automatically in the background).

## Basic

```
nssm install <program>
```

## Create a new service
```dos
nssm install <SERVICE_NAME> "C:\path\to\exe\or\bat\file.ext" "argument1 argument2"
```

## List parameters for a service
```dos
nssm get <SERVICE_NAME> *
```

## Set a parameter for a service
```dos
nssm set <SERVICE_NAME> PARAMETER_NAME PARAMETER_VALUE
nssm set <SERVICE_NAME> Description "My service description."
nssm set <SERVICE_NAME> Start SERVICE_AUTO_START
nssm set <SERVICE_NAME> AppExit Default Exit
nssm set <SERVICE_NAME> AppStdout "C:\log\service-output.log"
```

## Parameter list
```
AppAffinity
AppDirectory
AppEnvironment
AppEnvironmentExtra
AppExit
Application
AppNoConsole
AppParameters
AppPriority
AppRestartDelay
AppRotateBytes
AppRotateBytesHigh
AppRotateFiles
AppRotateOnline
AppRotateSeconds
AppStderr
AppStderrCreationDisposition
AppStderrFlagsAndAttributes
AppStderrShareMode
AppStdin
AppStdinCreationDisposition
AppStdinFlagsAndAttributes
AppStdinShareMode
AppStdout
AppStdoutCreationDisposition
AppStdoutFlagsAndAttributes
AppStdoutShareMode
AppStopMethodConsole
AppStopMethodSkip
AppStopMethodThreads
AppStopMethodWindow
AppThrottle
DependOnGroup
DependOnService
Description
DisplayName
ImagePath
Name
ObjectName
Start
Type
```

