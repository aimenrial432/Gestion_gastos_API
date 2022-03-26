const express = require('express');
const router = express.Router();
const random = require('random');
const math = require('math');
const crypto = require('crypto');
const Cipher = require('aes-cbc');
const mysqlConnection = require('../database');

const _INTERNATIONAL = 'INTERNATIONAL';
const _EUROPE ='EUROPE';

//Funcion que encripta los datos de la tarjeta convertidos a string
function encrypt(plain_text, encrypt_method, key, iv) {
        var encryptor = crypto.createCipheriv (encrypt_method, key, iv);
        return encryptor.update (plain_text, 'utf8', 'base64') + encryptor.final('base64');
}

//Funcion que desencripta la tarjeta cuando los datos estan encriptados
function decrypt(encrypted_message, encrypt_method, key, iv) {
        var decryptor = crypto.createDecipheriv (encrypt_method, key, iv);
        return decryptor.update (encrypted_message, 'base64', 'utf8') + decryptor.final('utf8');

}


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

//La siguiente función genera un número aleatorio
function getNumero(min, max){
	return math.floor(math.random() * (max-min) + min); 
}

//La siguiente funcion genera el codigo de tarjeta de cuatro digitos
function getCodeCard() {
	var card_code = [];

	for(let initial = 1; initial<=4; initial ++){
		var numero = getNumero(0,10);
		card_code.push(numero);
	}
	return card_code.join("");
}

//La siguiente funcion genera el pin de la tarjeta de 3 digitos
function getCardPin() {
	var card_pin = [];

	for(let initial = 1; initial<=3; initial ++){
		var numero = getNumero(0,10);
		card_pin.push(numero);	
	}
	return card_pin.join("");
}

//La siguiente funcion genera un numero de tarjeta europea
function getEurope(){
	var number_eur = [];

	for(let initial = 1; initial <=16; initial++){
		var numero = getNumero(0,10);
		number_eur.push(numero);

	}
	return number_eur.join("");
}

//La siguiente función genera un numero de tarjeta internacional
function getInternational(){
	var number_int = [];
	var suma = 0;

	for(let num=0; num<=2; num++){
		var num2=getNumero(0,2);

		if(num2==1){
			suma++;
		}
	}

	var limite = 12 + suma;

	for(let initial=0; initial<=limite; initial++){
		var numero = getNumero(0,10);
		number_int.push(numero);

	}
	return number_int.join("");
}

//La siguiente funcíon establece el tipo de tarjeta 

function setCurrentCard(type) {
	try{
		if(type == _INTERNATIONAL) {
			currentCard = _INTERNATIONAL;

		}else if (type == _EUROPE) {
			currentCard = _EUROPE;
			}

	} catch (error) {
		console.error('Fallo al ejecutar: ${error} ');
		process.exit(1);
	}
}


//Ruta para recibir informacion de tarjeta que se recibira encriptada
//con la consulta correspondiente

router.get('/getcard/', (req, res) => {
	mysqlConnection.query('SELECT max(Id_user) as maximo FROM bda_Empleados',
	(err, rows, fields) => {

		if(!err) {
			res.json(rows);

			for (x of rows) {
				var id = x.maximo;
				let info_card = [null, id, getEurope(), getInternational(), getCodeCard(), getCardPin()];

				mysqlConnection.query("INSERT INTO bda_Tarjetas VALUES (?)", [info_card],
				(err, result, fields) => {

				if(!err){
					console.log(result);
					let info_hash = [null, id, getRandomPass(32, 'rand')];
					mysqlConnection.query("INSERT INTO bda_Nothing_Interesting VALUES (?)", [info_hash],
					(err, result, fields) => {

					if(!err) {
						console.log(result);
					}else {
						console.log(err);
					}
						});

				} else {
					console.log(err);
				}
					}); 
			}

		} else {
			console.log(err);
		}

	});

});



//Ruta para saber la inormacion de la tarjeta 

router.get('/infocard/:id/:type' , (req, res) => {
	const { id } = req.params;
	const { username } = req.params;
	const { type } = req.params
	var tarjeta = [];

	if ( [type] == "EUROPEA") {
		mysqlConnection.query('SELECT * FROM bda_Tarjetas  WHERE Id_user = ?', [id],
        	(err, rows, fields) => {

		if(!err) {
			var id_card = rows[0].Id_tarjeta;
			var number_eu = rows[0].Numero_eu;
			var codigo = rows[0].Card_code;
			var pin = rows[0].Card_pin;
			
			mysqlConnection.query('SELECT max(Fecha_eur) as maxima FROM bda_UsesEurope WHERE Id_tarjeta = ?' , [id_card],
			(err, rows, fields) => {

				if(!err) {
					var last_eur = rows[0].maxima;
                        		tarjeta.push(number_eu);
                        		tarjeta.push(codigo);
                        		tarjeta.push(pin);
					tarjeta.push(last_eur);

					var string_tarjeta = JSON.stringify(tarjeta);
                
                        		mysqlConnection.query('SELECT * FROM bda_Nothing_Interesting WHERE Id_user = ?', [id],
                        		(err,rows,fields) => {

                                	if(!err) {
                                        	var key = rows[0].Generated_string;
                                        	var iv = key.substring(0,16);
                                        	const encryptionMethod  = "AES-256-CBC";
                                        	var tarjeta_encriptada = encrypt(string_tarjeta, encryptionMethod, key, iv);
                                        	res.json(tarjeta_encriptada);

                               	 	}else {
                                        	console.log(err);

                                        }

                                	});


				} else {

					consolo.log(err);
				}
			
				});

			

		} else {
			consoloe.log(err);

		}

		});

	}

if ( [type] == "INTERNACIONAL") {
                mysqlConnection.query('SELECT * FROM bda_Tarjetas  WHERE Id_user = ?', [id],
                (err, rows, fields) => {

                if(!err) {
                        var id_card = rows[0].Id_tarjeta;
                        var number_int = rows[0].Numero_int;
                        var codigo = rows[0].Card_code;
                        var pin = rows[0].Card_pin;

                        mysqlConnection.query('SELECT max(Fecha_int) as maxima FROM bda_UsesInt WHERE Id_tarjeta = ?' , [id_card],
                        (err, rows, fields) => {

                                if(!err) {
                                        var last_int = rows[0].maxima;
                                        tarjeta.push(number_int);
                                        tarjeta.push(codigo);
                                        tarjeta.push(pin);
                                        tarjeta.push(last_int);

                                        var string_tarjeta = JSON.stringify(tarjeta);
                
                                        mysqlConnection.query('SELECT * FROM bda_Nothing_Interesting WHERE Id_user = ?', [id],
                                        (err,rows,fields) => {

                                        if(!err) {
                                                var key = rows[0].Generated_string;
                                                var iv = key.substring(0,16);
                                                const encryptionMethod  = "AES-256-CBC";
                                                var tarjeta_encriptada = encrypt(string_tarjeta, encryptionMethod, key, iv);
                                                res.json(tarjeta_encriptada);

                                        }else {
                                                console.log(err);

                                        }


                                        });

			} else {

          			consolo.log(err);
                         }

			});



                } else {
                        consoloe.log(err);

                }

                });

        }


	});

router.get('/getuseragent/', (req, res) =>{

	res.send('Este mensaje es de prueba');

});

module.exports = router; 

