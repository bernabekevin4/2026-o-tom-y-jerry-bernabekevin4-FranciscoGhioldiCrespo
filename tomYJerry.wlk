object casa {
  var cuidador = tom
  var quilombero = jerry

  method cuidador() = cuidador
  method quilombero() = quilombero

  var suciedad = 1000
  method suciedad() = suciedad;

  method modificarSuciedad(mod) {
    suciedad = suciedad + mod
  }

  method pasaElDia() {
    cuidador.limpiar(self)
    if(quilombero != null && cuidador.atrapaQuilombero(quilombero)){
      quilombero = null
    }
  }

  method pasarLaNoche() {
    cuidador.dormir()
    if(quilombero != null){
      quilombero.hacerQuilombo(self)
    }
  }
}

object tom {
  var energia = 10

  method energia() = energia
  
  method limpiar(casa){ 
    casa.modificarSuciedad(-100)
    energia = (energia - 40).max(0);
  }

  method velocidad() = 5 + (energia / 10)

  method atrapaQuilombero(quilombero) = self.velocidad() > quilombero.velocidad()

  method dormir() {
    energia += 50;
  }

  method serInterrumpido() {
    energia = (energia - 20).max(0)
  }
}

object robocat {
  method limpiar(casa) {
    casa.modificarSuciedad(-casa.suciedad())
  }

  method puedeAtrapar(quilombero) = true

  method dormir() {}

  method serInterrumpido(){}
}

object spike {
  var velocidad = 80

  method velocidad() = velocidad

  method limpiar(casa) {
    casa.modificarSuciedad(-50)
  } 

  method atrapaQuilombero(quilombero) = self.velocidad() > quilombero.velocidad()

  method dormir() {
    velocidad += 20
  }

  method serInterrumpido() {
    velocidad -= 10
  }
}

// Quilomberos
object jerry {
  var peso = 5

  method peso() = peso

  method hacerQuilombo(casa) {
    casa.modificarSuciedad(110);
    peso += 1
  }

  method velocidad() = 10 - peso
}

object tuffy {

  method velocidad() = 10

  method hacerQuilombo(casa) {
    casa.cuidador().serInterrumpido()
  }
}

object butch {
  method velocidad() = 12

  method hacerQuilombo(casa) {
    casa.modificarSuciedad(200)
  }
}

// Pandilla
object pandilla {
  const miembros = []

  method agregarMiembro(miembro) {
    miembros.add(miembro)
  }

  method velocidad() = miembros.map({ m => m.velocidad() }).min() / 2

  method hacerQuilombo(casa) {
    miembros.forEach({m => m.hacerQuilombo(casa)})
    if(miembros.size() > 3) {
      casa.cuidador().serInterrumpido()
    }
  }
}

/* 
  Punto 7 --------------------------

  Se identifican 2 interfaces principales: Cuidador y Quilombero

  La interfaz Cuidador esta dada por los mensajes que la casa necesita enviarle
  a cualquier cuidador. El Cuidador puede:
  - limpiar(casa)
  -atrapaQuilombero(quilombero)
  - dormir()
  - serInterrumpido()

  Tanto Tom como Robocat y Spike, responden a estos mensajes, pero de manera
  diferente en cada caso.

  La interfaz Quilombero esta determinada determinada por los mensajes que la 
  casa necesita enviar a cualquier quilombero. Un quilombero puede:
  - velocidad()
  - hacerQuilombo()

  Tanto Jerry como Butch y la Pandilla pueden responder a estos mensajes.

  La Pandilla seria una "subinterfaz" de quilombero, ya que puede calcular su
  propia velocidad y hacer quilombo, delegando esta ultima accion en todos sus miembros
  
*/