Set cmdtaskkill=taskkill
Set cmdcertutil=certutil
if defined PROCESSOR_ARCHITEW6432 Set cmdtaskkill=%SystemRoot%\sysnative\taskkill.exe
if defined PROCESSOR_ARCHITEW6432 Set cmdcertutil=%SystemRoot%\sysnative\certutil.exe

%cmdcertutil% -addstore -f -enterprise root "%~dp0DigiCertTrustedRootG4.crt"
%cmdcertutil% -addstore -f -enterprise CA "%~dp0DigiCertTrustedG4CodeSigningRSA4096SHA3842021CA1.crt"
Exit /b %errorlevel%