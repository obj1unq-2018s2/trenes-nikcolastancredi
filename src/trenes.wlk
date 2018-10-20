import vagones.*
import locomotoras.*

class Formacion {
	var vagones 
	var locomotoras
	
	//Getters
	method vagones() = vagones
	method locomotoras() = locomotoras  
	//-------------------------------------------------------------------------
	
	
	method agregarLocomotoraParaMoverseDe(newLocomotoras){
		locomotoras.add(newLocomotoras.find{loco=>loco.arrastreUtil() > self.cuantosParaMoverse()})
	}
	//--------------------------
	method cantidadVagonesLivianos() = 		
		vagones.count{vagon => vagon.pesoMaximo() < 2500 }
	
	
	method velocidadMaxima() = locomotoras.min{ locomotora => locomotora.velocidadMaxima()}.velocidadMaxima()
	
	method esEficiente() = locomotoras.all{locomotora => locomotora.arrastreUtil() > locomotora.peso() * 5}
	
	method puedeMoverse() = locomotoras.sum{locomotora => locomotora.arrastreUtil()} >= vagones.sum{vagon => vagon.pesoMaximo()}

	
	method cuantosParaMoverse(){
		return if(self.puedeMoverse()) 0 
				else	vagones.sum{vagon => vagon.pesoMaximo()} - 
						locomotoras.sum{locomotora => locomotora.arrastreUtil()} 
			
	}
	
	method esCompleja() = self.cantidadDeUnidades() > 20 or 
		locomotoras.map{loco => loco.peso()}.sum() + vagones.map{ elementos => elementos.pesoMaximo()}.sum() > 10000
		
	
	method cantidadDeUnidades() =  locomotoras.size() + vagones.size()
	
	method vagonMaxPesado() = 	vagones.max{vagon => vagon.pesoMaximo()}
	
	method tieneMuchosBanios() =  vagones.all{vagon => vagon.tieneLosBaniosSufi()}
	
	
	method estaBienArmada() = self.puedeMoverse()
}


class FormacionDeLargaDistancia inherits Formacion{
	var property  cubreGrandesCiudades = null
	
	override method estaBienArmada() = super() && self.tieneMuchosBanios()
	
	override method velocidadMaxima() = super().min(if(cubreGrandesCiudades) 200 else 150 ) 	
	
 }
 
class FormacionDeCortaDistancia inherits Formacion {
	override method  estaBienArmada() = super() && self.esCompleja()
	
	override method velocidadMaxima() = super().min(60)
}

class FormacionDeAltaVelocidad inherits FormacionDeLargaDistancia{
	
	
	override method estaBienArmada() =  super() && self.velocidadMaxima() > 250 && self.todosVagonesLivianos()
	
	override method velocidadMaxima() = if (super() > 400)  400 else super() 
	
	method todosVagonesLivianos() = vagones.all{vagon => vagon.pesoMaximo() < 2500} 
}