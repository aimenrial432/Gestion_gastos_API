const express = require('express');
const app = express();

//Settings
app.set('port', process.env.PORT || 3000);


//Midelewares
app.use(express.json());

//Routes
app.use(require('./routes/employees'));
app.use(require('./routes/tarjetas'));

//Starting

app.listen(app.get('port'), () => {
	console.log('Server listening on port', app.get('port'));
});


