:: On-Demand Flash Autoupdate
:: Author: Karl Horky
:: Date: 22 June 2012
:: Version: 0.2
:: Homepage: http://www.karlhorky.com/2012/06/manually-run-autoupdate-for-adobe-flash.html

@echo off

cd C:\Windows\System32\Macromed\Flash\
if exist *ActiveX.exe (
	echo Updating Flash Player Plugin for Internet Explorer
	for /f "tokens=*" %%f in ('dir /b *ActiveX.exe') do set last=%%f
)

if defined last (
	%last% -update plugin
	set last=
	echo Complete!
)

if exist *Plugin.exe (
	echo Updating Flash Player Plugin for Firefox, Safari, Opera
	for /f "tokens=*" %%f in ('dir /b *Plugin.exe') do set last=%%f
)

if defined last (
	%last% -update plugin
	echo Complete!
)

pause
