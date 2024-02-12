# escape=`
FROM microsoft/iis:nanoserver-sac2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

HEALTHCHECK --interval=2s `
  CMD ["HealthChecker.exe"]
