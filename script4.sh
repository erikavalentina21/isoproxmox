#! /bin/bash
clear

function dispo(){
	for vmid in $(seq $1 $2); do
  		if ! qm list | awk '{print $1}' | grep -q $vmid; then
        		echo "$vmid"
        		break
  		fi
	done
}






read -p "introduce el rango de vmid que estás usando origen: " or
read -p "introduce el rango de vmid que estás usando fin: " fin

for clon in $(cat clonaciones_mv.txt); do
	numero_mv=$(echo $clon | awk -F ":" '{print $1}')
	nuevo_clon=$(dispo $or $fin)
	nombre_clon=$(echo $clon | awk -F ":" '{print $2}')
	tipo=$(echo $clon | awk -F ":" '{print $3}')
	echo "clonando $numero_mv con numero $nuevo_clon y nombre $nombre_clon y tipo $tipo"
	qm clone $numero_mv $nuevo_clon --name $nombre_clon --full

	if [[ "$tipo" == "vinculada" ]]; then
		echo "creando clonacion LINKED $numero_mv con numero $nuevo_clon y nombre $nombre_clon"
		qm set $nombre_clonacion --virtio0 /dev/pve/vm-$id_plantilla-disk-0
	fi
done

