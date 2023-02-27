# Con este MakeFile busco ejecutar el script lo mas rapido posible sin tanto problema.


#GITHUB = git clone https://github.com
DESCOMPRIMIR = unzip rofi.zip; rm rofi.zip
PERMISOS = 	chmod +x main.sh
EJECUCION =	./main.sh
BORRAR_TODO = rm -i .*

main:
	${DESCOMPRIMIR}
	${PERMISOS}
	${EJECUCION}
	

clean:
	${BORRAR_TODO}


