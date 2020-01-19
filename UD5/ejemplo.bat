@echo off

rem Esto lo hago para que cada vez que ejecute el script se borre todo.
rmdir /S /Q c:\WifiAGo
dsrm -subtree -noprompt "OU=wifi,DC=smr,DC=instituto" 
net share wifi /delete

rem Creamos la carpeta principal
mkdir c:\WifiAGo
rem con icacls le otorgo permisos al Administrador, que tiene todos los permisos ( F )
icacls c:\WifiAGo /grant Administrador:(OI)(CI)F
rem quito todos los permisos heredados a la carpeta. Con lo que solo se queda con los permisos que 
rem acabo de otorgar
icacls c:\WifiAGo /inheritance:r
rem net share sirve para compartir las carpeta y /grant para asignarle los permisos FULL al grupo TODOS
net share wifi=c:\WifiAGo /grant:todos,FULL

rem Creo el resto de carpetas que ahora heredaran los permisos de la carpeta principal, permisos
rem que acabmos de modificar
mkdir c:\WifiAGo\Instaladores
mkdir c:\WifiAGo\Instaladores\JefeInstaladores
mkdir c:\WifiAGo\Revisores
mkdir c:\WifiAGo\Revisores\JefeRevisores

rem Con dsadd ou crearé una unidad organizativa para guardar los grupos y usuarios.
dsadd ou "OU=wifi,DC=smr,DC=instituto"
dsadd ou "OU=Oinstaladores,OU=wifi,DC=smr,DC=instituto"
dsadd ou "OU=Orevisores,OU=wifi,DC=smr,DC=instituto"

rem con dsadd user puedo crear los usuarios y -pwd es para asignarle una contraseña
dsadd user "cn=JefeInstaladores, OU=Oinstaladores,ou=wifi, DC=smr, DC=instituto" -pwd "Pass*1234"
dsadd user "cn=JefeRevisores, OU=Orevisores,ou=wifi, DC=smr, DC=instituto" -pwd "Pass*1234"

rem con dsadd group crearé los grupos.
dsadd group "cn=Instaladores, OU=Oinstaladores,ou=wifi, DC=smr, DC=instituto"
dsadd group "cn=Revisores, OU=Orevisores,ou=wifi, DC=smr, DC=instituto"

rem el resto de usuarios deben poder entrar al directorio principal solo para leer
icacls c:\WifiAGo /grant JefeInstaladores:RX
icacls c:\WifiAGo /grant JefeRevisores:RX
icacls c:\WifiAGo /grant Instaladores:RX
icacls c:\WifiAGo /grant Revisores:RX

rem el jefe de instaladores tiene control total sobre la carpeta instaladores y sobre los subdirectorios
rem los instaladores deben poder leer la carpeta instaladores solamente
icacls c:\WifiAGo\Instaladores /grant JefeInstaladores:(OI)(CI)F
icacls c:\WifiAGo\Instaladores /grant Instaladores:RX

rem el jefe de revisores tiene control total sobre la carpeta instaladores y sobre los subdirectorios
rem los revisores deben poder leer la carpeta instaladores solamente
icacls c:\WifiAGo\Revisores /grant JefeRevisores:(OI)(CI)F
icacls c:\WifiAGo\Revisores /grant Revisores:RX

rem para no tardar tanto en realizar el proceso, usaré un for para crear los instaladores
rem en este bucle uso "dsadd user" para que me cree los usuarios y con "dsmod" modifico los grupos añadiendo usuarios.
rem fijate que el bucle creará 20 instaladores y 20 directorios, uno para cada instalador, llamados instalador1, instalador2,...
rem hasta instalador20. La ultima línea del bucle asigna los permisos a los instaladores sobre su carpeta
for /L %%d in (1, 1, 20) do (
	dsadd user "cn=Instalador%%d, OU=Oinstaladores,ou=wifi, DC=smr, DC=instituto" -pwd "Pass*1234"
	dsmod group "cn=Instaladores, OU=Oinstaladores,ou=wifi, DC=smr, DC=instituto" -addmbr "cn=Instalador%%d, OU=Oinstaladores,ou=wifi, DC=smr, DC=instituto"
	mkdir c:\WifiAGo\Instaladores\Instalador%%d
	icacls c:\WifiAGo\Instaladores\Instalador%%d /grant Instalador%%d:RX 
)

rem ahora creamos 10 revisores, pero el procedimiento es como en el caso anterior
for /L %%d in (1, 1, 10) do (
	dsadd user "cn=Revisor%%d, OU=Orevisores,ou=wifi, DC=smr, DC=instituto" -pwd "Pass*1234"
	dsmod group "cn=Revisores, OU=Orevisores,ou=wifi, DC=smr, DC=instituto" -addmbr "cn=Revisor%%d, OU=Orevisores,ou=wifi, DC=smr, DC=instituto"
	mkdir c:\WifiAGo\Revisores\Revisor%%d
	icacls c:\WifiAGo\Revisores\Revisor%%d /grant Revisor%%d:RX
)

