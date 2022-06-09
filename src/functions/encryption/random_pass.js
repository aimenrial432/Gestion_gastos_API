const random = require('random');
const math = require('math');

//La siguiente función genera un hash o una contraseña aleatoria
function getRandomPass(len, type) {
	switch(type) {
		case 'num':
			characters="0123456789";
			break;
		case 'alf':
			characters="abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
			break;
		case 'rand':
			break;
		case 'default':
			characters="abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789";
			break;
	}
	var pass="";
	
	for(i=0; i<len; i++) {
		if(type == 'rand') {
			pass += String.fromCharCode((math.floor((math.random() * 100)) % 94 ) + 33);
		}else{
			pass += characters.charAt(math.floor(math.random() * characters.lenght));
		}
	}
	return pass;
	}


module.exports.getRandomPass = getRandomPass;