const number = require('./random_num')

//La siguiente funcion genera el codigo de tarjeta de cuatro digitos
function getCodeCard() {
	var card_code = [];

	for(let initial = 1; initial<=4; initial ++){
		var numero = number.getNumero(0,10);
		card_code.push(numero);
	}
	return card_code.join("");
}

module.exports.getCodeCard = getCodeCard;