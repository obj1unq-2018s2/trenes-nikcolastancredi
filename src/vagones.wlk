import locomotoras.*
import trenes.*


class VagonPasajeros{
	var property largo = null //en metros
	var property anchoUtil = null // tambien en metros
	var property banios = 0
	
	method cantidadPasajeros() = if(anchoUtil < 2.5) largo*8 else largo*10
	
	method pesoMaximo() = self.cantidadPasajeros() * 80
	
	method tieneLosBaniosSufi() = banios  == self.cantidadPasajeros().div(50) 
}

class VagonCarga{	
	var property cargaMaxima 
	var property banios = 0
	
	method cantidadPasajeros() {return 0}
	
	method pesoMaximo() = cargaMaxima + 160 	//medido en kilos
	
	method tieneLosBaniosSufi() = banios == 0
}


class Deposito{
	var property formacionesDepositadas // una lista de formaciones
	
	method losVagonesMasPesados() = formacionesDepositadas.map{formacion => formacion.vagonMaxPesado()}
	
	method necesitaUnConductorExp() =  formacionesDepositadas.any{formacion => formacion.esCompleja()}
	
	method agregarLocomotoraA(formacionDeterminada){
		var locomotorasDepositadas = formacionesDepositadas.map{formacion=>formacion.locomotoras()}.flatten()
		if(not formacionDeterminada.puedeMoverse()){
			formacionDeterminada.agregarLocomotoraParaMoverseDe(locomotorasDepositadas)
		}else{}
	}
}