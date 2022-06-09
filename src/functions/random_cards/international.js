const number = require('./random_num')

//La siguiente función genera un numero de tarjeta internacional
function getInternational(){
	var number_int = [];
	var suma = 0;

	for(let num=0; num<=2; num++){
		var num2=number.getNumero(0,2);

		if(num2==1){
			suma++;
		}
	}

	var limite = 12 + suma;

	for(let initial=0; initial<=limite; initial++){
		var numero = number.getNumero(0,10);
		number_int.push(numero);

	}
	return number_int.join("");
}

module.exports.getInternational = getInternational;