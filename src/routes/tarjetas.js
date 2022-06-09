const express = require('express'); //Para generar las rutas de la Api
const router = express.Router();

const encrypt = require('../functions/encryption/encrypt');  //Encriptar los datos de la tarjeta


const mysqlConnection = require('../database');  //Conexion a la base de datos

const _INTERNATIONAL = 'INTERNATIONAL';
const _EUROPE ='EUROPE';


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

	console.log(req.agente);
});

module.exports = router; 

