##############################################################################
## Curso: FUNDAMENTOS DE LA PROGRAMACION ESTADISTICA Y DATA MINING EN R. 
##        ESTADISTICA DESCRIPTIVA, MODELOS DE REGRESION Y ARBOLES DE DECISION
##       
## Junio-Julio 2017
## Docente: German Rosati
##############################################################################

############################
## ACTIVIDADES UNIDAD 1B. ##
############################

## 1. IMPORTAR EL DATASET "data_filt.csv" 
# (se asume que el archivo está en el working directory)
data<-read.csv("data_filt.csv")

## 2. GENERAR UNA FUNCION QUE DETERMINE SI UN NUMERO ES IMPAR
par<-function(x){
	if (x %% 2 ==0){
		print('Es n?mero par')
	}
	else {
		print("Es n?mero impar")
	}
}

## 3. GENERAR UNA FUNCION QUE DETERMINE SI UN NUMERO ES PRIMO
primo<-function(x){
	pr<-1
	if (x == 1 | x ==2){
		pr<-1
	}
	else if (x > 2){
		for (i in 2:(x-1)){
			if ((x %% i) == 0){
				pr<-0
				break
			}
		}
	}
	if (pr == 1) {
		print('Es n?mero primo')
	}
	else {
		print('No es n?mero primo')
	}
}

#4. GENERAR UNA FUNCION QUE CALCULE LA MEDIA DE UNA 
# COLUMNA CUANTITATIVA DEL DATASET. COMPARAR EL RESULTADO 
# CON LA FUNCION mean() 

media<-function(x){
    m<-0
    for (i in 1:length(x)){
      m<-m+x[i]
    }
    return(m/length(x))
}

## 5. GENERAR UNA FUNCION QUE CALCULE EL RANGO DE UNA 
# COLUMNA CUANTITATIVA DEL DATASET. COMPARAR EL RESULTADO 
# CON LA FUNCION range() 

rango<-function(x){
        return(max(x)-min(x))
}


#6. GENERAR UNA FUNCION QUE CALCULE EL DESVIO STANDARD DE UNA 
# COLUMNA CUANTITATIVA DEL DATASET. COMPARAR EL RESULTADO 
# CON LA FUNCION sd() 
	
desvio<-function(x){
  d<-0
  m<-mean(x)
  for (i in 1:length(x)){
    d<-d+(x[i]-m)**2
  }
  return(sqrt(d/(length(x)-1)))
}

# 7. GENERAR UNA FUNCION QUE CALCULE EL COEFICIENTE DE VARIACION
# DE UNA COLUMNA CUANTITATIVA DEL DATASET
coef_var<-function(x){
	return(desvio(x)/media(x))
}

# También podría hacerse con las fuciones nativas de R
coef_var2<-function(x){
	return(sd(x)/mean(x))
}

## 8. LOS EXAMENES DE UNA MATERIA SE DISTRIBUYEN DE FORMA
# NORMAL CON UNA MEDIA DE 65 Y UN DESVIO DE 13.1.
# ¿QUÉ PROBABILIDAD HAY DE ENCONTRAR UN ESTUDIANTE
# QUE HAYA OBTENIDO 84 O MAS EN EL EXAMEN?

pnorm(84, mean=65, sd=13.1, lower.tail=FALSE)


## 9. SUPONGA QUE HAY UN EXMAEN EN EL QUE HAY 20 PREGUNTAS DE 
# MULTIPLE CHOICE. CADA PREGUNTA TIENE CINCO RESPUESTAS
# CORRECTAS POSIBLE Y SOLAMENTE UNA ES CORRECTA.
# ENCONTRAR LA PROBABILIDAD DE QUE UN ESTUDIANTE 
# TENGA 4 O MENOS RESPUESTAS CORRECTAS SI INTENTA CONTESTAR
# CADA PREGUNTA ALEATORIAMENTE.

# La probabilidad de acertar una pregunta es 1/5 = 0.2
# Entonces, obtener exactamente 4 correctas es

dbinom(4, size=12, 0.2)

# Podemos, entonces, sumar
dbinom(4, size=12, prob=0.2) +
dbinom(3, size=12, prob=0.2) +
dbinom(2, size=12, prob=0.2) +
dbinom(1, size=12, prob=0.2)	+
dbinom(0, size=12, prob=0.2)

# Alternativamente,
pbinom(4, size=12, prob=0.2)

## 10. COMPRUEBE LA LEY DE LOS GRANDES NUMEROS
# PARA LA ESTIMACION DE UNA PROPORCION POBLACIONAL A PARTIR
# DE UNA MUESTRA

muestreador<-function(N,pi,sim){
	par(mfrow=c(2,4))
	x<-rbinom(N,1,pi)
	xm<-vector()
	sims<-sim
	print(paste("Media poblacional=",mean(x)))
	for (n in c(5,10,25,50,75,100,250,500,1000,5000,10000,10000)){
		for (i in 1:sims){
			xm[i]<-mean(sample(x,n,replace=T))
		}
		print(mean(xm[i]))
		hist(xm, main=c("Tam. n=",n))
		lines(mean(x))
	}
}

muestreador(100000,0.5,1000)

