
class Formacion {
	var vagones 
	var locomotoras
	
	//Getters
	method vagones() = vagones
	method locomotoras() = locomotoras  
	//-------------------------------------------------------------------------
	
	method agregarLocomotora(newLocomotora){ locomotoras.add(newLocomotora)}
	
	method laLocomotoraParaMover(arrastreDado){
		return locomotoras.find{locomotora => locomotora.arrastreUtil() > arrastreDado}
	}
	method cantidadVagonesLivianos() = 		
		vagones.count{vagon => vagon.pesoMaximo() < 2500 }
	
	
	method velocidadMaxima() = locomotoras.min{ locomotora => locomotora.velocidadMaxima()}.velocidadMaxima()
	
	method esEficiente(){
		return locomotoras.all{locomotora => locomotora.arrastreUtil() > locomotora.peso() * 5}
	}
	
	method puedeMoverse(){
		return locomotoras.sum{locomotora => locomotora.arrastreUtil()} >= 
				vagones.sum{vagon => vagon.pesoMaximo()}
	}

	
	method cuantosParaMoverse(){
		return if(self.puedeMoverse()) 0 
				else	vagones.sum{vagon => vagon.pesoMaximo()} - 
						locomotoras.sum{locomotora => locomotora.arrastreUtil()} 
			
	}
	
	method esCompleja() = 	self.cantidadDeUnidades() >  20 or 
		locomotoras.map{loco => loco.peso()}.sum() + vagones.map{ elementos => elementos.pesoMaximo()}.sum() > 10000
		
	
	method cantidadDeUnidades() =  locomotoras.size() + vagones.size()
	
	method vagonMaxPesado() = 	vagones.max{vagon => vagon.pesoMaximo()}
	
	method tieneMuchosBanios() =  vagones.banios()  == vagones.cantidadPasajeros().div(50) 
	
	method estaBienArmada() = self.puedeMoverse()
}


class FormacionDeLargaDistancia inherits Formacion{
	override method estaBienArmada() = super() && self.tieneMuchosBanios()
}


class FormacionDeCortaDistancia inherits FormacionDeLargaDistancia {
	override method  estaBienArmada() = super() && self.esCompleja()
}

class FormacionDeAltaVelocidad inherits Formacion{
	override method estaBienArmada(){
		return super() && self.todosVagonesLivianos()
	}
	
	method todosVagonesLivianos() = true 
}