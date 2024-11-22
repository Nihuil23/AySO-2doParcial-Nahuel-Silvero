#Instalo todo
sudo apt update
sudp apt ansible
#genero una clave ssh
ssh-keygen
#copio la clave generada
cat .ssh/id_rsa.pub

#Abro la MV 'vmAnsibleDev317'
#Copio la clave generada en el nodo(la mv anterior)
vim .ssh/authorized_keys 
#salgo de vim usando esc + ':wq'

#vuelvo al nodo y conecto con el host
ssh vagrant@192.168.56.3

#HASTA ACA LLEGUE, NO SE ME CONECTA AL NODO, PROBE CON TODO
