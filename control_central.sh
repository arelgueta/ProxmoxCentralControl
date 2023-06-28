#! /bin/bash
#Declación de variables
WEB_DIR=/var/www/html

#Crea un array con los servidores a monitorear
server=(servidor1 servidor2 servidor3 servidor4)

#Borra el index y crea uno nuevo
rm -Rf $WEB_DIR/index.html
html="$WEB_DIR/index.html"
hora=$(date)

echo "Generando reporte $hora"
#Generating HTML file

echo "<html>" >> $html
echo "<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>" >> $html
echo "<body>" >> $html
echo "<fieldset>" >> $html
echo "<center>" >> $html
echo "<h2>Proxmox: Reporte de VM" >> $html
echo "<h3><legend>INSTITUCIÓN</legend></h3>" >> $html
echo "Ultima Actualizacion: $hora" >> $html
echo "</center>" >> $html
echo "</fieldset>" >> $html
echo "<br>" >> $html
#Genera tabla con información de archivos de sistema de Linux

echo "<br><br>" >> $html
echo "<center>" >> $html
echo "<h3><legend>MAQUINAS VIRTUALES</legend></h3>" >> $html
echo "</center>" >> $html
echo "
<table class='table' border='1' align='center' border-collapse='collapse'>" >> $html
for sdor in "${server[@]}"
do
        webpage="<a href="https://$sdor:8006" target='_blank'>$sdor</a>"
        comandovm="ssh root@$sdor qm list"
	contador=1
# Lee la salida del comando linea por linea
while read line; do
	if [ $contador == 1 ] 
	then
		echo "
		<thead class='thead-dark'>
		<tr >
		<th >VMID</th>
		<th >NombreVM</th>
		<th >Estado VM</th>
		<th >SERVIDOR</th>
		</tr>
		</thead>" >> $html
	else
		echo "<tr><td align='center'>" >> $html
		echo $line | awk '{print $1}' >> $html
		echo "</td><td align='center'>" >> $html
		echo $line | awk '{print $2}' >> $html
		echo "</td><td align='center'>" >> $html		
		echo $line | awk '{print $3}' >> $html
                echo "</td><td align='center'>" >> $html
                echo $webpage >> $html
		echo "</td></tr>" >> $html
	fi
	let contador++
done < <($comandovm)
done
#done < <( df -h | grep -vi filesystem)
echo "</table>" >> $html
echo "<br><br>" >> $html
echo "<center>" >> $html
echo "<h3><legend>CONTENEDORES</legend></h3>" >> $html
echo "</center>" >> $html
echo "
<table class='table' border='1' align='center' border-collapse='collapse'>" >> $html
for sdor in "${server[@]}"
do
        webpage="<a href="https://$sdor:8006">$sdor</a>"
        comandolxc="ssh root@$sdor pct list"
	contador=1
# Lee la salida del comando linea por linea
while read line; do
        if [ $contador == 1 ]
        then
                echo "
                <thead class='thead-dark'>
                <tr>
                <th align=center>LXC ID</th>
                <th align=center>Estado LXC</th>
                <th align=center>NombreLXC</th>
                <th align=center>SERVIDOR</th>
                </tr>
                </thead>" >> $html
        else
                echo "<tr><td align='center'>" >> $html
                echo $line | awk '{print $1}' >> $html
                echo "</td><td align='center'>" >> $html
                echo $line | awk '{print $2}' >> $html
                echo "</td><td align='center'>" >> $html
                echo $line | awk '{print $3}' >> $html
                echo "</td><td align='center'>" >> $html
                echo $webpage >> $html
                echo "</td></tr>" >> $html
        fi
        let contador++
done < <($comandolxc)
done
#done < <( df -h | grep -vi filesystem)
echo "</table>" >> $html
echo "</body>" >> $html
echo "</html>" >> $html
