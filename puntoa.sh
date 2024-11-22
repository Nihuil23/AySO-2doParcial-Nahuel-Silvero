#Particion principal de 1GB
#Repito 3 veces ya que hay que crear 3 particiones principales de 1GB
sudo fdisk /dev/sdc
  n
  enter
  enter
  enter
  +1G

#Particion Extendida de 3GB
sudo fdisk /dev/sdc
  n
  e
  enter
  enter
  +3G
  # 'p' para ver las particiones creadas
  # 'w' para guardar y salir
 
#Particion 1 se asigna como SWAP
sudo fdisk /dev/sdc
  t
  1  #Aca se elige la particion, en este caso la 1
  82 #Se elige SWAP, se puede ver el listado apretando L
  #'w' para guardar
  #Destinar la particion 1 como SWAP
  sudo mkswap /dev/sdc1
  sudo swapon /dev/sdc1
  #Se verifica que la particion 1 ya sea SWAP con 'free -h'

#Creamos PV, VG y LV con LVM
sudo fdisk /dev/sdc
  t
  2  #Se repite este proceso con las particiones 2, 3, 5 y 6
  8e #Usamos el comando 'L' para ver el listado y elegir la de LVM
  #'w' para guardar
  
  #Creamos un volumen fisico en cada particion
  sudo pvcreate /dev/sdc2 /dev/sdc3 /dev/sdc5 /dev/sdc6
  #Con 'sudo pvs' vemos los pv(phisical volumen) creados

  #Creamos los volumenes group
  sudo vgcreate vgAdmin /dev/sdc2 /dev/sdc3
  sudo vgcreate vgDevelopers /dev/sdc5 /dev/sdc6
  #Con 'sudo vgs' vemos los group volumen creados, para ver si los pv estan en sus grupos usamos 'sudo pvs'

  #Creamos los volumenes logicos
  sudo lvcreate -L 1G vgDevelopers -n lvDevelopers
  sudo lvcreate -L 1G vgDevelopers -n lvTesters
  sudo lvcreate -L .85G vgDevelopers -n lvDevops
  sudo lvcreate -L 1.5G vgAdmin -n lvAdmin
  #Usamos 'sudo lvs' para comprobar los lv

#Formateamos los volumenes logicos y los montamos
  #Los Formateamos
  sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevelopers
  sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvTesters
  sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevops
  sudo mkfs.ext4 /dev/mapper/vgAdmin-lvAdmin
  #Los Montamos
  sudo mkdir /mnt/lvDevelopers
  sudo mount /dev/mapper/vgDevelopers-lvDevelopers /mnt/lvDevelopers
  sudo mkdir /mnt/lvTesters
  sudo mount /dev/mapper/vgDevelopers-lvTesters /mnt/lvTesters
  sudo mkdir /mnt/lvDevops
  sudo mount /dev/mapper/vgDevelopers-lvDevops /mnt/lvDevops
  sudo mkdir /mnt/lvAdmin
  sudo mount /dev/mapper/vgAdmin-lvAdmin /mnt/lvAdmin
  #Verificamos con 'lsblk -f'
