const random = require('random');
const math = require('math');

//La siguiente función genera un número aleatorio
function getNumero(min, max){
	return math.floor(math.random() * (max-min) + min); 
}

module.exports.getNumero = getNumero;