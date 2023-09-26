clear

function cambiarDirectorio
{
    if test $# -eq 1
    then
        if test -d $DIRECTORIO
        then
           if test -x $DIRECTORIO
           then
              cd $DIRECTORIO 
           else
              echo Error, no tenemos los permisos par entrar en este directorio
           fi
        else
           echo Error, no se ha introducido un directorio valido
        fi   
    else
        echo Error, el numero de argumentos debe ser 1
    fi
}

function ListarFicherosOrdenadosPorNombre 
{
    LISTA=`ls -l | grep  "^-"` 
    CONTADOR=0
    ITERADOR=9
    if test -n "$LISTA"
    then
    for CONTADOR in `ls -l | cut -c 1 | grep  "^-"` 
    do
       echo $LISTA | cut -f $(($ITERADOR)) -d " " 
       ITERADOR=$(($ITERADOR + 9))
    done
    else
       echo
       echo No existen ficheros en este directorio
       echo
    fi
}

function ListarFicherosOrdenadosPorFecha
{
    LISTA=`ls -lt | grep  "^-"` 
    CONTADOR=0
    ITERADOR=9
    if test -n "$LISTA"
    then
    for CONTADOR in `ls -l | cut -c 1 | grep  "^-"`
    do
       echo $LISTA | cut -f $(($ITERADOR)) -d " " 
       ITERADOR=$(($ITERADOR + 9))
    done   
    else
       echo
       echo No existen ficheros en este directorio
       echo
    fi  
}

function ListarFicherosOrdenadosPorFechaInverso
{
    LISTA=`ls -lt -r | grep  "^-"` 
    CONTADOR=0
    ITERADOR=9
    if test -n "$LISTA"
    then
    for CONTADOR in `ls -l | cut -c 1 | grep  "^-"`
    do
       echo $LISTA | cut -f $(($ITERADOR)) -d " " 
       ITERADOR=$(($ITERADOR + 9))
    done
    else
       echo
       echo No existen ficheros en este directorio
       echo
    fi   
}

function ListarFicherosExtensionDefinida
{
    LISTA=`ls -l | grep  "^-"` 
    CONTADOR=0
    ITERADOR=9
    if test -n "$LISTA"
    then
    for CONTADOR in `ls -l | cut -c 1 | grep  "^-"` 
    do
       echo $LISTA | cut -f $(($ITERADOR)) -d " " | grep '\.'
       ITERADOR=$(($ITERADOR + 9))
    done
    else
       echo
       echo No existen ficheros con extension definida en este directorio
       echo
    fi 
}

function ListarFicherosOcultos	
{
    LISTA=`ls -lad .* | grep  "^-"` 
    CONTADOR=0
    ITERADOR=9
    if test -n "$LISTA"
    then
    for CONTADOR in `ls -lad .* | cut -c 1 | grep  "^-"` 
    do
       echo $LISTA | cut -f $(($ITERADOR)) -d " "  
       ITERADOR=$(($ITERADOR + 9))
    done 
    else
       echo
       echo No existen ficheros ocultos en este directorio
       echo
    fi 
}

function EncontrarFicherosAccedidosEnLosUltimosNDias
{
    if test $# -eq 1
    then
       if test $(($NDIAS)) -gt 0
       then
          find . -type f -atime -$(($NDIAS)) 2>/dev/null | cut -c 3-100 
       else
          echo Error, introduce un numero positivo de dias
        fi
    else
       echo Error, el numero de argumentos debe ser 1
    fi
}

function EncontrarFicherosModificadosEnLosUltimosNDias
{
    if test $# -eq 1
    then
       if test $(($NDIAS)) -gt 0
       then
          find . -type f -mtime -$(($NDIAS)) 2>/dev/null | cut -c 3-100 
       else
          echo Error, introduce un numero positivo de dias
        fi
    else
       echo Error, el numero de argumentos debe ser 1
    fi
}

