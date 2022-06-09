const number = require('./random_num')

//La siguiente funcion genera un numero de tarjeta europea
function getEurope(){
	var number_eur = [];

	for(let initial = 1; initial <=16; initial++){
		var numero = number.getNumero(0,10);
		number_eur.push(numero);

	}
	return number_eur.join("");
}

module.exports.getEurope = getEurope;