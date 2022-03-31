#27/03/2022
#Homogenización y relleno de datos diarios de precipitación
#Dennis Alvarino Cieza Tarrillo
#daciezat@gmail.com

########################################################################################

# Instalar paquetes -------------------------------------------------------
#install.packages("climatol")
#install.packages("readxl")

# Cargar paquetes ---------------------------------------------------------
library(readxl)
library(climatol)

########################################################################################

# Acondicionar data para climatol -----------------------------------------
#Rutear carpeta de trabajo
setwd("D:/Cursos/Climatol/corrida2")

#Leer los datos de estaciones en excel
esta <- read_excel("Esta.xlsx")
View(esta)

#Leer los datos de precipitación en excel
datos <- read_excel("datos.xlsx")
View(datos)

#Guardar los archivos en formato .Rda
save(esta,datos, file = "Datos.Rda")

#Leer los archivos .Rda para guardarlos en formato climatol
load(file = "Datos.Rda")

# Guardar archivos en formato climatol ------------------------------------
#Guardar archivos de precipitacion en formato .est
write.table(datos, 'Pp_2010-2016.dat',sep = '\t',
            row.names = FALSE, col.names = FALSE)  #Los nombres se debe cambiar segun los años que se tenga de data

#Guardar archivos de estaciones en formato .dat
write.table(esta, 'Pp_2010-2016.est',
            row.names = FALSE, col.names = FALSE)  #Los nombres se debe cambiar segun los años que se tenga de data

########################################################################################
# Ejecucion de Climatol ---------------------------------------------------

#Homeginzación exploratoria de datos
homogen('Pp', 2010, 2016, expl=TRUE)

#Homogenización de datos
homogen('Pp', 2010, 2016)


#Homogenización de la serie
homogen('Pp', 2010, 2016, dz.max=9, snht1=60, snht2=70)

# Con precipitaciones, añadir el parámetro valm=1 (1:Suma, 2: Media, 3:Maximo, 4: Minimo)
# Calcular totales mensuales en lugar de valores medios)

dd2m('Pp', 2010, 2016, valm = 1)

#Homogenizacion de las series mensuales
homogen('Pp-m', 2010, 2016)

#Ajuste de las series diarias con los puntos de corte mensuales
homogen('Pp', 2010, 2016, dz.max=7, metad=TRUE)

#Cargar datos
load('Pp_2010-2016.rda')

#Calculo de totales mensuales y luego medios añadir el parámetro valm=1 para precipitaciones (1:Suma, 2: Media, 3:Maximo, 4: Minimo)
dd2m('Pp', 2010, 2016, homog=TRUE, valm = 1)

#Series homegneizadas en formato .csv
dahstat('Pp', 2010, 2016, stat='series')

#Resume estadistico
dahstat('Pp',2010,2016) #medias de las series diarias
dahstat('Pp',2010,2016,mh=TRUE) #medias de los valores mensuales
dahstat('Pp',2010,2016,mh=TRUE,stat='tnd') #tendencias y p-valores
dahstat('Pp',2010,2016,stat='q',prob=.2) #primer quintil (diarios)


