# escape=`
FROM microsoft/iis:nanoserver-sac2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENTRYPOINT ["powershell"]
CMD Start-Service W3SVC; `    
    Start-Sleep -Seconds 30; `
    C:\ServiceMonitor.exe w3svc
