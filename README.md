# ProxmoxCentralControl
Panel Central mostrado en una web html para controlar estado en forma dinámica de las VM y los LXC corriendo en múltiples Servidores Proxmox independientes y link a cada uno de ellos

# Funcionamiento
Para el funcionamiento, se requiere: 
- Utilización de Servidor Web
- Utilizar Certificados ssh para acceso remoto a los servidores a controlar
- Script que recoja los datos y los lance a una web
- Cron que ejecute el script cada cierto tiempo

## Instalación de servidor web

En este caso se utilizó un container Debian 11 con apache2

apt install apache2

se configuró el servidor a fin de exponer: /var/www/html/index.html

## Instalación de Certificados
Generar Certificado para acceso ssh:

ssh-keygen -t rsa -b 4096 -C "mail"
ssh-copy-id usuario@servidor

Copiar a los servidores a monitorear - Los usuarios deben tener privilegios para listar VM y LXC en los servidores remotos

## Script

Adjunto al presente

## Cron

Editar el tiempo en el que se ejecutará el script para mantener actualizada la web

crontab -e

