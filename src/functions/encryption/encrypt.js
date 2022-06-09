//Funcion que encripta los datos de la tarjeta convertidos a string
const crypto = require('crypto');

function encrypt(plain_text, encrypt_method, key, iv) {
    var encryptor = crypto.createCipheriv (encrypt_method, key, iv);
    return encryptor.update (plain_text, 'utf8', 'base64') + encryptor.final('base64');
}

module.exports.encrypt = encrypt;