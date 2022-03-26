
const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database');

router.get('/allemp/', (req, res) => {
	mysqlConnection.query('SELECT Id_user, Nombre, Apellido, E_mail, Departamento_Id, Id_rol, Estado FROM bda_Empleados', 
(err, rows, fields) => {

	if(!err){
		res.json(rows);

	} else {
		console.log(err);
	}
});
	
});

router.get('/allemp/:id', (req, res) => {

	const { id } = req.params;
	
 mysqlConnection.query('SELECT Id_user, Nombre, Apellido, E_mail, Departamento_Id, Id_rol, Estado FROM bda_Empleados WHERE Id_user = ?', [id],
(err, rows, fields) => {

        if(!err){
                res.json(rows);
		

        } else {
                console.log(err);
        }
});

});


module.exports = router;
