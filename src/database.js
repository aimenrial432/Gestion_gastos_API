const mysql = require('mysql');

const mysqlConnection = mysql.createConnection({

host: 'localhost',
user: 'admin_wp_GG',
password: 'pass_adminwp123',
database: 'wp_Gestion_Gastos'

});

mysqlConnection.connect(function (err) {

	if(err){
		console.log(err);
		return;
	} else {

		console.log('Conexión establecida correctamente');
	}

});

module.exports = mysqlConnection;