function EncontrarFicherosQueNoContenganEnSusDatosUnaDeterminadaCadenaDeCaracteres
{
    for CONTADOR in `find . -type f 2>/dev/null`
    do
    CONTROL=0
    for CONTADOR2 in `find . -type f -exec grep -li "$CADENA" {} + 2>/dev/null`
    do
    if test $CONTADOR = $CONTADOR2
    then
       CONTROL=1
    fi
    done
    if test $(($CONTROL)) -eq 0
    then
        echo $CONTADOR | cut -c 3-100
    fi
    done
}


until test "$OPCION" = SALIR
do

echo ========================================================
echo 1 - Imprimir ruta del directorio actual
echo 2 - Cambiar de directorio
echo 3 - Listar ficheros del directorio actual
echo 4 - Encontrar ficheros a partir del directorio actual
echo 5 - Dar permisos
echo 6 - Quitar permisos
echo 7 - Mostrar permisos
echo 0 - Salir
echo ========================================================
       
echo
echo Elige una opción:
read OPCION
echo
case $OPCION in
    1 )
    echo El directorio actual es:
    pwd
    ;; 
    2 ) 
    echo Introduce el directorio al que deseas cambiar:
    read DIRECTORIO
    cambiarDirectorio $DIRECTORIO
    ;; 
    3 )
    until test "$OPCION3" = SALIR
    do
    
    echo ==================================================================
    echo 3.1 - Listar ficheros ordenados por nombre
    echo 3.2 - Listar ficheros ordenados por fecha de modificacion
    echo 3.3 - Listar ficheros ordenados por fecha de modificacion al reves
    echo 3.4 - Listar ficheros que tengan una extension definida
    echo 3.5 - Listar ficheros que sean ocultos
    echo 3.0 - Volver al menu principal
    echo ==================================================================
    
    echo
    echo Elige una opción:
    read OPCION3
    echo
    
    case $OPCION3 in
         1 )
         echo Listado de ficheros ordenados por nombre:
         ListarFicherosOrdenadosPorNombre
         ;; 
         2 )
         echo Listado de ficheros ordenados por fecha de modificacion:
         ListarFicherosOrdenadosPorFecha
         ;; 
         3 )
         echo Listado de ficheros ordenados por fecha  de modificacion al reves:
         ListarFicherosOrdenadosPorFechaInverso
         ;; 
         4 )
         echo Listado de ficheros con una extension definida:
         ListarFicherosExtensionDefinida
         ;; 
         5 )
         echo Listado de ficheros ocultos:
         ListarFicherosOcultos
         ;; 
         0 )
         echo Volviendo al menu principal ...
         OPCION3=SALIR
         ;; 
         * )
         echo Perdón, elige una opción del menu
         ;;         
    esac
    
    echo
    
    done
    OPCION3=0
    ;;
    4 )
    until test "$OPCION4" = SALIR
    do
    
    echo ===========================================================================================
    echo 4.1 - Encontrar ficheros accedidos en los ultimos n dias
    echo 4.2 - Encontrar ficheros modificados en los ultimos n dias
    echo 4.3 - Encontrar ficheros vacios
    echo 4.4 - Encontrar ficheros que tengan una determinada extension
    echo 4.5 - Encontrar ficheros que no contengan en sus datos una determinada cadena de caracteres
    echo 4.6 - Encontrar ficheros normales e inaccesibles para lectura
    echo 4.0 - Volver al menu principal
    echo ===========================================================================================
    
    echo
    echo Elige una opción:
    read OPCION4
    echo
    
    case $OPCION4 in
         1 )
         echo Listado de ficheros accedidos en los ultimon n dias
         echo
         echo Introduce el numero de dias:
         read NDIAS
         echo
         EncontrarFicherosAccedidosEnLosUltimosNDias $NDIAS
         ;; 
         2 )
         echo Listado de ficheros modificados en los ultimon n dias
         echo
         echo Introduce el numero de dias:
         read NDIAS
         echo
         EncontrarFicherosModificadosEnLosUltimosNDias $NDIAS
         ;; 
         3 )
         echo Listado de ficheros vacios:
         find . -type f -size 0 2>/dev/null | cut -c 3-100
         echo
         ;; 
         4 )
         echo Listado de ficheros con una extension definida:
         echo
         echo Introduce la extension del archivo a buscar:
         read EXTENSION
         echo
         find . -type f -name "*.$EXTENSION" -print 2> /dev/null | cut -c 3-100 
         ;; 
         5 )
         echo Listado de ficheros que no contengan en sus datos una determinada cadena de caracteres:
         echo
         echo Introduce la cadena de caracteres:
         read CADENA
         echo
         EncontrarFicherosQueNoContenganEnSusDatosUnaDeterminadaCadenaDeCaracteres $CADENA
         ;; 
         6 )
         echo Listado de ficheros normales:
         echo
         find . -type f -perm -u=r 2>/dev/null | cut -c 3-100
         echo
         echo Listado de ficheros inaccesibles para lectura:
         echo
         find . -type f !-perm -u=r 2>/dev/null | cut -c 3-100
         echo
         ;; 
         0 )
         echo Volviendo al menu principal ...
         OPCION4=SALIR
         ;; 
         * )
         echo Perdón, elige una opción del menu
         ;;         
    esac
    
    echo
    
    done
    OPCION4=0
    ;; 
    5 )    			
    until test "$OPCION5" = SALIR
    do
            DEVUELVE=`echo $?`
	    echo ========================================================================
	    echo 5.1 - Dar permisos al propietario
	    echo 5.2 - Dar permisos al grupo
            echo 5.3 - Dar permisos a los demás
	    echo 5.0 - Volver al menú principal
	    echo ========================================================================
	    
	    echo
	    echo Elige una opción: 
	    read OPCION5
	    echo
	    
	    case $OPCION5 in
		1)
		    until test "$OPCION51" = SALIR
		    do
		        echo ========================================================================
		        echo 5.1.1 - Dar permiso de lectura al propietario
		        echo 5.1.2 - Dar permiso de escritura al propietario
		        echo 5.1.3 - Dar permiso de ejecución al propietario
		        echo 5.1.0 - Volver al menú anterior
		        echo ========================================================================
		        
		        echo		    
			echo Elige una opción: 
			read OPCION51
			echo
			
			case $OPCION51 in
				1)
				    echo ¿A qué fichero o directorio le quieres dar permiso de lectura al propietario?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod u+r $fichDir 2>/dev/null
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir tiene permisos de lectura para el propietario
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi    
	                           echo
			            ;;
				2)
				    echo ¿A qué fichero o directorio le quieres dar permiso de escritura al propietario?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod u+w $fichDir 2>/dev/null
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir tiene permisos de escritura para el propietario
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				3)
				    echo ¿A qué fichero o directorio le quieres dar permiso de ejecucion al propietario?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod u+x $fichDir 2>/dev/null
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir tiene permisos de ejecucion para el propietario
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				0)
				    echo Volviendo al menú anterior ...
				    OPCION51=SALIR
				    ;;
				*)
				    echo Perdón, elige una opción del menu
				    ;;
			esac
		    echo
		    done
		    OPCION51=0
		    ;;
		2)
	            until test "$OPCION52" = SALIR
		    do
		        echo ========================================================================
		        echo 5.2.1 - Dar permiso de lectura al grupo
		        echo 5.2.2 - Dar permiso de escritura al grupo
		        echo 5.2.3 - Dar permiso de ejecución al grupo
		        echo 5.2.0 - Volver al menú anterior
		        echo ========================================================================
		    
                       echo
			echo Elige una opción:
                       read OPCION52
                       echo
                       
			case $OPCION52 in
				1)
				    echo ¿A qué fichero o directorio le quieres dar permiso de lectura al grupo?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod g+r $fichDir 2>/dev/null
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir tiene permisos de lectura para el grupo
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				2)
			            echo ¿A qué fichero o directorio le quieres dar permiso de escritura al grupo?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod g+w $fichDir 2>/dev/null
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir tiene permisos de escritura para el grupo
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				3)
				    echo ¿A qué fichero o directorio le quieres dar permiso de ejecucion al grupo?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod g+x $fichDir 2>/dev/null
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir tiene permisos de ejecucion para el grupo
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				0)
				    echo Volviendo al menú anterior ...
				    OPCION52=SALIR;
				    ;;
				*)
				    echo Perdón, elige una opción del menu
				    ;;
			esac
		    echo
		    done
		    OPCION52=0
		    ;;
		3)
	            until test "$OPCION53" = SALIR
		    do
		        echo ========================================================================
		        echo 5.3.1 - Dar permiso de lectura a los demas
		        echo 5.3.2 - Dar permiso de escritura a los demas
		        echo 5.3.3 - Dar permiso de ejecución a los demas
		        echo 5.3.0 - Volver al menú anterior
		        echo ========================================================================

                       echo
			echo Elige una opción: 
			read OPCION53
			echo
			
			case $OPCION53 in
				1)
				    echo ¿A qué fichero o directorio le quieres dar permiso de lectura a los demas?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod o+r $fichDir 2>/dev/null
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir tiene permisos de lectura para los demas
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				2)
				    echo ¿A qué fichero o directorio le quieres dar permiso de escritura a los demas?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod o+w $fichDir 2>/dev/null
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir tiene permisos de escritura para los demas
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi				        
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;				    
				3)
				    echo ¿A qué fichero o directorio le quieres dar permiso de ejecucion a los demas?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod o+x $fichDir 2>/dev/null
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir tiene permisos de ejecucion para los demas
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				0)
				    echo Volviendo al menú anterior ...
				    OPCION53=SALIR;
				    ;;
				*)
				    echo Perdón, elige una opción del menu
				    ;;
			esac
		    echo
		    done
		    OPCION53=0
		    ;;
		0)
		    echo Volviendo al menú principal ...
		    OPCION5=SALIR
		    ;;
		*)
		    echo Perdón, elige una opción del menu
		    ;;

	    esac
    echo    				
    done
    OPCION5=0
    ;;
    6 )
    until test "$OPCION6" = SALIR
    do
	    echo ========================================================================
	    echo 6.1 - Quitar permisos al propietario
	    echo 6.2 - Quitar permisos al grupo
            echo 6.3 - Quitar permisos a los demás
	    echo 6.0 - Volver al menú principal
	    echo ========================================================================
	    
	    echo
	    echo Elige una opción: 
	    read OPCION6
	    echo
	    
	    case $OPCION6 in
		1)
		    until test "$OPCION61" = SALIR
		    do
		        echo ========================================================================
		        echo 6.1.1 - Quitar permiso de lectura al propietario
		        echo 6.1.2 - Quitar permiso de escritura al propietario
		        echo 6.1.3 - Quitar permiso de ejecución al propietario
		        echo 6.1.0 - Volver al menú anterior
		        echo ========================================================================
		        
		        echo		    
			echo Elige una opción: 
			read OPCION61
			echo
			
			case $OPCION61 in
				1)
				    echo ¿A qué fichero o directorio le quieres quitar permiso de lectura al propietario?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod u-r $fichDir
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir no tiene permisos de lectura para el propietario
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi    
	                           echo
			            ;;
				2)
				    echo ¿A qué fichero o directorio le quieres quitar permiso de escritura al propietario?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod u-w $fichDir
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir no tiene permisos de escritura para el propietario
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				3)
				    echo ¿A qué fichero o directorio le quieres quitar permiso de ejecucion al propietario?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod u-x $fichDir
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir no tiene permisos de ejecucion para el propietario
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				0)
				    echo Volviendo al menú anterior ...
				    OPCION61=SALIR
				    ;;
				*)
				    echo Perdón, elige una opción del menu
				    ;;
			esac
		    echo
		    done
		    OPCION61=0
		    ;;
		2)
	            until test "$OPCION62" = SALIR
		    do
		        echo ========================================================================
		        echo 6.2.1 - Quitar permiso de lectura al grupo
		        echo 6.2.2 - Quitar permiso de escritura al grupo
		        echo 6.2.3 - Quitar permiso de ejecución al grupo
		        echo 6.2.0 - Volver al menú anterior
		        echo ========================================================================
		    
                       echo
			echo Elige una opción:
                       read OPCION62
                       echo
                       
			case $OPCION62 in
				1)
				    echo ¿A qué fichero o directorio le quieres quitar permiso de lectura al grupo?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod g-r $fichDir
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir no tiene permisos de lectura para el grupo
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				2)
			            echo ¿A qué fichero o directorio le quieres quitar permiso de escritura al grupo?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod g-w $fichDir
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir no tiene permisos de escritura para el grupo
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				3)
				    echo ¿A qué fichero o directorio le quieres quitar permiso de ejecucion al grupo?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod g-x $fichDir
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir no tiene permisos de ejecucion para el grupo
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				0)
				    echo Volviendo al menú anterior ...
				    OPCION62=SALIR;
				    ;;
				*)
				    echo Perdón, elige una opción del menu
				    ;;
			esac
		    echo
		    done
		    OPCION62=0
		    ;;
		3)
	            until test "$OPCION63" = SALIR
		    do
		        echo ========================================================================
		        echo 6.3.1 - Quitar permiso de lectura a los demas
		        echo 6.3.2 - Quitar permiso de escritura a los demas
		        echo 6.3.3 - Quitar permiso de ejecución a los demas
		        echo 6.3.0 - Volver al menú anterior
		        echo ========================================================================

                       echo
			echo Elige una opción: 
			read OPCION63
			echo
			
			case $OPCION63 in
				1)
				    echo ¿A qué fichero o directorio le quieres quitar permiso de lectura a los demas?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod o-r $fichDir
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir no tiene permisos de lectura para los demas
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				2)
				    echo ¿A qué fichero o directorio le quieres quitar permiso de escritura a los demas?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod o-w $fichDir
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir no tiene permisos de escritura para los demas
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi				        
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;				    
				3)
				    echo ¿A qué fichero o directorio le quieres quitar permiso de ejecucion a los demas?:
	                           read fichDir
	                           
	                           if test -d $fichDir -o -f $fichDir 
	                           then
				        chmod o-x $fichDir
				        if test $(($DEVUELVE)) -eq 0
				        then
				            echo
				            echo Ahora $fichDir tiene permisos de ejecucion para los demas
				        else
				            echo
				            echo Error, no tenemos autorizacion para cambiar los permisos
				        fi
				    else
				        echo
	                               echo El fichero o directorio no existe.
	                           fi  
	                           echo
				    ;;
				0)
				    echo Volviendo al menú anterior ...
				    OPCION63=SALIR;
				    ;;
				*)
				    echo Perdón, elige una opción del menu
				    ;;
			esac
		    echo
		    done
		    OPCION63=0
		    ;;
		0)
		    echo Volviendo al menú principal ...
		    OPCION6=SALIR
		    ;;
		*)
		    echo Perdón, elige una opción del menu
		    ;;

	    esac
    echo    				
    done
    OPCION6=0
    ;;
    7 )
    echo ¿Sobre qué fichero o directorio quieres conocer sus permisos?:
    read fichDir7
    if test -d $fichDir7 -o -f $fichDir7
    then
	ls -l $fichDir7 | cut -f 1 -d " " | grep -v "^t"
    else 
	echo El fichero o directorio no existe.
    fi
    ;;
    0 )
    echo Saliendo ...
    OPCION=SALIR
    ;;
    * )
    echo Perdón, elige una opción del menu
    ;;
    esac   
    
echo  
       
done






