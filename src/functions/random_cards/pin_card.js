const number = require('./random_num')

//La siguiente funcion genera el pin de la tarjeta de 3 digitos
function getCardPin() {
	var card_pin = [];

	for(let initial = 1; initial<=3; initial ++){
		var numero = number.getNumero(0,10);
		card_pin.push(numero);	
	}
	return card_pin.join("");
}

module.exports.getCardPin = getCardPin;